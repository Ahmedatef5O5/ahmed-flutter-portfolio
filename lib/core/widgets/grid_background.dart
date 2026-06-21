import 'package:flutter/material.dart';

class GridBackground extends StatelessWidget {
  final Widget child;
  final double dotSpacing;
  final double dotRadius;
  final double intensity;
  final double parallaxOffset;
  final Offset? spotlight;
  final double spotlightRadius;

  const GridBackground({
    super.key,
    required this.child,
    this.dotSpacing = 28,
    this.dotRadius = 1,
    this.intensity = 1.0,
    this.parallaxOffset = 0,
    this.spotlight,
    this.spotlightRadius = 220,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final baseColor =
        isDark ? const Color(0xFF2B2740) : const Color(0xFFE2DFEE);
    final hotColor = Theme.of(context).colorScheme.primary;

    return RepaintBoundary(
      child: CustomPaint(
        painter: _GridPainter(
          dotColor: baseColor.withValues(
            alpha: baseColor.a * intensity.clamp(0, 2),
          ),
          hotColor: hotColor,
          dotSpacing: dotSpacing,
          dotRadius: dotRadius,
          offsetY: parallaxOffset,
          spotlight: spotlight,
          spotlightRadius: spotlightRadius,
        ),
        child: child,
      ),
    );
  }
}

class _GridPainter extends CustomPainter {
  final Color dotColor;
  final Color hotColor;
  final double dotSpacing;
  final double dotRadius;
  final double offsetY;
  final Offset? spotlight;
  final double spotlightRadius;

  const _GridPainter({
    required this.dotColor,
    required this.hotColor,
    required this.dotSpacing,
    required this.dotRadius,
    this.offsetY = 0,
    this.spotlight,
    this.spotlightRadius = 220,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final basePaint = Paint()..color = dotColor;
    final wrappedOffset = offsetY % dotSpacing;
    final s = spotlight;
    final radiusSq = spotlightRadius * spotlightRadius;

    for (double x = 0; x < size.width; x += dotSpacing) {
      for (
        double y = -dotSpacing + wrappedOffset;
        y < size.height + dotSpacing;
        y += dotSpacing
      ) {
        final point = Offset(x, y);

        if (s == null) {
          canvas.drawCircle(point, dotRadius, basePaint);
          continue;
        }

        final distSq = (point - s).distanceSquared;
        if (distSq >= radiusSq) {
          canvas.drawCircle(point, dotRadius, basePaint);
          continue;
        }

        final t = (1 - (distSq / radiusSq)).clamp(0.0, 1.0);
        final glow = Curves.easeOutCubic.transform(t) * 0.65;
        canvas.drawCircle(
          point,
          dotRadius + (1.4 * glow),
          Paint()..color = Color.lerp(dotColor, hotColor, glow)!,
        );
      }
    }
  }

  @override
  bool shouldRepaint(_GridPainter old) =>
      old.dotColor != dotColor ||
      old.dotSpacing != dotSpacing ||
      old.dotRadius != dotRadius ||
      old.offsetY != offsetY ||
      old.spotlight != spotlight;
}
