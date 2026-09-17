import 'dart:async';
import 'dart:io' show Platform;

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:vibration/vibration.dart';

/// A longer, stronger tactile "strike" for tapping a tone field, meant to
/// read as a physical hit rather than a generic UI click.
///
/// Android gets true amplitude/duration control via the `vibration`
/// package. iOS has no public API for that (the Taptic Engine only exposes
/// fixed-style impacts), so there we chain a heavy impact with a couple of
/// fading follow-up impacts to approximate a longer, decaying hit.
class HandpanHaptics {
  HandpanHaptics._();

  static bool? _androidHasAmplitudeControl;
  static bool? _androidHasVibrator;

  static Future<void> strike({bool isDing = false}) async {
    if (kIsWeb) return;

    if (!kIsWeb && Platform.isAndroid) {
      _androidHasVibrator ??= await Vibration.hasVibrator();
      if (_androidHasVibrator ?? false) {
        _androidHasAmplitudeControl ??= await Vibration.hasAmplitudeControl();
        final duration = isDing ? 240 : 170;
        if (_androidHasAmplitudeControl ?? false) {
          unawaited(Vibration.vibrate(duration: duration, amplitude: 255));
        } else {
          unawaited(Vibration.vibrate(duration: duration));
        }
        return;
      }
    }

    // iOS, or an Android device reporting no vibrator: fall back to a
    // short decaying pattern of built-in haptic impacts.
    unawaited(HapticFeedback.heavyImpact());
    unawaited(Future.delayed(const Duration(milliseconds: 90), HapticFeedback.mediumImpact));
    if (isDing) {
      unawaited(Future.delayed(const Duration(milliseconds: 190), HapticFeedback.lightImpact));
    }
  }
}
