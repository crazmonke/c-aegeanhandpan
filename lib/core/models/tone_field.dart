/// One playable spot on the handpan: the central Ding or one of the 8
/// surrounding tone fields.
class ToneField {
  const ToneField({
    required this.key,
    required this.note,
    required this.frequencyHz,
    required this.isDing,
    required this.dx,
    required this.dy,
    required this.radiusFraction,
    required this.assetPath,
    this.order,
  });

  /// Stable id used everywhere (audio map, tune sequences, animations):
  /// `'ding'` or `'1'`..`'8'`.
  final String key;

  /// Display note name, e.g. `'F#4'`.
  final String note;

  /// Reference frequency in Hz (used only for documentation/debugging - the
  /// actual pitch lives in the pre-rendered sample at [assetPath]).
  final double frequencyHz;

  final bool isDing;

  /// Offset from the board's center, as a fraction of the board's radius
  /// (range roughly -1..1). The Ding sits at (0, 0).
  final double dx;
  final double dy;

  /// This field's own radius, as a fraction of the board's radius.
  final double radiusFraction;

  /// The pre-rendered one-shot sample for this field.
  final String assetPath;

  /// Play order in the zig-zag layout (1-8), or null for the Ding.
  final int? order;
}
