import 'package:flutter/material.dart';

Widget projectIcon(String projectId, {double size = 52}) {
  return switch (projectId) {
    'social_mate' => _IconWrapper(
      size: size,
      gradient: const [Color(0xFF7C6FFF), Color(0xFF3B1FA3)],
      child: CustomPaint(size: Size(size, size), painter: _SocialMatePainter()),
    ),
    'newswave' => _IconWrapper(
      size: size,
      gradient: const [Color(0xFF1A73E8), Color(0xFF0D47A1)],
      child: CustomPaint(size: Size(size, size), painter: _NewsWavePainter()),
    ),
    'findash' => _IconWrapper(
      size: size,
      gradient: const [Color(0xFF00C853), Color(0xFF00695C)],
      child: CustomPaint(size: Size(size, size), painter: _FinDashPainter()),
    ),
    _ => _IconWrapper(
      size: size,
      gradient: const [Color(0xFF7C6FFF), Color(0xFF3B1FA3)],
      child: Icon(Icons.apps_rounded, color: Colors.white, size: size * 0.5),
    ),
  };
}

class _IconWrapper extends StatelessWidget {
  final double size;
  final List<Color> gradient;
  final Widget child;

  const _IconWrapper({
    required this.size,
    required this.gradient,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: gradient,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(size * 0.27),
        boxShadow: [
          BoxShadow(
            color: gradient[0].withValues(alpha: 0.4),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(size * 0.27),
        child: child,
      ),
    );
  }
}

class _SocialMatePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    final bubblePaint = Paint()..color = Colors.white.withValues(alpha: 0.92);
    final dotPaint = Paint()..color = const Color(0xFF6C63FF);
    final bubble2Paint = Paint()..color = Colors.white.withValues(alpha: 0.5);

    // Main bubble
    final mainBubble = RRect.fromRectAndRadius(
      Rect.fromLTWH(w * 0.15, h * 0.17, w * 0.6, h * 0.38),
      Radius.circular(w * 0.12),
    );
    canvas.drawRRect(mainBubble, bubblePaint);

    final tailPath =
        Path()
          ..moveTo(w * 0.18, h * 0.52)
          ..lineTo(w * 0.12, h * 0.64)
          ..lineTo(w * 0.30, h * 0.55)
          ..close();
    canvas.drawPath(tailPath, bubblePaint);

    final dotY = h * 0.36;
    for (int i = 0; i < 3; i++) {
      canvas.drawCircle(
        Offset(w * (0.33 + i * 0.14), dotY),
        w * 0.055,
        dotPaint,
      );
    }

    final smallBubble = RRect.fromRectAndRadius(
      Rect.fromLTWH(w * 0.48, h * 0.50, w * 0.38, h * 0.26),
      Radius.circular(w * 0.09),
    );
    canvas.drawRRect(smallBubble, bubble2Paint);

    final tail2 =
        Path()
          ..moveTo(w * 0.82, h * 0.72)
          ..lineTo(w * 0.88, h * 0.82)
          ..lineTo(w * 0.70, h * 0.76)
          ..close();
    canvas.drawPath(tail2, bubble2Paint);

    // Dots inside second bubble
    final dot2Paint = Paint()..color = Colors.white.withValues(alpha: 0.9);
    for (int i = 0; i < 2; i++) {
      canvas.drawCircle(
        Offset(w * (0.58 + i * 0.14), h * 0.63),
        w * 0.042,
        dot2Paint,
      );
    }
  }

  @override
  bool shouldRepaint(_) => false;
}

