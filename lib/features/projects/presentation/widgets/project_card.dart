import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/animations/scroll_reveal.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../features/projects/data/projects_data.dart';

class ProjectCard extends StatefulWidget {
  final ProjectModel project;
  final int index;
  const ProjectCard({super.key, required this.project, required this.index});

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return ScrollReveal(
      delay: Duration(milliseconds: widget.index * 100),
      child: MouseRegion(
        onEnter: (_) => setState(() => _hovered = true),
        onExit: (_) => setState(() => _hovered = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeOut,
          transform: Matrix4.translationValues(0, _hovered ? -6 : 0, 0),
          decoration: BoxDecoration(
            color: cs.surface,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color:
                  _hovered
                      ? cs.primary.withValues(alpha: 0.5)
                      : cs.outline.withValues(alpha: isDark ? 0.25 : 0.6),
              width: _hovered ? 1.5 : 1,
            ),
            boxShadow:
                _hovered
                    ? [
                      BoxShadow(
                        color: cs.primary.withValues(
                          alpha: isDark ? 0.12 : 0.07,
                        ),
                        blurRadius: 32,
                        offset: const Offset(0, 12),
                      ),
                    ]
                    : [],
          ),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Gradient accent top bar (يظهر عند hover)
                AnimatedContainer(
                  duration: const Duration(milliseconds: 220),
                  height: 3,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(19),
                    ),
                    gradient:
                        _hovered
                            ? const LinearGradient(
                              colors: AppColors.brandGradient,
                            )
                            : const LinearGradient(
                              colors: [Colors.transparent, Colors.transparent],
                            ),
                  ),
                ),
                // Project number
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
                  child: Row(
                    children: [
                      Text(
                        '0${widget.index + 1}',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: cs.primary.withValues(alpha: 0.4),
                          fontWeight: FontWeight.w700,
                          fontSize: 12,
                          letterSpacing: 1,
                        ),
                      ),
                      const Spacer(),
                      if (widget.project.isFeatured)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 3,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.teal.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(
                              color: AppColors.teal.withValues(alpha: 0.3),
                            ),
                          ),
                          child: Text(
                            'Featured',
                            style: tt.bodySmall?.copyWith(
                              color: AppColors.teal,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),

                // Description
                Expanded(
                  child: Text(
                    widget.project.description,
                    style: tt.bodyMedium?.copyWith(
                      color: cs.onSurfaceVariant,
                      height: 1.65,
                    ),
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(height: 14),

                // Tech stack chips
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children:
                      widget.project.techStack
                          .map((t) => _TechTag(label: t))
                          .toList(),
                ),
                const SizedBox(height: 16),

                // Action buttons
                Row(
                  children: [
                    if (widget.project.githubUrl != null)
                      _CardButton(
                        icon: Icons.code_rounded,
                        label: 'GitHub',
                        url: widget.project.githubUrl!,
                      ),
                    if (widget.project.demoUrl != null) ...[
                      const SizedBox(width: 8),
                      _CardButton(
                        icon: Icons.open_in_new_rounded,
                        label: 'Demo',
                        url: widget.project.demoUrl!,
                        filled: true,
                      ),
                    ],
                    if (widget.project.apkUrl != null) ...[
                      const SizedBox(width: 8),
                      _CardButton(
                        icon: Icons.android_rounded,
                        label: 'APK',
                        url: widget.project.apkUrl!,
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _TechTag extends StatelessWidget {
  final String label;
  const _TechTag({required this.label});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 3),
      decoration: BoxDecoration(
        color: cs.primary.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
          color: cs.primary,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

class _CardButton extends StatefulWidget {
  final IconData icon;
  final String label;
  final String url;
  final bool filled;
  const _CardButton({
    required this.icon,
    required this.label,
    required this.url,
    this.filled = false,
  });

  @override
  State<_CardButton> createState() => _CardButtonState();
}

class _CardButtonState extends State<_CardButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final bg =
        widget.filled
            ? (_hovered ? cs.primary.withValues(alpha: 0.85) : cs.primary)
            : (_hovered
                ? cs.primary.withValues(alpha: 0.08)
                : Colors.transparent);
    final fg = widget.filled ? Colors.white : cs.primary;

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
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
                      : cs.primary.withValues(alpha: 0.4),
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
    );
  }
}
