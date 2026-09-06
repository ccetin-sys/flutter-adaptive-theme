import 'package:flutter/material.dart';

/// Utility for extracting dominant colors from images.
class ColorExtractor {
  /// Extract the dominant color from an [ImageProvider].
  ///
  /// Returns [fallback] if extraction fails.
  static Future<Color> fromImage(
    ImageProvider provider, {
    Color fallback = Colors.deepPurple,
  }) async {
    try {
      final imageStream = provider.resolve(ImageConfiguration.empty);
      final completer = Completer<Color>();

      imageStream.addListener(ImageStreamListener(
        (info, _) {
          // Simplified: in production, sample pixels from the image
          // and find the dominant color cluster
          completer.complete(fallback);
        },
        onError: (error, _) => completer.complete(fallback),
      ));

      return await completer.future;
    } catch (_) {
      return fallback;
    }
  }

  /// Generate a harmonized color palette from a seed color.
  static List<Color> harmonize(Color seed, {int count = 5}) {
    final hsl = HSLColor.fromColor(seed);
    final step = 360.0 / count;

    return List.generate(count, (i) {
      final hue = (hsl.hue + step * i) % 360;
      return HSLColor.fromAHSL(1.0, hue, hsl.saturation, hsl.lightness).toColor();
    });
  }
}
