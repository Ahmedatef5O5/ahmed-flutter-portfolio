import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/animations/fade_slide_animation.dart';
import '../../../../core/responsive/responsive.dart';
import '../../../../core/theme/app_colors.dart';

class HeroAvatar extends StatefulWidget {
  const HeroAvatar({super.key});

  @override
  State<HeroAvatar> createState() => _HeroAvatarState();
}

class _HeroAvatarState extends State<HeroAvatar> with TickerProviderStateMixin {
  late final AnimationController _rotCtrl;
  late final AnimationController _tiltCtrl;
  Offset _tilt = Offset.zero;

  @override
  void initState() {
    super.initState();
    _rotCtrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    )..repeat();
    _tiltCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 280),
    );
  }

  @override
  void dispose() {
    _rotCtrl.dispose();
    _tiltCtrl.dispose();
    super.dispose();
  }

  void _onHover(PointerHoverEvent e, BoxConstraints c) {
    final dx = (e.localPosition.dx / c.maxWidth - 0.5) * 2;
    final dy = (e.localPosition.dy / c.maxHeight - 0.5) * 2;
    setState(() => _tilt = Offset(dx.clamp(-1, 1), dy.clamp(-1, 1)));
    _tiltCtrl.forward();
  }

  void _onExit(_) {
    setState(() => _tilt = Offset.zero);
    _tiltCtrl.reverse();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final bg = Theme.of(context).scaffoldBackgroundColor;
    final r = Responsive.of(context);
    final size = r.value(mobile: 200.0, desktop: 300.0);
    final ringSize = size - 8;
    final maskSize = size - 20;
    final photoSize = size - 34;

    return FadeSlideAnimation(
      delay: const Duration(milliseconds: 350),
      child: Center(
        child: SizedBox(
          width: size,
          height: size,
          child: LayoutBuilder(
            builder: (context, constraints) {
              return MouseRegion(
                onHover: (e) => _onHover(e, constraints),
                onExit: _onExit,
                child: AnimatedBuilder(
                  animation: _tiltCtrl,
                  builder: (context, child) {
                    final eased = Curves.easeOutCubic.transform(
                      _tiltCtrl.value,
                    );
                    final rx = -_tilt.dy * 0.22 * eased;
                    final ry = _tilt.dx * 0.22 * eased;
                    return RepaintBoundary(
                      child: Transform(
                        alignment: Alignment.center,
                        transform:
                            Matrix4.identity()
                              ..setEntry(3, 2, 0.0015)
                              ..rotateX(rx)
                              ..rotateY(ry),
                        child: child,
                      ),
                    );
                  },
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      RepaintBoundary(
                        child: AnimatedBuilder(
                          animation: _rotCtrl,
                          builder:
                              (_, __) => Transform.rotate(
                                angle: _rotCtrl.value * 2 * math.pi,
                                child: Container(
                                  width: ringSize,
                                  height: ringSize,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    gradient: SweepGradient(
                                      colors: [
                                        AppColors.primary,
                                        AppColors.accent,
                                        Color(0x224B3FE0),
                                        AppColors.primary,
                                      ],
                                      stops: [0.0, 0.35, 0.7, 1.0],
                                    ),
                                  ),
                                ),
                              ),
                        ),
                      ),
                      Container(
                        width: maskSize,
                        height: maskSize,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: bg,
                        ),
                      ),
                      // Photo circle
                      Container(
                        width: photoSize,
                        height: photoSize,
                        clipBehavior: Clip.antiAlias,
                        decoration: const BoxDecoration(shape: BoxShape.circle),
                        child: Image.asset(
                          'assets/images/avatar.jpg',
                          fit: BoxFit.cover,
                          errorBuilder:
                              (_, __, ___) => Container(
                                color: cs.surfaceContainerHighest,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.person_rounded,
                                      size: 80,
                                      color: cs.primary.withValues(alpha: 0.35),
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      'Add avatar.jpg',
                                      style: TextStyle(
                                        color: cs.onSurfaceVariant.withValues(
                                          alpha: 0.4,
                                        ),
                                        fontSize: 11,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                        ),
                      ),
                      // Flutter Dev badge
                      Positioned(bottom: 14, right: 4, child: _FloatingBadge()),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _FloatingBadge extends StatefulWidget {
  @override
  State<_FloatingBadge> createState() => _FloatingBadgeState();
}

class _FloatingBadgeState extends State<_FloatingBadge>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _float;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2400),
    )..repeat(reverse: true);
    _float = Tween<double>(
      begin: -3,
      end: 3,
    ).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return AnimatedBuilder(
      animation: _float,
      builder:
          (_, child) => Transform.translate(
            offset: Offset(0, _float.value),
            child: child,
          ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: cs.surface,
          borderRadius: BorderRadius.circular(100),
          border: Border.all(color: cs.outline.withValues(alpha: 0.4)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.12),
              blurRadius: 16,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.flutter_dash_rounded,
              size: 16,
              color: Color(0xFF54C5F8),
            ),
            const SizedBox(width: 6),
            Text(
              'Flutter Dev',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 12,
                color: Color(0xFF54C5F8),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
