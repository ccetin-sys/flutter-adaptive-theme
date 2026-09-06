import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'adaptive_theme_mode.dart';
import 'theme_builder.dart';

/// A widget that provides adaptive theming to its descendants.
///
/// Wraps [MaterialApp] and manages light/dark theme switching
/// with persistence via [SharedPreferences].
class AdaptiveTheme extends StatefulWidget {
  /// The seed color used to generate the color scheme.
  final Color seedColor;

  /// Builder that receives the generated light and dark themes.
  final Widget Function(ThemeData light, ThemeData dark) builder;

  /// Initial theme mode. Defaults to [AdaptiveThemeMode.system].
  final AdaptiveThemeMode initialMode;

  const AdaptiveTheme({
    super.key,
    required this.seedColor,
    required this.builder,
    this.initialMode = AdaptiveThemeMode.system,
  });

  /// Retrieve the saved theme mode from SharedPreferences.
  static Future<AdaptiveThemeMode> getThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    final stored = prefs.getString('adaptive_theme_mode');
    if (stored == null) return AdaptiveThemeMode.system;
    return AdaptiveThemeMode.fromJson(stored);
  }

  /// Access the [AdaptiveThemeState] from a descendant widget.
  static AdaptiveThemeState of(BuildContext context) {
    final state = context.findAncestorStateOfType<AdaptiveThemeState>();
    assert(state != null, 'No AdaptiveTheme found in context');
    return state!;
  }

  @override
  State<AdaptiveTheme> createState() => AdaptiveThemeState();
}

/// State for [AdaptiveTheme], provides methods to change theme.
class AdaptiveThemeState extends State<AdaptiveTheme> {
  late AdaptiveThemeMode _mode;
  late ThemeBuilder _themeBuilder;

  AdaptiveThemeMode get mode => _mode;

  @override
  void initState() {
    super.initState();
    _mode = widget.initialMode;
    _themeBuilder = ThemeBuilder(seedColor: widget.seedColor);
  }

  /// Change the theme mode and persist the choice.
  Future<void> setThemeMode(AdaptiveThemeMode mode) async {
    setState(() => _mode = mode);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('adaptive_theme_mode', mode.toJson());
  }

  /// Toggle between light and dark modes.
  Future<void> toggleTheme() async {
    final newMode = _mode == AdaptiveThemeMode.light
        ? AdaptiveThemeMode.dark
        : AdaptiveThemeMode.light;
    await setThemeMode(newMode);
  }

  /// Update the seed color dynamically.
  void updateSeedColor(Color color) {
    setState(() {
      _themeBuilder = ThemeBuilder(seedColor: color);
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(
      _themeBuilder.buildLight(),
      _themeBuilder.buildDark(),
    );
  }
}
