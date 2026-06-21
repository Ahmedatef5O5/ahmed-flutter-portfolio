import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_strings.dart';
import '../../core/theme/app_colors.dart';
import '../../routing/app_routing.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  static const _items = [
    (
      label: AppStrings.navHome,
      route: AppRoutes.home,
      icon: Icons.home_rounded,
    ),
    (
      label: AppStrings.navAbout,
      route: AppRoutes.about,
      icon: Icons.person_rounded,
    ),
    (
      label: AppStrings.navProjects,
      route: AppRoutes.projects,
      icon: Icons.work_rounded,
    ),
    (
      label: AppStrings.navContact,
      route: AppRoutes.contact,
      icon: Icons.mail_rounded,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final location = GoRouterState.of(context).uri.path;

    return Drawer(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 24, sigmaY: 24),
          child: Container(
            decoration: BoxDecoration(
              color: cs.surface.withValues(alpha: isDark ? 0.85 : 0.92),
              border: Border(
                left: BorderSide(color: cs.outline.withValues(alpha: 0.3)),
              ),
            ),
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 24),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: ShaderMask(
                      shaderCallback:
                          (bounds) => const LinearGradient(
                            colors: AppColors.brandGradient,
                          ).createShader(
                            Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                          ),
                      child: Text(
                        'AA.',
                        style: Theme.of(
                          context,
                        ).textTheme.headlineLarge?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Divider(color: cs.outline.withValues(alpha: 0.25)),
                  ),
                  const SizedBox(height: 12),
                  for (final item in _items)
                    _DrawerItem(
                      label: item.label,
                      icon: item.icon,
                      isActive: location == item.route,
                      onTap: () {
                        Navigator.pop(context);
                        context.go(item.route);
                      },
                    ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.all(24),
                    child: Text(
                      '© ${DateTime.now().year} ${AppStrings.name}',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: cs.onSurfaceVariant,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _DrawerItem extends StatefulWidget {
  final String label;
  final IconData icon;
  final bool isActive;
  final VoidCallback onTap;
  const _DrawerItem({
    required this.label,
    required this.icon,
    required this.isActive,
    required this.onTap,
  });

  @override
  State<_DrawerItem> createState() => _DrawerItemState();
}

class _DrawerItemState extends State<_DrawerItem> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final active = widget.isActive;

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 3),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color:
                active
                    ? cs.primary.withValues(alpha: 0.12)
                    : (_hovered
                        ? cs.primary.withValues(alpha: 0.06)
                        : Colors.transparent),
            borderRadius: BorderRadius.circular(12),
            border:
                active
                    ? Border.all(color: cs.primary.withValues(alpha: 0.3))
                    : null,
          ),
          child: Row(
            children: [
              Icon(
                widget.icon,
                size: 20,
                color: active ? cs.primary : cs.onSurfaceVariant,
              ),
              const SizedBox(width: 14),
              Text(
                widget.label,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontSize: 16,
                  fontWeight: active ? FontWeight.w700 : FontWeight.w500,
                  color: active ? cs.primary : cs.onSurface,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
