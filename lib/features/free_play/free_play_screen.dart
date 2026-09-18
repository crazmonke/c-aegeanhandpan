import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../app/app_settings_controller.dart';
import '../../core/audio/handpan_audio_engine.dart';
import '../../core/constants/tone_field_catalog.dart';
import '../../l10n/app_localizations.dart';
import '../../widgets/handpan_board.dart';

// This screen sits over the ambient video background (see RootShell), so
// its text always uses a light, high-contrast palette regardless of the
// app's light/dark theme setting.
const _fg = Colors.white;
const _fgDim = Color(0xFFE7ECEA);

class FreePlayScreen extends StatefulWidget {
  const FreePlayScreen({super.key});

  @override
  State<FreePlayScreen> createState() => _FreePlayScreenState();
}

class _FreePlayScreenState extends State<FreePlayScreen> {
  bool _showLabels = true;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final engine = context.watch<HandpanAudioEngine>();
    final settings = context.read<AppSettingsController>();

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
        child: Column(
          children: [
            Text(
              l10n.appTitle,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: _fg),
            ),
            const SizedBox(height: 6),
            Text(
              l10n.freePlayCredit,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 13.5, color: _fgDim, height: 1.4),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Center(
                child: HandpanBoard(
                  fields: toneFieldCatalog,
                  showLabels: _showLabels,
                  onTapField: (field) => engine.strike(field.key),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 20,
              runSpacing: 10,
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                _LabeledSwitch(
                  label: l10n.freePlayLabelsToggle,
                  value: _showLabels,
                  onChanged: (v) => setState(() => _showLabels = v),
                ),
                _LabeledSwitch(
                  label: l10n.freePlayReverbToggle,
                  value: engine.reverbEnabled,
                  onChanged: (v) {
                    engine.setReverbEnabled(v);
                    settings.setReverbEnabled(v);
                  },
                ),
                SizedBox(
                  width: 170,
                  child: Row(
                    children: [
                      Text(l10n.freePlayVolumeLabel, style: const TextStyle(fontSize: 12.5, color: _fgDim)),
                      Expanded(
                        child: Slider(
                          value: engine.volume,
                          onChanged: (v) {
                            engine.setVolume(v);
                            settings.setFreePlayVolume(v);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              l10n.freePlayFooterCaption,
              style: const TextStyle(fontSize: 10.5, color: _fgDim, letterSpacing: 0.4),
            ),
          ],
        ),
      ),
    );
  }
}

class _LabeledSwitch extends StatelessWidget {
  const _LabeledSwitch({required this.label, required this.value, required this.onChanged});

  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(label, style: const TextStyle(fontSize: 12.5, color: _fgDim)),
        Switch(value: value, onChanged: onChanged),
      ],
    );
  }
}
