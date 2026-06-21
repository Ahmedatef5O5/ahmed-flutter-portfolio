import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LearnMoreButton extends StatefulWidget {
  final String projectId;
  final Color accentColor;
  const LearnMoreButton({
    super.key,
    required this.projectId,
    required this.accentColor,
  });

  @override
  State<LearnMoreButton> createState() => _LearnMoreButtonState();
}

class _LearnMoreButtonState extends State<LearnMoreButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => context.go('/projects/${widget.projectId}'),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            gradient:
                _hovered
                    ? LinearGradient(
                      colors: [
                        widget.accentColor,
                        widget.accentColor.withValues(alpha: 0.75),
                      ],
                    )
                    : null,
            color: _hovered ? null : widget.accentColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: widget.accentColor.withValues(alpha: _hovered ? 0 : 0.35),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.arrow_forward_rounded,
                size: 15,
                color: _hovered ? Colors.white : widget.accentColor,
              ),
              const SizedBox(width: 6),
              Text(
                'Learn More',
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: _hovered ? Colors.white : widget.accentColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
