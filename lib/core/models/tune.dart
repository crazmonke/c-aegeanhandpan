import '../../l10n/app_localizations.dart';

/// One note in a guided [Tune]: which tone field to strike and how long
/// (in beats) it holds before the next note.
class TuneNote {
  const TuneNote(this.fieldKey, this.beats);

  final String fieldKey;
  final double beats;
}

/// A short original practice piece written for the C Aegean scale, used by
/// Guided Practice. Add a new entry to `tuneCatalog` to extend the
/// songbook - nothing else needs to change.
class Tune {
  const Tune({
    required this.id,
    required this.tempoBpm,
    required this.notes,
    required this.nameOf,
  });

  final String id;
  final int tempoBpm;
  final List<TuneNote> notes;
  final String Function(AppLocalizations l10n) nameOf;

  double get beatSeconds => 60 / tempoBpm;
}
