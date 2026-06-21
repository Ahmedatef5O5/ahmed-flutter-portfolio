import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/animations/scroll_reveal.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/responsive/responsive.dart';
import '../data/projects_data.dart';
import 'widgets/project_icons.dart';

class ProjectDetailPage extends StatelessWidget {
  final String projectId;
  const ProjectDetailPage({super.key, required this.projectId});

  @override
  Widget build(BuildContext context) {
    final project = kProjects.firstWhere(
      (p) => p.id == projectId,
      orElse: () => kProjects.first,
    );
    final r = Responsive.of(context);
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    final g = project.gradientColors;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: cs.surface,
      body: SingleChildScrollView(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: AppSizes.maxContentWidth,
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: r.value(mobile: 20.0, desktop: 60.0),
                vertical: AppSizes.sectionPadding,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _BackButton(accentColor: g[0]),
                  const SizedBox(height: 40),

                  _HeroSection(project: project, isDark: isDark),
                  const SizedBox(height: 64),

                  ScrollReveal(
                    child: _SectionLabel(label: 'About', color: g[0]),
                  ),
                  const SizedBox(height: 16),
                  ScrollReveal(
                    delay: const Duration(milliseconds: 80),
                    child: Text(
                      project.fullDescription,
                      style: tt.bodyLarge?.copyWith(
                        color: cs.onSurfaceVariant,
                        height: 1.75,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const SizedBox(height: 56),

                  ScrollReveal(
                    child: _SectionLabel(label: 'Key Features', color: g[0]),
                  ),
                  const SizedBox(height: 24),
                  _FeaturesGrid(project: project),
                  const SizedBox(height: 64),

                  ScrollReveal(
                    child: _SectionLabel(label: 'Tech Stack', color: g[0]),
                  ),
                  const SizedBox(height: 20),
                  ScrollReveal(
                    delay: const Duration(milliseconds: 80),
                    child: _TechStackRow(
                      techStack: project.techStack,
                      accentColor: g[0],
                    ),
                  ),
                  const SizedBox(height: 64),

                  ScrollReveal(child: _CtaRow(project: project)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _BackButton extends StatefulWidget {
  final Color accentColor;
  const _BackButton({required this.accentColor});

  @override
  State<_BackButton> createState() => _BackButtonState();
}

class _BackButtonState extends State<_BackButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => context.go('/projects'),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            color:
                _hovered
                    ? widget.accentColor.withValues(alpha: 0.08)
                    : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color:
                  _hovered
                      ? widget.accentColor.withValues(alpha: 0.4)
                      : cs.outline.withValues(alpha: 0.3),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.arrow_back_rounded,
                size: 16,
                color: _hovered ? widget.accentColor : cs.onSurfaceVariant,
              ),
              const SizedBox(width: 8),
              Text(
                'Back to Projects',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: _hovered ? widget.accentColor : cs.onSurfaceVariant,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _HeroSection extends StatelessWidget {
  final ProjectModel project;
  final bool isDark;
  const _HeroSection({required this.project, required this.isDark});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    final g = project.gradientColors;
    final r = Responsive.of(context);

    return ScrollReveal(
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(r.value(mobile: 28.0, desktop: 48.0)),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              g[0].withValues(alpha: isDark ? 0.18 : 0.1),
              g[1].withValues(alpha: isDark ? 0.08 : 0.04),
              cs.surface,
            ],
            stops: const [0, 0.5, 1],
          ),
          borderRadius: BorderRadius.circular(28),
          border: Border.all(
            color: g[0].withValues(alpha: isDark ? 0.25 : 0.18),
          ),
        ),
        child:
            r.isMobile
                ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    projectIcon(project.id, size: 64),
                    const SizedBox(height: 20),
                    _HeroText(project: project, cs: cs, tt: tt, g: g),
                  ],
                )
                : Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    projectIcon(project.id, size: 80),
                    const SizedBox(width: 32),
                    Expanded(
                      child: _HeroText(project: project, cs: cs, tt: tt, g: g),
                    ),
                  ],
                ),
      ),
    );
  }
}

class _HeroText extends StatelessWidget {
  final ProjectModel project;
  final ColorScheme cs;
  final TextTheme tt;
  final List<Color> g;
  const _HeroText({
    required this.project,
    required this.cs,
    required this.tt,
    required this.g,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (project.isFeatured)
          Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  g[0].withValues(alpha: 0.18),
                  g[1].withValues(alpha: 0.08),
                ],
              ),
              borderRadius: BorderRadius.circular(100),
              border: Border.all(color: g[0].withValues(alpha: 0.35)),
            ),
            child: Text(
              'Featured Project',
              style: tt.bodySmall?.copyWith(
                color: g[0],
                fontWeight: FontWeight.w700,
                fontSize: 11,
              ),
            ),
          ),
        Text(
          project.title,
          style: tt.displaySmall?.copyWith(
            fontWeight: FontWeight.w800,
            fontSize: 36,
            letterSpacing: -0.5,
            color: cs.onSurface,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          project.tagline,
          style: tt.bodyLarge?.copyWith(
            color: g[0],
            fontWeight: FontWeight.w600,
            fontSize: 15,
          ),
        ),
      ],
    );
  }
}

