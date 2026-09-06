import 'package:flutter/material.dart';

/// A widget that displays the current color scheme as a palette preview.
///
/// Useful for theme debugging and color scheme visualization.
class ColorPalettePreview extends StatelessWidget {
  /// Number of tonal variations to show.
  final int tones;

  /// Size of each color swatch.
  final double swatchSize;

  const ColorPalettePreview({
    super.key,
    this.tones = 6,
    this.swatchSize = 40,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    final colors = [
      _PaletteEntry('Primary', scheme.primary),
      _PaletteEntry('Secondary', scheme.secondary),
      _PaletteEntry('Tertiary', scheme.tertiary),
      _PaletteEntry('Error', scheme.error),
      _PaletteEntry('Surface', scheme.surface),
    ];

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Color Palette',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),
            ...colors.map((entry) => _buildColorRow(context, entry)),
          ],
        ),
      ),
    );
  }

  Widget _buildColorRow(BuildContext context, _PaletteEntry entry) {
    final hsl = HSLColor.fromColor(entry.color);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          SizedBox(
            width: 72,
            child: Text(
              entry.name,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
          ...List.generate(tones, (i) {
            final lightness = 0.15 + (i / (tones - 1)) * 0.7;
            final color = hsl.withLightness(lightness.clamp(0.0, 1.0)).toColor();

            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              width: swatchSize,
              height: swatchSize,
              margin: const EdgeInsets.only(right: 4),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: Colors.black.withOpacity(0.1),
                  width: 0.5,
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}

class _PaletteEntry {
  final String name;
  final Color color;

  const _PaletteEntry(this.name, this.color);
}
