import '../models/tune.dart';

/// Guided-practice songbook. These are original short etudes written for
/// this instrument's 9-tone scale (not transcriptions of existing songs).
/// To add a new one: append a [Tune] here - the tune picker, "listen
/// first" playback and "play along" practice mode all pick it up
/// automatically.
final List<Tune> tuneCatalog = [
  Tune(
    id: 'ripple',
    tempoBpm: 96,
    nameOf: (l10n) => l10n.tuneRippleName,
    notes: const [
      TuneNote('ding', 1),
      TuneNote('1', 1),
      TuneNote('2', 1),
      TuneNote('4', 1),
      TuneNote('5', 1),
      TuneNote('7', 1),
      TuneNote('8', 2),
      TuneNote('7', 1),
      TuneNote('5', 1),
      TuneNote('4', 1),
      TuneNote('2', 1),
      TuneNote('1', 1),
      TuneNote('ding', 2),
    ],
  ),
  Tune(
    id: 'evening',
    tempoBpm: 84,
    nameOf: (l10n) => l10n.tuneEveningName,
    notes: const [
      TuneNote('1', 1),
      TuneNote('2', 1),
      TuneNote('4', 2),
      TuneNote('5', 1),
      TuneNote('6', 1),
      TuneNote('5', 2),
      TuneNote('4', 1),
      TuneNote('2', 1),
      TuneNote('1', 2),
      TuneNote('ding', 3),
    ],
  ),
  Tune(
    id: 'seed',
    tempoBpm: 100,
    nameOf: (l10n) => l10n.tuneSeedName,
    notes: const [
      TuneNote('ding', 1),
      TuneNote('4', 1),
      TuneNote('6', 1),
      TuneNote('5', 1),
      TuneNote('2', 1),
      TuneNote('ding', 2),
    ],
  ),
];
