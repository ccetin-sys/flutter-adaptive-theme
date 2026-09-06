import 'package:flutter/material.dart';

import '../src/adaptive_theme.dart';
import '../src/adaptive_theme_mode.dart';

/// A simple toggle button for switching between light and dark themes.
class ThemeToggleButton extends StatelessWidget {
  final double size;

  const ThemeToggleButton({super.key, this.size = 24});

  @override
  Widget build(BuildContext context) {
    final themeState = AdaptiveTheme.of(context);
    final isDark = themeState.mode.isDark(
      MediaQuery.platformBrightnessOf(context) == Brightness.dark,
    );

    return IconButton(
      icon: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: Icon(
          isDark ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
          key: ValueKey(isDark),
          size: size,
        ),
      ),
      onPressed: () => themeState.toggleTheme(),
      tooltip: isDark ? 'Switch to light mode' : 'Switch to dark mode',
    );
  }
}
