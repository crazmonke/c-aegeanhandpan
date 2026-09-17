import '../models/tone_field.dart';

// Ring radius / field radius / Ding radius, all as a fraction of the
// board's own radius - matches the original web prototype's layout
// (shell r=205, ring r=145, field r=33, ding r=58 on a 440x440 canvas).
const double _ring = 0.7073;
const double _diag = 0.5003; // _ring * cos(45deg)
const double _fieldRadius = 0.161;
const double _dingRadius = 0.2829;

/// Ding (C3, center) + 8 tone fields (E3 G3 B3 C4 E4 F#4 G4 B4), placed in
/// the standard zig-zag handpan layout mapped onto 8 compass points.
const List<ToneField> toneFieldCatalog = [
  ToneField(
    key: 'ding',
    note: 'C3',
    frequencyHz: 130.813,
    isDing: true,
    dx: 0,
    dy: 0,
    radiusFraction: _dingRadius,
    assetPath: 'assets/audio/note_ding.wav',
  ),
  ToneField(
    key: '1',
    note: 'E3',
    frequencyHz: 164.814,
    isDing: false,
    order: 1,
    dx: 0,
    dy: _ring,
    radiusFraction: _fieldRadius,
    assetPath: 'assets/audio/note_1.wav',
  ),
  ToneField(
    key: '2',
    note: 'G3',
    frequencyHz: 195.998,
    isDing: false,
    order: 2,
    dx: -_diag,
    dy: _diag,
    radiusFraction: _fieldRadius,
    assetPath: 'assets/audio/note_2.wav',
  ),
  ToneField(
    key: '3',
    note: 'B3',
    frequencyHz: 246.942,
    isDing: false,
    order: 3,
    dx: _diag,
    dy: _diag,
    radiusFraction: _fieldRadius,
    assetPath: 'assets/audio/note_3.wav',
  ),
  ToneField(
    key: '4',
    note: 'C4',
    frequencyHz: 261.626,
    isDing: false,
    order: 4,
    dx: -_ring,
    dy: 0,
    radiusFraction: _fieldRadius,
    assetPath: 'assets/audio/note_4.wav',
  ),
  ToneField(
    key: '5',
    note: 'E4',
    frequencyHz: 329.628,
    isDing: false,
    order: 5,
    dx: _ring,
    dy: 0,
    radiusFraction: _fieldRadius,
    assetPath: 'assets/audio/note_5.wav',
  ),
  ToneField(
    key: '6',
    note: 'F#4',
    frequencyHz: 369.994,
    isDing: false,
    order: 6,
    dx: -_diag,
    dy: -_diag,
    radiusFraction: _fieldRadius,
    assetPath: 'assets/audio/note_6.wav',
  ),
  ToneField(
    key: '7',
    note: 'G4',
    frequencyHz: 391.995,
    isDing: false,
    order: 7,
    dx: _diag,
    dy: -_diag,
    radiusFraction: _fieldRadius,
    assetPath: 'assets/audio/note_7.wav',
  ),
  ToneField(
    key: '8',
    note: 'B4',
    frequencyHz: 493.883,
    isDing: false,
    order: 8,
    dx: 0,
    dy: -_ring,
    radiusFraction: _fieldRadius,
    assetPath: 'assets/audio/note_8.wav',
  ),
];

ToneField toneFieldByKey(String key) =>
    toneFieldCatalog.firstWhere((field) => field.key == key);
