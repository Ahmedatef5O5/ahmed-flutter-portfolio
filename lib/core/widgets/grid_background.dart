import 'package:flutter/material.dart';

class GridBackground extends StatelessWidget {
  final Widget child;
  final double dotSpacing;
  final double dotRadius;
  final double intensity;
  final double parallaxOffset;

  const GridBackground({
    super.key,
    required this.child,
    this.dotSpacing = 28,
    this.dotRadius = 1,
    this.intensity = 1.0,
    this.parallaxOffset = 0,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final baseColor =
        isDark ? const Color(0xFF2B2740) : const Color(0xFFE2DFEE);

    return RepaintBoundary(
      child: CustomPaint(
        painter: _GridPainter(
          dotColor: baseColor.withValues(
            alpha: baseColor.a * intensity.clamp(0, 2),
          ),
          dotSpacing: dotSpacing,
          dotRadius: dotRadius,
          offsetY: parallaxOffset,
        ),
        child: child,
      ),
    );
  }
}

class _GridPainter extends CustomPainter {
  final Color dotColor;
  final double dotSpacing;
  final double dotRadius;
  final double offsetY;

  const _GridPainter({
    required this.dotColor,
    required this.dotSpacing,
    required this.dotRadius,
    this.offsetY = 0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = dotColor;
    final wrappedOffset = offsetY % dotSpacing;

    for (double x = 0; x < size.width; x += dotSpacing) {
      for (
        double y = -dotSpacing + wrappedOffset;
        y < size.height + dotSpacing;
        y += dotSpacing
      ) {
        canvas.drawCircle(Offset(x, y), dotRadius, paint);
      }
    }
  }

  @override
  bool shouldRepaint(_GridPainter old) =>
      old.dotColor != dotColor ||
      old.dotSpacing != dotSpacing ||
      old.dotRadius != dotRadius ||
      old.offsetY != offsetY;
}
