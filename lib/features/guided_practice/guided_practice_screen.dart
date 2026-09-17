import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/audio/handpan_audio_engine.dart';
import '../../core/constants/tone_field_catalog.dart';
import '../../core/constants/tune_catalog.dart';
import '../../core/models/tune.dart';
import '../../l10n/app_localizations.dart';
import '../../widgets/handpan_board.dart';
import 'guided_practice_controller.dart';

// See free_play_screen.dart - this screen also sits over the ambient
// video background, so it uses the same fixed light palette.
const _fg = Colors.white;
const _fgDim = Color(0xFFE7ECEA);

final ButtonStyle _lightOutlineStyle = OutlinedButton.styleFrom(
  foregroundColor: _fg,
  side: const BorderSide(color: Colors.white70),
);

class GuidedPracticeScreen extends StatefulWidget {
  const GuidedPracticeScreen({super.key});

  @override
  State<GuidedPracticeScreen> createState() => _GuidedPracticeScreenState();
}

class _GuidedPracticeScreenState extends State<GuidedPracticeScreen> {
  late final GuidedPracticeController _controller;
  late Tune _selectedTune;

  @override
  void initState() {
    super.initState();
    _selectedTune = tuneCatalog.first;
    _controller = GuidedPracticeController(context.read<HandpanAudioEngine>());
    _controller.addListener(_onControllerChanged);
  }

  void _onControllerChanged() => setState(() {});

  @override
  void dispose() {
    _controller.removeListener(_onControllerChanged);
    _controller.dispose();
    super.dispose();
  }

  String _noteLabel(AppLocalizations l10n, String fieldKey) {
    final field = toneFieldByKey(fieldKey);
    return field.isDing ? l10n.guidedNoteDing(field.note) : l10n.guidedNoteField(field.order!, field.note);
  }

  String _statusText(AppLocalizations l10n) {
    switch (_controller.mode) {
      case GuidedMode.idle:
        return l10n.guidedSubtitle;
      case GuidedMode.demo:
        return l10n.guidedListeningStatus(_selectedTune.nameOf(l10n));
      case GuidedMode.practice:
        final tune = _controller.tune!;
        if (_controller.index >= tune.notes.length) {
          return l10n.guidedCompleteStatus;
        }
        return l10n.guidedProgressStatus(
          _controller.index + 1,
          tune.notes.length,
          _noteLabel(l10n, tune.notes[_controller.index].fieldKey),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final engine = context.read<HandpanAudioEngine>();
    final isBusy = _controller.isPlaying;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
        child: Column(
          children: [
            Text(l10n.navGuided, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: _fg)),
            const SizedBox(height: 10),
            Expanded(
              child: Center(
                child: HandpanBoard(
                  fields: toneFieldCatalog,
                  showOrder: true,
                  cueKey: _controller.cueKey,
                  controller: _controller.board,
                  onTapField: (field) {
                    engine.strike(field.key);
                    _controller.handleTap(field.key);
                  },
                ),
              ),
            ),
            const SizedBox(height: 14),
            Text(
              _statusText(l10n),
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 13.5, color: _fgDim, height: 1.4),
            ),
            const SizedBox(height: 14),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                DropdownButton<Tune>(
                  value: _selectedTune,
                  // Fixed dark surface regardless of app theme - this menu
                  // pops up over the video background, and the light-theme
                  // surface color left the white item text unreadable.
                  dropdownColor: const Color(0xFF16212B),
                  style: const TextStyle(color: _fg, fontSize: 14),
                  iconEnabledColor: _fgDim,
                  onChanged: isBusy
                      ? null
                      : (tune) {
                          if (tune == null) return;
                          setState(() => _selectedTune = tune);
                        },
                  items: [
                    for (final tune in tuneCatalog)
                      DropdownMenuItem(
                        value: tune,
                        child: Text(tune.nameOf(l10n), style: const TextStyle(color: _fg)),
                      ),
                  ],
                ),
                if (!isBusy) ...[
                  OutlinedButton(
                    style: _lightOutlineStyle,
                    onPressed: () => _controller.listen(_selectedTune),
                    child: Text(l10n.guidedListenButton),
                  ),
                  FilledButton(onPressed: () => _controller.practice(_selectedTune), child: Text(l10n.guidedPracticeButton)),
                ] else
                  OutlinedButton(
                    style: _lightOutlineStyle,
                    onPressed: _controller.stop,
                    child: Text(l10n.guidedStopButton),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
