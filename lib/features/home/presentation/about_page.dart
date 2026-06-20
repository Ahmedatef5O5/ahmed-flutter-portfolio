import 'package:flutter/material.dart';
import '../../../core/animations/scroll_reveal.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/responsive/responsive.dart';
import '../../../shared/widgets/hover_card.dart';
import '../../../shared/widgets/section_header.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final r = Responsive.of(context);
    final padding = r.value(mobile: 20.0, desktop: 60.0);

    return SingleChildScrollView(
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: AppSizes.maxContentWidth),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: padding,
              vertical: AppSizes.sectionPadding,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SectionHeader(
                  label: 'Who I am',
                  title: 'About Me',
                  subtitle:
                      'A passionate Flutter developer focused on building clean, performant apps.',
                ),
                const SizedBox(height: 60),
                r.isDesktop ? _DesktopAboutLayout() : _MobileAboutLayout(),
                const SizedBox(height: 72),
                _SkillsSection(),
                const SizedBox(height: 72),
                _ExperienceSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────── Bio section ─────────────────────────────────────

class _DesktopAboutLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(flex: 5, child: _BioText()),
        const SizedBox(width: 48),
        Expanded(flex: 4, child: _StatsCard()),
      ],
    );
  }
}

class _MobileAboutLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [_BioText(), const SizedBox(height: 32), _StatsCard()],
    );
  }
}

class _BioText extends StatelessWidget {
  static const _paragraphs = [
    "I'm Ahmed Atef, a Flutter developer from Minya, Egypt, currently in my final year at the Faculty of Computers & Information, Minia University — specializing in Mobile Development.",
    "I build production-grade Flutter applications using Clean Architecture, BLoC/Cubit state management, and integrate services like Firebase, Supabase, and REST APIs to deliver polished user experiences.",
    "I care deeply about code quality, scalable architecture, and pixel-perfect UI. Every project I build is an opportunity to sharpen both my engineering and design instincts.",
  ];

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;
    final cs = Theme.of(context).colorScheme;

    return ScrollReveal(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (final p in _paragraphs) ...[
            Text(
              p,
              style: tt.bodyLarge?.copyWith(
                color: cs.onSurfaceVariant,
                height: 1.85,
              ),
            ),
            const SizedBox(height: 16),
          ],
        ],
      ),
    );
  }
}

class _StatsCard extends StatelessWidget {
  static const _stats = [
    (value: '3+', label: 'Production Apps'),
    (value: '2+', label: 'Years Experience'),
    (value: '5+', label: 'Tech Integrations'),
    (value: '∞', label: 'Cups of Coffee'),
  ];

  @override
  Widget build(BuildContext context) {
    return ScrollReveal(
      delay: const Duration(milliseconds: 150),
      child: HoverCard(
        child: Wrap(
          spacing: 0,
          runSpacing: 0,
          children: [
            for (final s in _stats)
              SizedBox(
                width: 140,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        s.value,
                        style: Theme.of(
                          context,
                        ).textTheme.displaySmall?.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        s.label,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────── Skills ──────────────────────────────────────────

class _SkillsSection extends StatelessWidget {
  static const _categories = [
    (
      title: 'Mobile & UI',
      icon: Icons.phone_iphone_rounded,
      skills: [
        'Flutter',
        'Dart',
        'Material 3',
        'Custom Animations',
        'Responsive UI',
      ],
    ),
    (
      title: 'Architecture',
      icon: Icons.architecture_rounded,
      skills: [
        'Clean Architecture',
        'BLoC / Cubit',
        'Repository Pattern',
        'SOLID Principles',
      ],
    ),
    (
      title: 'Backend & Cloud',
      icon: Icons.cloud_rounded,
      skills: ['Firebase', 'Supabase', 'REST APIs', 'Hive', 'SQLite'],
    ),
    (
      title: 'Tools & Workflow',
      icon: Icons.build_rounded,
      skills: ['Git & GitHub', 'VS Code', 'Figma', 'Postman', 'Codeforces'],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ScrollReveal(
          child: Text(
            'Skills & Technologies',
            style: Theme.of(context).textTheme.headlineLarge,
          ),
        ),
        const SizedBox(height: 32),
        LayoutBuilder(
          builder: (context, constraints) {
            final crossCount = constraints.maxWidth > 700 ? 2 : 1;
            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossCount,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: crossCount == 2 ? 2.4 : 2.8,
              ),
              itemCount: _categories.length,
              itemBuilder:
                  (_, i) => ScrollReveal(
                    delay: Duration(milliseconds: i * 80),
                    child: _SkillCard(category: _categories[i]),
                  ),
            );
          },
        ),
      ],
    );
  }
}

class _SkillCard extends StatelessWidget {
  final ({String title, IconData icon, List<String> skills}) category;
  const _SkillCard({required this.category});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return HoverCard(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: cs.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(category.icon, size: 18, color: cs.primary),
              ),
              const SizedBox(width: 12),
              Text(
                category.title,
                style: tt.titleLarge?.copyWith(fontSize: 16),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Expanded(
            child: Wrap(
              spacing: 6,
              runSpacing: 6,
              children:
                  category.skills.map((s) => _MiniChip(label: s)).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class _MiniChip extends StatelessWidget {
  final String label;
  const _MiniChip({required this.label});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: cs.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: cs.outline.withValues(alpha: 0.5)),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
          color: cs.onSurfaceVariant,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

// ─────────────────────────── Experience / Education ──────────────────────────

class _ExperienceSection extends StatelessWidget {
  static const _items = [
    (
      period: '2022 – 2026',
      title: 'B.Sc. Computer Science',
      subtitle: 'Faculty of Computers & Information — Minia University',
      description: 'Specialization: Mobile Development. Final year student.',
      isEducation: true,
    ),
    (
      period: '2023 – Present',
      title: 'Flutter Developer',
      subtitle: 'Freelance & Personal Projects',
      description:
          'Built Tafawuq (e-commerce), NewsWave (news app), Real-Time Chat, Bookly — all with Clean Architecture.',
      isEducation: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ScrollReveal(
          child: Text(
            'Education & Experience',
            style: Theme.of(context).textTheme.headlineLarge,
          ),
        ),
        const SizedBox(height: 32),
        for (final item in _items)
          ScrollReveal(
            delay: const Duration(milliseconds: 100),
            child: _TimelineItem(item: item),
          ),
      ],
    );
  }
}

class _TimelineItem extends StatelessWidget {
  final ({
    String period,
    String title,
    String subtitle,
    String description,
    bool isEducation,
  })
  item;
  const _TimelineItem({required this.item});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Timeline line + dot
          SizedBox(
            width: 20,
            child: Column(
              children: [
                Container(
                  width: 10,
                  height: 10,
                  margin: const EdgeInsets.only(top: 6),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: cs.primary,
                    boxShadow: [
                      BoxShadow(
                        color: cs.primary.withValues(alpha: 0.4),
                        blurRadius: 6,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: HoverCard(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          item.title,
                          style: tt.titleLarge?.copyWith(fontSize: 16),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color: cs.primary.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Text(
                          item.period,
                          style: tt.bodySmall?.copyWith(
                            color: cs.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item.subtitle,
                    style: tt.bodyMedium?.copyWith(color: cs.onSurfaceVariant),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    item.description,
                    style: tt.bodyMedium?.copyWith(
                      color: cs.onSurfaceVariant,
                      height: 1.6,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
