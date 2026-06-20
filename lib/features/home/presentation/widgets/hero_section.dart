import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/animations/fade_slide_animation.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/responsive/responsive.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../routing/app_routing.dart';
import '../../../../shared/widgets/gradient_text.dart';
import '../../../../shared/widgets/primary_button.dart';
import 'hero_avatar.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    final r = Responsive.of(context);

    return Container(
      constraints: const BoxConstraints(minHeight: 600),
      padding: EdgeInsets.symmetric(
        horizontal: r.value(mobile: 20.0, desktop: 60.0),
        vertical: r.value(mobile: 48.0, desktop: 80.0),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: AppSizes.maxContentWidth),
          child: r.isDesktop ? _DesktopLayout() : _MobileLayout(),
        ),
      ),
    );
  }
}

// ─────────────────────────── Desktop (side by side) ──────────────────────────

class _DesktopLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(flex: 6, child: _HeroContent()),
        const SizedBox(width: 60),
        Expanded(flex: 4, child: const HeroAvatar()),
      ],
    );
  }
}

// ─────────────────────────── Mobile (stacked) ────────────────────────────────

class _MobileLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const HeroAvatar(),
        const SizedBox(height: 40),
        _HeroContent(),
      ],
    );
  }
}

// ─────────────────────────── Content ─────────────────────────────────────────

class _HeroContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;
    final cs = Theme.of(context).colorScheme;
    final r = Responsive.of(context);

    return Column(
      crossAxisAlignment:
          r.isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        // Available badge
        FadeSlideAnimation(
          delay: const Duration(milliseconds: 100),
          child: _AvailableBadge(),
        ),
        const SizedBox(height: 20),

        // Name
        FadeSlideAnimation(
          delay: const Duration(milliseconds: 200),
          child: Text(
            'Hi, I\'m',
            style: tt.headlineLarge?.copyWith(
              color: cs.onSurfaceVariant,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        const SizedBox(height: 4),

        // Gradient name
        FadeSlideAnimation(
          delay: const Duration(milliseconds: 300),
          child: GradientText(
            AppStrings.name,
            style: tt.displayLarge?.copyWith(
              fontSize: r.value(mobile: 48.0, tablet: 60.0, desktop: 72.0),
            ),
          ),
        ),
        const SizedBox(height: 8),

        // Title typewriter-style (static for performance)
        FadeSlideAnimation(
          delay: const Duration(milliseconds: 400),
          child: Text(
            AppStrings.title,
            style: tt.displaySmall?.copyWith(
              color: cs.onSurfaceVariant,
              fontSize: r.value(mobile: 22.0, desktop: 32.0),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const SizedBox(height: 20),

        // Subtitle
        FadeSlideAnimation(
          delay: const Duration(milliseconds: 500),
          child: Text(
            AppStrings.subtitle,
            textAlign: r.isMobile ? TextAlign.center : TextAlign.start,
            style: tt.bodyLarge?.copyWith(
              color: cs.onSurfaceVariant,
              height: 1.8,
              fontSize: r.value(mobile: 15.0, desktop: 17.0),
            ),
          ),
        ),
        const SizedBox(height: 36),

        // CTA Buttons
        FadeSlideAnimation(
          delay: const Duration(milliseconds: 600),
          child: Wrap(
            spacing: 12,
            runSpacing: 12,
            alignment: r.isMobile ? WrapAlignment.center : WrapAlignment.start,
            children: [
              PrimaryButton(
                label: 'View Projects',
                icon: Icons.rocket_launch_rounded,
                onTap: () => context.go(AppRoutes.projects),
              ),
              PrimaryButton(
                label: 'About Me',
                icon: Icons.person_rounded,
                variant: ButtonVariant.outlined,
                onTap: () => context.go(AppRoutes.about),
              ),
              PrimaryButton(
                label: 'Download CV',
                icon: Icons.download_rounded,
                variant: ButtonVariant.ghost,
                onTap: () async {
                  if (AppStrings.cvUrl.isNotEmpty) {
                    await launchUrl(Uri.parse(AppStrings.cvUrl));
                  }
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: 48),

        // Social links
        FadeSlideAnimation(
          delay: const Duration(milliseconds: 700),
          child: _SocialLinks(),
        ),
      ],
    );
  }
}

// ─────────────────────────── Available Badge ─────────────────────────────────

class _AvailableBadge extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: AppColors.success,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: AppColors.success.withValues(alpha: 0.5),
                blurRadius: 6,
                spreadRadius: 1,
              ),
            ],
          ),
        ),
        const SizedBox(width: 8),
        Text(
          'Available for opportunities',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: AppColors.success,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────── Social Links ────────────────────────────────────

class _SocialLinks extends StatelessWidget {
  static const _links = [
    (icon: Icons.code_rounded, label: 'GitHub', url: AppStrings.github),
    (icon: Icons.work_rounded, label: 'LinkedIn', url: AppStrings.linkedin),
    (
      icon: Icons.email_rounded,
      label: 'Email',
      url: 'mailto:${AppStrings.email}',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (final link in _links) ...[
          _SocialIcon(icon: link.icon, label: link.label, url: link.url),
          const SizedBox(width: 8),
        ],
      ],
    );
  }
}

class _SocialIcon extends StatefulWidget {
  final IconData icon;
  final String label;
  final String url;
  const _SocialIcon({
    required this.icon,
    required this.label,
    required this.url,
  });

  @override
  State<_SocialIcon> createState() => _SocialIconState();
}

class _SocialIconState extends State<_SocialIcon> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      cursor: SystemMouseCursors.click,
      child: Tooltip(
        message: widget.label,
        child: GestureDetector(
          onTap: () => launchUrl(Uri.parse(widget.url)),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color:
                  _hovered
                      ? cs.primary.withValues(alpha: 0.1)
                      : cs.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color:
                    _hovered ? cs.primary.withValues(alpha: 0.4) : cs.outline,
              ),
            ),
            child: Icon(
              widget.icon,
              size: 20,
              color: _hovered ? cs.primary : cs.onSurfaceVariant,
            ),
          ),
        ),
      ),
    );
  }
}
