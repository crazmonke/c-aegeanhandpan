import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../core/haptics/handpan_haptics.dart';
import '../core/models/tone_field.dart';

const _engraveColor = Color(0xFF3A2A12);
const _panHighlight = Color(0xFFF6E3AB);
const _panBase = Color(0xFFCAA457);
const _panDark = Color(0xFF8A6A35);
const _badgeBg = Color(0xFFFFF6E2);
const _wrongColor = Color(0xFFE0554A);

/// Imperative handle for triggering a tone field's ripple/wrong animation
/// from outside a direct tap - used by Guided Practice's "listen first"
/// auto-play (ripple) and its "play along" mode (wrong-note flash).
class HandpanBoardController extends ChangeNotifier {
  ({String key, int seq})? _lastTrigger;
  ({String key, int seq})? _lastWrong;
  int _seq = 0;

  ({String key, int seq})? get lastTrigger => _lastTrigger;
  ({String key, int seq})? get lastWrong => _lastWrong;

  void trigger(String key) {
    _lastTrigger = (key: key, seq: _seq++);
    notifyListeners();
  }

  void flashWrong(String key) {
    _lastWrong = (key: key, seq: _seq++);
    notifyListeners();
  }
}

/// The circular handpan: a Ding plus 8 tone fields, laid out exactly like
/// the physical instrument. Shared by Free Play and Guided Practice - the
/// latter also drives [cueKey] (which field pulses next) and [controller]
/// (programmatic ripple/wrong-flash during demo/practice playback).
class HandpanBoard extends StatefulWidget {
  const HandpanBoard({
    super.key,
    required this.fields,
    required this.onTapField,
    this.showLabels = true,
    this.showOrder = false,
    this.cueKey,
    this.controller,
  });

  final List<ToneField> fields;
  final ValueChanged<ToneField> onTapField;
  final bool showLabels;
  final bool showOrder;
  final String? cueKey;
  final HandpanBoardController? controller;

  @override
  State<HandpanBoard> createState() => _HandpanBoardState();
}

class _HandpanBoardState extends State<HandpanBoard> {
  final Map<String, GlobalKey<_ToneFieldDotState>> _dotKeys = {};

  @override
  void initState() {
    super.initState();
    for (final field in widget.fields) {
      _dotKeys[field.key] = GlobalKey<_ToneFieldDotState>();
    }
    widget.controller?.addListener(_handleControllerEvent);
  }

