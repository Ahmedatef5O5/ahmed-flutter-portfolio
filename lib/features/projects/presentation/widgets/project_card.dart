import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:ahmed_portfolio/features/projects/presentation/widgets/project_icons.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/animations/scroll_reveal.dart';
import '../../../../features/projects/data/projects_data.dart';
import '../../../../shared/widgets/learn_more_button.dart';

class ProjectCard extends StatefulWidget {
  final ProjectModel project;
  final int index;
  const ProjectCard({super.key, required this.project, required this.index});

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard>
    with SingleTickerProviderStateMixin {
  bool _hovered = false;
  late AnimationController _iconController;
  late Animation<double> _iconRotate;
  late Animation<double> _iconScale;

  @override
  void initState() {
    super.initState();
    _iconController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _iconRotate = Tween<double>(begin: 0, end: 0.08).animate(
      CurvedAnimation(parent: _iconController, curve: Curves.elasticOut),
    );
    _iconScale = Tween<double>(begin: 1, end: 1.18).animate(
      CurvedAnimation(parent: _iconController, curve: Curves.easeOutBack),
    );
  }

  @override
  void dispose() {
    _iconController.dispose();
    super.dispose();
  }

  void _onEnter(_) {
    setState(() => _hovered = true);
    _iconController.forward();
  }

  void _onExit(_) {
    setState(() => _hovered = false);
    _iconController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    final g = widget.project.gradientColors;

    return ScrollReveal(
      delay: Duration(milliseconds: widget.index * 120),
      child: RepaintBoundary(
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          onEnter: _onEnter,
          onExit: _onExit,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 280),
            curve: Curves.easeOutCubic,
            transform: Matrix4.translationValues(0, _hovered ? -8 : 0, 0),
            transformAlignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              boxShadow:
                  _hovered
                      ? [
                        BoxShadow(
                          color: g[0].withValues(alpha: isDark ? 0.35 : 0.22),
                          blurRadius: 40,
                          offset: const Offset(0, 16),
                        ),
                      ]
                      : [
                        BoxShadow(
                          color: Colors.black.withValues(
                            alpha: isDark ? 0.3 : 0.08,
                          ),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: Stack(
                children: [
                  Positioned.fill(
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 280),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors:
                              _hovered
                                  ? [
                                    g[0].withValues(
                                      alpha: isDark ? 0.28 : 0.18,
                                    ),
                                    g[1].withValues(
                                      alpha: isDark ? 0.14 : 0.08,
                                    ),
                                    cs.surface,
                                  ]
                                  : [
                                    g[0].withValues(
                                      alpha: isDark ? 0.14 : 0.09,
                                    ),
                                    g[1].withValues(
                                      alpha: isDark ? 0.07 : 0.04,
                                    ),
                                    cs.surface,
                                  ],
                          stops: const [0, 0.45, 1],
                        ),
                      ),
                    ),
                  ),

                  // ── Decorative circle (top-right) ────────────────
                  Positioned(
                    top: -30,
                    right: -30,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 280),
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: g[0].withValues(alpha: _hovered ? 0.12 : 0.07),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 20,
                    right: 20,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 280),
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: g[0].withValues(alpha: _hovered ? 0.08 : 0.04),
                      ),
                    ),
                  ),

                  // ── Border overlay ───────────────────────────────
                  Positioned.fill(
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 280),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(
                          color:
                              _hovered
                                  ? g[0].withValues(alpha: 0.5)
                                  : g[0].withValues(alpha: isDark ? 0.2 : 0.15),
                          width: _hovered ? 1.5 : 1,
                        ),
                      ),
                    ),
                  ),

                  // ── Content ──────────────────────────────────────
                  Padding(
                    padding: const EdgeInsets.all(28),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AnimatedBuilder(
                              animation: _iconController,
                              builder:
                                  (_, __) => Transform.scale(
                                    scale: _iconScale.value,
                                    child: Transform.rotate(
                                      angle: _iconRotate.value * math.pi,
                                      child: projectIcon(
                                        widget.project.id,
                                        size: 52,
                                      ),
                                    ),
                                  ),
                            ),
                            const Spacer(),
                            if (widget.project.isFeatured)
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      g[0].withValues(alpha: 0.2),
                                      g[1].withValues(alpha: 0.1),
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(100),
                                  border: Border.all(
                                    color: g[0].withValues(alpha: 0.35),
                                  ),
                                ),
                                child: Text(
                                  'Featured',
                                  style: tt.bodySmall?.copyWith(
                                    color: g[0],
                                    fontWeight: FontWeight.w700,
                                    fontSize: 11,
                                  ),
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(height: 16),

                        // App name
                        Text(
                          widget.project.title,
                          style: tt.titleLarge?.copyWith(
                            fontWeight: FontWeight.w800,
                            fontSize: 20,
                            letterSpacing: -0.3,
                            color: cs.onSurface,
                          ),
                        ),
                        const SizedBox(height: 3),

                        // Tagline
                        Text(
                          widget.project.tagline,
                          style: tt.bodySmall?.copyWith(
                            color: g[0].withValues(alpha: 0.85),
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                            letterSpacing: 0.2,
                          ),
                        ),
                        const SizedBox(height: 12),

                        // Description
                        Text(
                          widget.project.description,
                          style: tt.bodyMedium?.copyWith(
                            color: cs.onSurfaceVariant,
                            height: 1.6,
                            fontSize: 13.5,
                          ),
                          maxLines: 4,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 14),

                        // Tech stack chips
                        Wrap(
                          spacing: 6,
                          runSpacing: 6,
                          children:
                              widget.project.techStack
                                  .map((t) => _TechTag(label: t, color: g[0]))
                                  .toList(),
                        ),
                        const SizedBox(height: 18),

                        Row(
                          children: [
                            if (widget.project.githubUrl != null)
                              _CardButton(
                                icon: Icons.code_rounded,
                                label: 'GitHub',
                                url: widget.project.githubUrl!,
                                accentColor: g[0],
                              ),
                            if (widget.project.demoUrl != null) ...[
                              const SizedBox(width: 8),
                              _CardButton(
                                icon: Icons.open_in_new_rounded,
                                label: 'Demo',
                                url: widget.project.demoUrl!,
                                accentColor: g[0],
                                filled: true,
                              ),
                            ],
                            if (widget.project.apkUrl != null) ...[
                              const SizedBox(width: 8),
                              _CardButton(
                                icon: Icons.android_rounded,
                                label: 'APK',
                                url: widget.project.apkUrl!,
                                accentColor: g[0],
                              ),
                            ],
                            Spacer(),
                            LearnMoreButton(
                              projectId: widget.project.id,
                              accentColor: g[0],
                            ),
                          ],
                        ),
                      ],
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

