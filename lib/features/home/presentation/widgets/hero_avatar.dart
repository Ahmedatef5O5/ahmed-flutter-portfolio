import 'package:flutter/material.dart';
import '../../../../core/animations/fade_slide_animation.dart';
import '../../../../core/theme/app_colors.dart';

class HeroAvatar extends StatelessWidget {
  const HeroAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final imageProvider = const AssetImage('assets/images/avatar.jpg');
    // ignore: unnecessary_null_comparison
    final bool hasImage = imageProvider != null;

    return FadeSlideAnimation(
      delay: const Duration(milliseconds: 400),
      child: Center(
        child: SizedBox(
          width: 300,
          height: 300,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 290,
                height: 290,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: SweepGradient(
                    colors: [
                      AppColors.primary.withValues(alpha: 0.6),
                      AppColors.accent.withValues(alpha: 0.4),
                      AppColors.primary.withValues(alpha: 0.1),
                      AppColors.primary.withValues(alpha: 0.6),
                    ],
                  ),
                ),
              ),
              // White spacer
              Container(
                width: 278,
                height: 278,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: cs.surface,
                ),
              ),
              Container(
                width: 262,
                height: 262,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: cs.surfaceContainerHighest,
                  image:
                      hasImage
                          ? DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          )
                          : null,
                ),
                child:
                    hasImage
                        ? null
                        : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.person_rounded,
                              size: 80,
                              color: cs.primary.withValues(alpha: 0.4),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Your Photo Here',
                              style: Theme.of(
                                context,
                              ).textTheme.bodySmall?.copyWith(
                                color: cs.onSurfaceVariant.withValues(
                                  alpha: 0.5,
                                ),
                              ),
                            ),
                          ],
                        ),
              ),
              Positioned(
                bottom: 20,
                right: 10,
                child: _FloatingBadge(
                  icon: Icons.flutter_dash_rounded,
                  label: 'Flutter Dev',
                  color: const Color(0xFF54C5F8),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FloatingBadge extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  const _FloatingBadge({
    required this.icon,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(100),
        border: Border.all(
          color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.5),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(width: 6),
          Text(
            label,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.w600,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }
}
