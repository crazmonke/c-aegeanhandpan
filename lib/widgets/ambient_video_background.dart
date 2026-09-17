import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

/// Full-bleed looping forest video, played muted - its bird-call audio is
/// extracted and handled separately by `BirdAmbiencePlayer` so it can get
/// its own volume control. Two controllers of the same clip are cross-
/// faded into each other near the loop point so the picture doesn't cut
/// abruptly from the last frame back to the first.
///
/// [active] controls play/pause (used to silence/freeze it while the
/// Settings tab is in front) without tearing down and reinitializing the
/// controllers.
class AmbientVideoBackground extends StatefulWidget {
  const AmbientVideoBackground({super.key, required this.active});

  final bool active;

  @override
  State<AmbientVideoBackground> createState() => _AmbientVideoBackgroundState();
}

class _AmbientVideoBackgroundState extends State<AmbientVideoBackground>
    with SingleTickerProviderStateMixin {
  static const _asset = 'assets/video/forest_ambience.mp4';
  static const _fadeDuration = Duration(milliseconds: 700);

  late final List<VideoPlayerController> _controllers = [
    VideoPlayerController.asset(_asset),
    VideoPlayerController.asset(_asset),
  ];
  late final AnimationController _crossfade = AnimationController(
    vsync: this,
    duration: _fadeDuration,
  );

  bool _ready = false;
  int _frontIndex = 0;
  bool _crossfading = false;

  @override
  void initState() {
    super.initState();
    Future.wait(_controllers.map((c) => c.initialize())).then((_) {
      if (!mounted) return;
      for (final c in _controllers) {
        c.setVolume(0);
      }
      setState(() => _ready = true);
      _controllers[_frontIndex].addListener(_watchFrontController);
      if (widget.active) _controllers[_frontIndex].play();
    });
  }

  @override
  void didUpdateWidget(covariant AmbientVideoBackground oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (_ready && widget.active != oldWidget.active) {
      if (widget.active) {
        _controllers[_frontIndex].play();
      } else {
        for (final c in _controllers) {
          c.pause();
        }
      }
    }
  }

  void _watchFrontController() {
    if (_crossfading || !widget.active) return;
    final front = _controllers[_frontIndex];
    final value = front.value;
    if (!value.isInitialized || value.duration == Duration.zero) return;
    final remaining = value.duration - value.position;
    if (remaining <= _fadeDuration) {
      _startCrossfade();
    }
  }

  Future<void> _startCrossfade() async {
    _crossfading = true;
    final backIndex = 1 - _frontIndex;
    final back = _controllers[backIndex];
    await back.seekTo(Duration.zero);
    await back.play();

    _crossfade.forward(from: 0).whenComplete(() async {
      final oldFront = _controllers[_frontIndex];
      oldFront.removeListener(_watchFrontController);
      await oldFront.pause();
      await oldFront.seekTo(Duration.zero);

      setState(() {
        _frontIndex = backIndex;
        _crossfading = false;
      });
      _controllers[_frontIndex].addListener(_watchFrontController);
      _crossfade.value = 0;
    });
  }

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    _crossfade.dispose();
    super.dispose();
  }

  Widget _layer(VideoPlayerController controller) {
    return SizedBox.expand(
      child: FittedBox(
        fit: BoxFit.cover,
        child: SizedBox(
          width: controller.value.size.width,
          height: controller.value.size.height,
          child: VideoPlayer(controller),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (!_ready) return const ColoredBox(color: Colors.black);
    final backIndex = 1 - _frontIndex;
    return AnimatedBuilder(
      animation: _crossfade,
      builder: (context, _) {
        return Stack(
          fit: StackFit.expand,
          children: [
            _layer(_controllers[_frontIndex]),
            if (_crossfading)
              Opacity(
                opacity: _crossfade.value,
                child: _layer(_controllers[backIndex]),
              ),
          ],
        );
      },
    );
  }
}