class _NewsWavePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    final pagePaint = Paint()..color = Colors.white.withValues(alpha: 0.92);
    final linePaint1 =
        Paint()
          ..color = const Color(0xFF1A73E8).withValues(alpha: 0.8)
          ..strokeWidth = w * 0.075
          ..strokeCap = StrokeCap.round;
    final linePaint2 =
        Paint()
          ..color = Colors.white.withValues(alpha: 0.55)
          ..strokeWidth = w * 0.06
          ..strokeCap = StrokeCap.round;

    // Page background
    final page = RRect.fromRectAndRadius(
      Rect.fromLTWH(w * 0.14, h * 0.12, w * 0.65, h * 0.7),
      Radius.circular(w * 0.08),
    );
    canvas.drawRRect(page, pagePaint);

    // Title line (bold blue)
    canvas.drawLine(
      Offset(w * 0.22, h * 0.26),
      Offset(w * 0.64, h * 0.26),
      linePaint1,
    );

    // Text lines
    for (int i = 0; i < 3; i++) {
      final y = h * (0.38 + i * 0.1);
      canvas.drawLine(
        Offset(w * 0.22, y),
        Offset(w * (i == 1 ? 0.70 : 0.64), y),
        linePaint2,
      );
    }

    // Wave at bottom of page
    final wavePaint =
        Paint()
          ..color = const Color(0xFF1A73E8).withValues(alpha: 0.55)
          ..style = PaintingStyle.fill;

    final wavePath = Path();
    final waveTop = h * 0.70;
    final waveBottom = h * 0.82;
    wavePath.moveTo(w * 0.14, waveTop);
    wavePath.cubicTo(
      w * 0.28,
      waveTop - h * 0.08,
      w * 0.44,
      waveTop + h * 0.08,
      w * 0.58,
      waveTop,
    );
    wavePath.cubicTo(
      w * 0.68,
      waveTop - h * 0.05,
      w * 0.74,
      waveTop + h * 0.02,
      w * 0.79,
      waveTop,
    );
    wavePath.lineTo(w * 0.79, waveBottom);
    wavePath.lineTo(w * 0.14, waveBottom);
    wavePath.close();

    // Clip wave to page rect
    canvas.save();
    canvas.clipRRect(page);
    canvas.drawPath(wavePath, wavePaint);
    canvas.restore();

    // Small accent dot top-right corner
    final accentPaint = Paint()..color = Colors.white.withValues(alpha: 0.85);
    canvas.drawCircle(Offset(w * 0.80, h * 0.20), w * 0.09, accentPaint);
    canvas.drawCircle(
      Offset(w * 0.80, h * 0.20),
      w * 0.05,
      Paint()..color = const Color(0xFF1A73E8),
    );
  }

  @override
  bool shouldRepaint(_) => false;
}

class _FinDashPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    final bars = [0.42, 0.62, 0.78, 0.55];
    final barWidth = w * 0.14;
    final baselineY = h * 0.82;
    final startX = w * 0.13;
    final gap = w * 0.185;

    final barOpacities = [0.5, 0.65, 0.88, 0.6];
    final barPaint = Paint()..style = PaintingStyle.fill;

    final List<Offset> tipPoints = [];

    for (int i = 0; i < bars.length; i++) {
      final barH = h * bars[i];
      final x = startX + i * (barWidth + gap);
      final y = baselineY - barH;

      barPaint.color = Colors.white.withValues(alpha: barOpacities[i]);

      final barRect = RRect.fromRectAndRadius(
        Rect.fromLTWH(x, y, barWidth, barH),
        Radius.circular(barWidth * 0.3),
      );
      canvas.drawRRect(barRect, barPaint);

      tipPoints.add(Offset(x + barWidth / 2, y));
    }

    canvas.drawLine(
      Offset(w * 0.10, baselineY),
      Offset(w * 0.90, baselineY),
      Paint()
        ..color = Colors.white.withValues(alpha: 0.3)
        ..strokeWidth = 1.2
        ..strokeCap = StrokeCap.round,
    );

    final linePaint =
        Paint()
          ..color = Colors.white
          ..strokeWidth = 2.0
          ..strokeCap = StrokeCap.round
          ..strokeJoin = StrokeJoin.round
          ..style = PaintingStyle.stroke;

    final linePath = Path()..moveTo(tipPoints[0].dx, tipPoints[0].dy);
    for (int i = 1; i < tipPoints.length; i++) {
      final prev = tipPoints[i - 1];
      final curr = tipPoints[i];
      final mid = Offset((prev.dx + curr.dx) / 2, (prev.dy + curr.dy) / 2);
      linePath.quadraticBezierTo(prev.dx, prev.dy, mid.dx, mid.dy);
    }
    linePath.lineTo(tipPoints.last.dx, tipPoints.last.dy);
    canvas.drawPath(linePath, linePaint);

    final dotPaint = Paint()..color = Colors.white;
    for (final pt in tipPoints) {
      canvas.drawCircle(pt, w * 0.045, dotPaint);
      canvas.drawCircle(
        pt,
        w * 0.022,
        Paint()..color = const Color(0xFF00C853),
      );
    }
  }

  @override
  bool shouldRepaint(_) => false;
}
