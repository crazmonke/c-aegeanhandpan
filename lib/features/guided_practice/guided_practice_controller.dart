import 'dart:async';

import 'package:flutter/foundation.dart';

import '../../core/audio/handpan_audio_engine.dart';
import '../../core/models/tune.dart';
import '../../widgets/handpan_board.dart';

enum GuidedMode { idle, demo, practice }

/// Drives Guided Practice's two modes: [GuidedMode.demo] auto-plays a tune
/// (sound + ripple, no input needed) and [GuidedMode.practice] waits for
/// the user to tap the right tone field for each note in order, one at a
/// time, before advancing.
class GuidedPracticeController extends ChangeNotifier {
  GuidedPracticeController(this._engine);

  final HandpanAudioEngine _engine;
  final HandpanBoardController board = HandpanBoardController();

  GuidedMode mode = GuidedMode.idle;
  Tune? tune;
  int index = 0;
  final List<Timer> _timers = [];

  bool get isPlaying => mode != GuidedMode.idle;

  String? get cueKey {
    final t = tune;
    if (mode != GuidedMode.practice || t == null || index >= t.notes.length) return null;
    return t.notes[index].fieldKey;
  }

  void _clearTimers() {
    for (final timer in _timers) {
      timer.cancel();
    }
    _timers.clear();
  }

  void stop() {
    _clearTimers();
    mode = GuidedMode.idle;
    index = 0;
    notifyListeners();
  }

  void listen(Tune selected) {
    stop();
    tune = selected;
    mode = GuidedMode.demo;
    notifyListeners();

    final beatSeconds = selected.beatSeconds;
    var elapsedMs = 0.0;
    for (var i = 0; i < selected.notes.length; i++) {
      final note = selected.notes[i];
      final isLast = i == selected.notes.length - 1;
      _timers.add(Timer(Duration(milliseconds: elapsedMs.round()), () {
        _engine.strike(note.fieldKey);
        board.trigger(note.fieldKey);
        if (isLast) {
          _timers.add(Timer(Duration(milliseconds: (note.beats * beatSeconds * 1000).round()), () {
            mode = GuidedMode.idle;
            notifyListeners();
          }));
        }
      }));
      elapsedMs += note.beats * beatSeconds * 1000;
    }
  }

  void practice(Tune selected) {
    stop();
    tune = selected;
    mode = GuidedMode.practice;
    index = 0;
    notifyListeners();
  }

  /// Feed every tap on the board here while practising. Correct taps play
  /// normally (the caller already triggers audio) and advance the cue;
  /// wrong taps just flash red without breaking the flow.
  void handleTap(String fieldKey) {
    final t = tune;
    if (mode != GuidedMode.practice || t == null) return;
    final expected = t.notes[index];
    if (fieldKey == expected.fieldKey) {
      index++;
      if (index >= t.notes.length) {
        mode = GuidedMode.idle;
      }
      notifyListeners();
    } else {
      board.flashWrong(fieldKey);
    }
  }

  @override
  void dispose() {
    _clearTimers();
    board.dispose();
    super.dispose();
  }
}
