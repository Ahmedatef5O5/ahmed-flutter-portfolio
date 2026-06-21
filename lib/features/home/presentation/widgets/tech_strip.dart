import 'package:flutter/material.dart';
import '../../../../core/animations/scroll_reveal.dart';

class TechStrip extends StatelessWidget {
  const TechStrip({super.key});

  static const _techs = [
    'Flutter',
    'Dart',
    'Firebase',
    'Supabase',
    'Clean Architecture',
    'BLoC',
    'REST APIs',
    'Git',
  ];

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: cs.outline.withValues(alpha: 0.4)),
          bottom: BorderSide(color: cs.outline.withValues(alpha: 0.4)),
        ),
      ),
      child: Wrap(
        alignment: WrapAlignment.center,
        spacing: 12,
        runSpacing: 10,
        children: [
          for (var i = 0; i < _techs.length; i++)
            ScrollReveal(
              delay: Duration(milliseconds: i * 60),
              slideOffset: 14,
              duration: const Duration(milliseconds: 450),
              child: _TechChip(label: _techs[i]),
            ),
        ],
      ),
    );
  }
}

class _TechChip extends StatefulWidget {
  final String label;
  const _TechChip({required this.label});

  @override
  State<_TechChip> createState() => _TechChipState();
}

class _TechChipState extends State<_TechChip> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        curve: Curves.easeOut,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
        transform:
            Matrix4.identity()
              ..scale(_hovered ? 1.05 : 1.0, _hovered ? 1.05 : 1.0),
        transformAlignment: Alignment.center,
        decoration: BoxDecoration(
          color:
              _hovered
                  ? cs.primary.withValues(alpha: 0.1)
                  : cs.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(100),
          border: Border.all(
            color:
                _hovered
                    ? cs.primary.withValues(alpha: 0.5)
                    : cs.outline.withValues(alpha: 0.5),
          ),
        ),
        child: Text(
          widget.label,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
            color: _hovered ? cs.primary : cs.onSurfaceVariant,
            fontSize: 13,
          ),
        ),
      ),
    );
  }
}
