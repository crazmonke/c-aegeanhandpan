import '../../l10n/app_localizations.dart';

/// One selectable background-music track. To add another, drop the file
/// into `assets/audio/bgm/`, register it under `assets:` in
/// `pubspec.yaml` if it's a new folder, and append an entry here plus a
/// `bgmTrackNName` string in the ARB files.
class BgmTrack {
  const BgmTrack({
    required this.id,
    required this.assetPath,
    required this.nameOf,
  });

  final String id;
  final String assetPath;
  final String Function(AppLocalizations l10n) nameOf;
}

final List<BgmTrack> bgmCatalog = [
  BgmTrack(id: 'bgm1', assetPath: 'assets/audio/bgm/bgm1.mp3', nameOf: (l10n) => l10n.bgmTrack1Name),
  BgmTrack(id: 'bgm2', assetPath: 'assets/audio/bgm/bgm2.mp3', nameOf: (l10n) => l10n.bgmTrack2Name),
  BgmTrack(id: 'bgm3', assetPath: 'assets/audio/bgm/bgm3.mp3', nameOf: (l10n) => l10n.bgmTrack3Name),
  BgmTrack(id: 'bgm4', assetPath: 'assets/audio/bgm/bgm4.mp3', nameOf: (l10n) => l10n.bgmTrack4Name),
];

BgmTrack? bgmTrackById(String? id) {
  if (id == null) return null;
  for (final track in bgmCatalog) {
    if (track.id == id) return track;
  }
  return null;
}
