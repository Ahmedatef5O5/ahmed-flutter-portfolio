import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_sizes.dart';
import '../../core/constants/app_strings.dart';
import '../../core/responsive/responsive.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/theme_controller.dart';
import '../../routing/app_routing.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  static const _navItems = [
    (label: AppStrings.navHome, route: AppRoutes.home),
    (label: AppStrings.navAbout, route: AppRoutes.about),
    (label: AppStrings.navProjects, route: AppRoutes.projects),
    (label: AppStrings.navContact, route: AppRoutes.contact),
  ];

  @override
  Widget build(BuildContext context) {
    final r = Responsive.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cs = Theme.of(context).colorScheme;

    return RepaintBoundary(
      child: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            height: AppSizes.navHeight,
            decoration: BoxDecoration(
              // Glass effect
              color: cs.surface.withValues(alpha: isDark ? 0.7 : 0.8),
              border: Border(
                bottom: BorderSide(
                  color: cs.outline.withValues(alpha: isDark ? 0.2 : 0.35),
                  width: 0.5,
                ),
              ),
            ),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: AppSizes.maxContentWidth,
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: r.value(mobile: 16.0, desktop: 32.0),
                  ),
                  child: Row(
                    children: [
                      _Logo(),
                      const Spacer(),
                      if (r.isDesktop) ...[
                        for (final item in _navItems)
                          _NavLink(label: item.label, route: item.route),
                        const SizedBox(width: 16),
                      ],
                      _ThemeToggle(),
                      if (!r.isDesktop) _MobileMenuButton(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Logo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.go(AppRoutes.home),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: ShaderMask(
          shaderCallback:
              (bounds) => const LinearGradient(
                colors: AppColors.brandGradient,
              ).createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
          child: Text(
            'AA.',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.5,
            ),
          ),
        ),
      ),
    );
  }
}

class _NavLink extends StatefulWidget {
  final String label;
  final String route;
  const _NavLink({required this.label, required this.route});

  @override
  State<_NavLink> createState() => _NavLinkState();
}

class _NavLinkState extends State<_NavLink> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.path;
    final isActive = location == widget.route;
    final cs = Theme.of(context).colorScheme;

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => context.go(widget.route),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 150),
                style: Theme.of(context).textTheme.labelLarge!.copyWith(
                  color:
                      isActive || _hovered ? cs.primary : cs.onSurfaceVariant,
                  fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
                ),
                child: Text(widget.label),
              ),
              const SizedBox(height: 2),
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                height: 2,
                width: isActive ? 20 : (_hovered ? 12 : 0),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: AppColors.brandGradient,
                  ),
                  borderRadius: BorderRadius.circular(1),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ThemeToggle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = context.watch<ThemeController>();
    return IconButton(
      onPressed: controller.toggle,
      tooltip: controller.isDark ? 'Light mode' : 'Dark mode',
      icon: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        transitionBuilder:
            (child, animation) => RotationTransition(
              turns: animation,
              child: FadeTransition(opacity: animation, child: child),
            ),
        child: Icon(
          controller.isDark
              ? Icons.light_mode_rounded
              : Icons.dark_mode_rounded,
          key: ValueKey(controller.isDark),
          size: 20,
        ),
      ),
    );
  }
}

class _MobileMenuButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => _showMobileMenu(context),
      icon: const Icon(Icons.menu_rounded, size: 22),
    );
  }

  void _showMobileMenu(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    showModalBottomSheet(
      context: context,
      backgroundColor: cs.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => _MobileMenu(),
    );
  }
}

class _MobileMenu extends StatelessWidget {
  static const _navItems = [
    (label: AppStrings.navHome, route: AppRoutes.home),
    (label: AppStrings.navAbout, route: AppRoutes.about),
    (label: AppStrings.navProjects, route: AppRoutes.projects),
    (label: AppStrings.navContact, route: AppRoutes.contact),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (final item in _navItems)
              ListTile(
                title: Text(
                  item.label,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                onTap: () {
                  Navigator.pop(context);
                  context.go(item.route);
                },
              ),
          ],
        ),
      ),
    );
  }
}