  @override
  void didUpdateWidget(covariant HandpanBoard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.controller != widget.controller) {
      oldWidget.controller?.removeListener(_handleControllerEvent);
      widget.controller?.addListener(_handleControllerEvent);
    }
  }

  @override
  void dispose() {
    widget.controller?.removeListener(_handleControllerEvent);
    super.dispose();
  }

  void _handleControllerEvent() {
    final controller = widget.controller;
    if (controller == null) return;
    final trigger = controller.lastTrigger;
    if (trigger != null) {
      _dotKeys[trigger.key]?.currentState?.playRipple();
    }
    final wrong = controller.lastWrong;
    if (wrong != null) {
      _dotKeys[wrong.key]?.currentState?.flashWrong();
    }
  }

  @override
  Widget build(BuildContext context) {
    final accent = Theme.of(context).colorScheme.primary;
    return LayoutBuilder(
      builder: (context, constraints) {
        final side = math.min(constraints.maxWidth, constraints.maxHeight);
        final half = side / 2;
        return SizedBox(
          width: side,
          height: side,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: side,
                height: side,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    center: Alignment(-0.32, -0.4),
                    radius: 0.95,
                    colors: [_panHighlight, _panBase, _panDark],
                    stops: [0.0, 0.55, 1.0],
                  ),
                  boxShadow: [
                    BoxShadow(color: Colors.black38, blurRadius: 24, offset: Offset(0, 12)),
                  ],
                ),
              ),
              Container(
                width: side * 0.965,
                height: side * 0.965,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: _panDark.withValues(alpha: 0.35), width: 1.2),
                ),
              ),
              // Ding halo, echoing the double gold ring on the real instrument.
              Container(
                width: side * 0.36,
                height: side * 0.36,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: _panHighlight.withValues(alpha: 0.75), width: 1.5),
                ),
              ),
              for (final field in widget.fields)
                Positioned(
                  left: half + field.dx * half - field.radiusFraction * half,
                  top: half + field.dy * half - field.radiusFraction * half,
                  width: field.radiusFraction * half * 2,
                  height: field.radiusFraction * half * 2,
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTapDown: (_) {
                      _dotKeys[field.key]?.currentState?.playRipple();
                      HandpanHaptics.strike(isDing: field.isDing);
                      widget.onTapField(field);
                    },
                    child: _ToneFieldDot(
                      key: _dotKeys[field.key],
                      field: field,
                      showLabel: widget.showLabels,
                      showOrder: widget.showOrder && field.order != null,
                      cued: widget.cueKey == field.key,
                      accentColor: accent,
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}

class _ToneFieldDot extends StatefulWidget {
  const _ToneFieldDot({
    super.key,
    required this.field,
    required this.showLabel,
    required this.showOrder,
    required this.cued,
    required this.accentColor,
  });

  final ToneField field;
  final bool showLabel;
  final bool showOrder;
  final bool cued;
  final Color accentColor;

  @override
  State<_ToneFieldDot> createState() => _ToneFieldDotState();
}

class _ToneFieldDotState extends State<_ToneFieldDot> with TickerProviderStateMixin {
  late final AnimationController _rippleCtrl =
      AnimationController(vsync: this, duration: const Duration(milliseconds: 850));
  late final AnimationController _wrongCtrl =
      AnimationController(vsync: this, duration: const Duration(milliseconds: 260));
  late final AnimationController _cueCtrl =
      AnimationController(vsync: this, duration: const Duration(milliseconds: 1000));

  @override
  void initState() {
    super.initState();
    if (widget.cued) _cueCtrl.repeat(reverse: true);
  }

  @override
  void didUpdateWidget(covariant _ToneFieldDot oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.cued != oldWidget.cued) {
      if (widget.cued) {
        _cueCtrl.repeat(reverse: true);
      } else {
        _cueCtrl.stop();
        _cueCtrl.value = 0;
      }
    }
  }

  @override
  void dispose() {
    _rippleCtrl.dispose();
    _wrongCtrl.dispose();
    _cueCtrl.dispose();
    super.dispose();
  }

  void playRipple() => _rippleCtrl.forward(from: 0);

  void flashWrong() => _wrongCtrl.forward(from: 0);

  @override
  Widget build(BuildContext context) {
    final field = widget.field;
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: const RadialGradient(
              center: Alignment(-0.28, -0.36),
              radius: 0.9,
              colors: [_panDark, _panBase, _panHighlight],
              stops: [0.0, 0.62, 1.0],
            ),
            border: Border.all(color: _panDark.withValues(alpha: 0.4), width: 1.4),
          ),
        ),
        AnimatedBuilder(
          animation: _cueCtrl,
          builder: (context, _) {
            if (!widget.cued) return const SizedBox.shrink();
            final opacity = 0.45 + _cueCtrl.value * 0.55;
            return IgnorePointer(
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: widget.accentColor.withValues(alpha: opacity), width: 4),
                ),
              ),
            );
          },
        ),
        AnimatedBuilder(
          animation: _rippleCtrl,
          builder: (context, _) {
            final t = _rippleCtrl.value;
            if (t <= 0 || t >= 1) return const SizedBox.shrink();
            return IgnorePointer(
              child: Opacity(
                opacity: (1 - t) * 0.6,
                child: Transform.scale(
                  scale: 0.5 + t * 1.2,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: widget.accentColor, width: 2),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
        AnimatedBuilder(
          animation: _wrongCtrl,
          builder: (context, _) {
            final t = _wrongCtrl.value;
            if (t <= 0) return const SizedBox.shrink();
            return IgnorePointer(
              child: Opacity(
                opacity: 1 - t,
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: _wrongColor, width: 4),
                  ),
                ),
              ),
            );
          },
        ),
        if (widget.showLabel)
          Text(
            field.note,
            style: const TextStyle(
              fontFamily: 'monospace',
              fontWeight: FontWeight.w600,
              fontSize: 13,
              color: _engraveColor,
            ),
          ),
        if (widget.showOrder)
          Positioned(
            left: 2,
            top: 2,
            child: Container(
              width: 18,
              height: 18,
              alignment: Alignment.center,
              decoration: const BoxDecoration(shape: BoxShape.circle, color: _badgeBg),
              child: Text(
                '${field.order}',
                style: const TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: _engraveColor,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