class _SectionLabel extends StatelessWidget {
  final String label;
  final Color color;
  const _SectionLabel({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Row(
      children: [
        Container(
          width: 4,
          height: 20,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 12),
        Text(
          label,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w700,
            color: cs.onSurface,
            fontSize: 18,
          ),
        ),
      ],
    );
  }
}

class _FeaturesGrid extends StatelessWidget {
  final ProjectModel project;
  const _FeaturesGrid({required this.project});

  @override
  Widget build(BuildContext context) {
    final r = Responsive.of(context);
    final g = project.gradientColors;
    final cols = r.isMobile ? 1 : (r.isTablet ? 2 : 3);

    return LayoutBuilder(
      builder: (_, constraints) {
        final cardWidth = (constraints.maxWidth - (cols - 1) * 16) / cols;

        return Wrap(
          spacing: 16,
          runSpacing: 16,
          children:
              project.features.asMap().entries.map((entry) {
                final i = entry.key;
                final feature = entry.value;
                return ScrollReveal(
                  delay: Duration(milliseconds: i * 60),
                  child: SizedBox(
                    width: cardWidth,
                    child: _FeatureCard(
                      feature: feature,
                      accentColor: g[0],
                      secondaryColor: g[1],
                    ),
                  ),
                );
              }).toList(),
        );
      },
    );
  }
}

class _FeatureCard extends StatefulWidget {
  final ProjectFeature feature;
  final Color accentColor;
  final Color secondaryColor;
  const _FeatureCard({
    required this.feature,
    required this.accentColor,
    required this.secondaryColor,
  });

  @override
  State<_FeatureCard> createState() => _FeatureCardState();
}

class _FeatureCardState extends State<_FeatureCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: cs.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color:
                _hovered
                    ? widget.accentColor.withValues(alpha: 0.4)
                    : cs.outline.withValues(alpha: isDark ? 0.2 : 0.5),
            width: _hovered ? 1.5 : 1,
          ),
          boxShadow:
              _hovered
                  ? [
                    BoxShadow(
                      color: widget.accentColor.withValues(alpha: 0.1),
                      blurRadius: 20,
                      offset: const Offset(0, 6),
                    ),
                  ]
                  : [],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: widget.accentColor.withValues(
                  alpha: _hovered ? 0.18 : 0.1,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                widget.feature.icon,
                color: widget.accentColor,
                size: 20,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              widget.feature.title,
              style: tt.titleSmall?.copyWith(
                fontWeight: FontWeight.w700,
                color: cs.onSurface,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              widget.feature.description,
              style: tt.bodySmall?.copyWith(
                color: cs.onSurfaceVariant,
                height: 1.6,
                fontSize: 12.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TechStackRow extends StatelessWidget {
  final List<String> techStack;
  final Color accentColor;
  const _TechStackRow({required this.techStack, required this.accentColor});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children:
          techStack
              .map(
                (t) => Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: accentColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(
                      color: accentColor.withValues(alpha: 0.25),
                    ),
                  ),
                  child: Text(
                    t,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: accentColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                    ),
                  ),
                ),
              )
              .toList(),
    );
  }
}

class _CtaRow extends StatelessWidget {
  final ProjectModel project;
  const _CtaRow({required this.project});

  @override
  Widget build(BuildContext context) {
    final g = project.gradientColors;
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: [
        if (project.githubUrl != null)
          _CtaButton(
            icon: Icons.code_rounded,
            label: 'View on GitHub',
            url: project.githubUrl!,
            accentColor: g[0],
            filled: true,
          ),
        if (project.demoUrl != null)
          _CtaButton(
            icon: Icons.open_in_new_rounded,
            label: 'Live Demo',
            url: project.demoUrl!,
            accentColor: g[0],
          ),
        if (project.apkUrl != null)
          _CtaButton(
            icon: Icons.android_rounded,
            label: 'Download APK',
            url: project.apkUrl!,
            accentColor: g[0],
          ),
      ],
    );
  }
}

class _CtaButton extends StatefulWidget {
  final IconData icon;
  final String label;
  final String url;
  final Color accentColor;
  final bool filled;
  const _CtaButton({
    required this.icon,
    required this.label,
    required this.url,
    required this.accentColor,
    this.filled = false,
  });

  @override
  State<_CtaButton> createState() => _CtaButtonState();
}

class _CtaButtonState extends State<_CtaButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final bg =
        widget.filled
            ? (_hovered
                ? widget.accentColor.withValues(alpha: 0.85)
                : widget.accentColor)
            : (_hovered
                ? widget.accentColor.withValues(alpha: 0.1)
                : Colors.transparent);
    final fg = widget.filled ? Colors.white : widget.accentColor;

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => launchUrl(Uri.parse(widget.url)),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          decoration: BoxDecoration(
            color: bg,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color:
                  widget.filled
                      ? Colors.transparent
                      : widget.accentColor.withValues(alpha: 0.45),
              width: 1.5,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(widget.icon, size: 18, color: fg),
              const SizedBox(width: 8),
              Text(
                widget.label,
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: fg,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