class _TechTag extends StatelessWidget {
  final String label;
  final Color color;
  const _TechTag({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 3),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
          color: color,
          fontWeight: FontWeight.w600,
          fontSize: 11,
        ),
      ),
    );
  }
}

class _CardButton extends StatefulWidget {
  final IconData icon;
  final String label;
  final String url;
  final Color accentColor;
  final bool filled;
  const _CardButton({
    required this.icon,
    required this.label,
    required this.url,
    required this.accentColor,
    this.filled = false,
  });

  @override
  State<_CardButton> createState() => _CardButtonState();
}

class _CardButtonState extends State<_CardButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final bg =
        widget.filled
            ? (_hovered
                ? widget.accentColor.withValues(alpha: 0.85)
                : widget.accentColor)
            : (_hovered
                ? widget.accentColor.withValues(alpha: 0.12)
                : Colors.transparent);
    final fg = widget.filled ? Colors.white : widget.accentColor;

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      cursor: SystemMouseCursors.click,
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(10),
        child: InkWell(
          onTap: () => launchUrl(Uri.parse(widget.url)),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: bg,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color:
                    widget.filled
                        ? Colors.transparent
                        : widget.accentColor.withValues(alpha: 0.4),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(widget.icon, size: 15, color: fg),
                const SizedBox(width: 6),
                Text(
                  widget.label,
                  style: Theme.of(
                    context,
                  ).textTheme.labelLarge?.copyWith(color: fg, fontSize: 13),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
