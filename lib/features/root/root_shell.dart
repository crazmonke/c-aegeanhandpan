import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/audio/bird_ambience_player.dart';
import '../../l10n/app_localizations.dart';
import '../../widgets/ambient_video_background.dart';
import '../free_play/free_play_screen.dart';
import '../guided_practice/guided_practice_screen.dart';
import '../settings/settings_screen.dart';

/// Hosts the 3-tab menu (자유 연주 / 따라 연주 / 설정). Free Play and Guided
/// Practice share one persistent ambient video background; Settings sits
/// on the plain theme background, so the video (and its bird audio) pauses
/// there instead of restarting every time the tab is revisited.
class RootShell extends StatefulWidget {
  const RootShell({super.key});

  @override
  State<RootShell> createState() => _RootShellState();
}

class _RootShellState extends State<RootShell> {
  static const _settingsIndex = 2;
  int _index = 0;

  void _setTab(int index) {
    setState(() => _index = index);
    context.read<BirdAmbiencePlayer>().setActive(index != _settingsIndex);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.read<BirdAmbiencePlayer>().setActive(_index != _settingsIndex);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final showBackground = _index != _settingsIndex;

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Visibility(
            visible: showBackground,
            maintainState: true,
            maintainAnimation: true,
            maintainSize: true,
            child: Stack(
              fit: StackFit.expand,
              children: [
                AmbientVideoBackground(active: showBackground),
                Container(color: Colors.black.withValues(alpha: isDark ? 0.45 : 0.25)),
              ],
            ),
          ),
          IndexedStack(
            index: _index,
            children: const [
              FreePlayScreen(),
              GuidedPracticeScreen(),
              SettingsScreen(),
            ],
          ),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: _setTab,
        destinations: [
          NavigationDestination(
            icon: const Icon(Icons.pan_tool_outlined),
            selectedIcon: const Icon(Icons.pan_tool),
            label: l10n.navFreePlay,
          ),
          NavigationDestination(
            icon: const Icon(Icons.school_outlined),
            selectedIcon: const Icon(Icons.school),
            label: l10n.navGuided,
          ),
          NavigationDestination(
            icon: const Icon(Icons.settings_outlined),
            selectedIcon: const Icon(Icons.settings),
            label: l10n.navSettings,
          ),
        ],
      ),
    );
  }
}
