# 🎨 flutter-adaptive-theme

An adaptive theming engine for Flutter with dynamic color extraction, Material You support, and platform-aware styling.

[![Pub](https://img.shields.io/badge/pub-v2.1.0-blue)](https://pub.dev)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Flutter 3.19+](https://img.shields.io/badge/Flutter-3.19+-02569B.svg)](https://flutter.dev)

## Features

- 🎨 **Material You** — Dynamic color schemes from wallpaper or custom seed colors
- 🌗 **Auto dark mode** — Smooth transitions between light and dark themes
- 📱 **Platform-aware** — Cupertino styling on iOS, Material on Android
- 💾 **Persistent** — Theme preferences saved with SharedPreferences
- 🔌 **Extensible** — Custom color harmonization and contrast ratios

## Quick Start

```dart
import 'package:flutter_adaptive_theme/flutter_adaptive_theme.dart';

void main() async {
  final savedTheme = await AdaptiveTheme.getThemeMode();
  runApp(MyApp(savedTheme: savedTheme));
}

class MyApp extends StatelessWidget {
  final AdaptiveThemeMode? savedTheme;
  const MyApp({super.key, this.savedTheme});

  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      seedColor: Colors.deepPurple,
      builder: (light, dark) => MaterialApp(
        theme: light,
        darkTheme: dark,
        home: const HomeScreen(),
      ),
    );
  }
}
```

## Architecture

```
lib/
├── src/
│   ├── adaptive_theme.dart      # Main widget & state management
│   ├── color_extractor.dart     # Dynamic color extraction
│   ├── theme_builder.dart       # ColorScheme generation
│   ├── platform_adapter.dart    # iOS/Android style switching
│   └── persistence.dart         # SharedPreferences storage
├── flutter_adaptive_theme.dart  # Barrel export
└── widgets/
    ├── theme_toggle.dart        # Toggle button widget
    └── color_picker.dart        # Seed color picker
```

## License

MIT License
