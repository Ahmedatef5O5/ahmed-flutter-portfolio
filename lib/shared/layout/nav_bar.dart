import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../core/animations/scroll_notifier.dart';
import '../../core/constants/app_sizes.dart';
import '../../core/constants/app_strings.dart';
import '../../core/responsive/responsive.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/theme_controller.dart';
import '../../routing/app_routing.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  static const _navItems = [
    (label: AppStrings.navHome, route: AppRoutes.home),
    (label: AppStrings.navAbout, route: AppRoutes.about),
    (label: AppStrings.navProjects, route: AppRoutes.projects),
    (label: AppStrings.navContact, route: AppRoutes.contact),
  ];

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  bool _scrolled = false;

  @override
  void initState() {
    super.initState();
    navScrolled.addListener(_onScrollChange);
  }

  void _onScrollChange() {
    if (_scrolled != navScrolled.value) {
      setState(() => _scrolled = navScrolled.value);
    }
  }

  @override
  void dispose() {
    navScrolled.removeListener(_onScrollChange);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final r = Responsive.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cs = Theme.of(context).colorScheme;

    return RepaintBoundary(
      child: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            height: AppSizes.navHeight,
            decoration: BoxDecoration(
              color: cs.surface.withValues(
                alpha:
                    _scrolled ? (isDark ? 0.72 : 0.85) : (isDark ? 0.32 : 0.5),
              ),
              border: Border(
                bottom: BorderSide(
                  color: cs.outline.withValues(
                    alpha:
                        _scrolled
                            ? (isDark ? 0.35 : 0.5)
                            : (isDark ? 0.15 : 0.3),
                  ),
                  width: 0.5,
                ),
              ),
              boxShadow:
                  _scrolled
                      ? [
                        BoxShadow(
                          color: cs.shadow.withValues(
                            alpha: isDark ? 0.55 : 0.18,
                          ),
                          blurRadius: 40,
                          spreadRadius: -4,
                          offset: const Offset(0, 12),
                        ),
                      ]
                      : [
                        BoxShadow(
                          color: cs.shadow.withValues(
                            alpha: isDark ? 0.25 : 0.06,
                          ),
                          blurRadius: 24,
                          offset: const Offset(0, 8),
                        ),
                      ],
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
                        for (final item in NavBar._navItems)
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

class _Logo extends StatefulWidget {
  @override
  State<_Logo> createState() => _LogoState();
}

class _LogoState extends State<_Logo> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: () => context.go(AppRoutes.home),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: LinearGradient(
              colors:
                  AppColors.brandGradient
                      .map((c) => c.withValues(alpha: _hovered ? 0.2 : 0.12))
                      .toList(),
            ),
            border: Border.all(
              color: AppColors.brandGradient.first.withValues(
                alpha: _hovered ? 0.6 : 0.3,
              ),
              width: 1,
            ),
          ),
          child: ShaderMask(
            shaderCallback:
                (bounds) => const LinearGradient(
                  colors: AppColors.brandGradient,
                ).createShader(
                  Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                ),
            child: Text(
              'AA',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w900,
                letterSpacing: 1.5,
                fontSize: 16,
              ),
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
      onPressed: () => Scaffold.of(context).openEndDrawer(),
      icon: const Icon(Icons.menu_rounded, size: 22),
    );
  }
}
