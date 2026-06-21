import 'package:flutter/material.dart';

class GridBackground extends StatelessWidget {
  final Widget child;
  final double dotSpacing;
  final double dotRadius;

  const GridBackground({
    super.key,
    required this.child,
    this.dotSpacing = 28,
    this.dotRadius = 1,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return RepaintBoundary(
      child: CustomPaint(
        painter: _GridPainter(
          dotColor: isDark ? const Color(0xFF2A2A40) : const Color(0xFFE0E0EE),
          dotSpacing: dotSpacing,
          dotRadius: dotRadius,
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

  const _GridPainter({
    required this.dotColor,
    required this.dotSpacing,
    required this.dotRadius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = dotColor;
    for (double x = 0; x < size.width; x += dotSpacing) {
      for (double y = 0; y < size.height; y += dotSpacing) {
        canvas.drawCircle(Offset(x, y), dotRadius, paint);
      }
    }
  }

  @override
  bool shouldRepaint(_GridPainter old) =>
      old.dotColor != dotColor ||
      old.dotSpacing != dotSpacing ||
      old.dotRadius != dotRadius;
}
