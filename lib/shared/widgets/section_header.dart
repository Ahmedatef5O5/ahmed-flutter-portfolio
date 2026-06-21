import 'package:flutter/material.dart';
import '../../core/animations/scroll_reveal.dart';
import '../../core/theme/app_colors.dart';

class SectionHeader extends StatelessWidget {
  final String label;
  final String title;
  final String? subtitle;

  const SectionHeader({
    super.key,
    required this.label,
    required this.title,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return ScrollReveal(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Transform.translate(
            offset: const Offset(-2, 0),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    cs.primary.withValues(alpha: 0.12),
                    AppColors.accent.withValues(alpha: 0.08),
                  ],
                ),
                borderRadius: BorderRadius.circular(100),
                border: Border.all(color: cs.primary.withValues(alpha: 0.3)),
              ),
              child: Text(
                label.toUpperCase(),
                style: tt.labelLarge?.copyWith(
                  color: cs.primary,
                  fontSize: 11,
                  letterSpacing: 2,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          const SizedBox(height: 14),
          // Title + underline accent
          Stack(
            children: [
              Text(title, style: tt.displaySmall),
              Positioned(
                bottom: 0,
                left: 0,
                child: Container(
                  height: 3,
                  width: 48,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2),
                    gradient: const LinearGradient(
                      colors: AppColors.brandGradient,
                    ),
                  ),
                ),
              ),
            ],
          ),
          if (subtitle != null) ...[
            const SizedBox(height: 14),
            Text(
              subtitle!,
              style: tt.bodyLarge?.copyWith(
                color: cs.onSurfaceVariant,
                height: 1.7,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
