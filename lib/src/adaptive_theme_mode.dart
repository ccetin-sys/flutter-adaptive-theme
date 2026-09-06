/// Enum representing the available theme modes.
enum AdaptiveThemeMode {
  /// Always use the light theme.
  light,

  /// Always use the dark theme.
  dark,

  /// Follow the system theme setting.
  system;

  /// Convert to string for persistence.
  String toJson() => name;

  /// Parse from a stored string.
  static AdaptiveThemeMode fromJson(String value) {
    return AdaptiveThemeMode.values.firstWhere(
      (mode) => mode.name == value,
      orElse: () => AdaptiveThemeMode.system,
    );
  }

  /// Whether this mode resolves to dark in the given context.
  bool isDark(bool platformBrightnessDark) {
    switch (this) {
      case AdaptiveThemeMode.light:
        return false;
      case AdaptiveThemeMode.dark:
        return true;
      case AdaptiveThemeMode.system:
        return platformBrightnessDark;
    }
  }
}
