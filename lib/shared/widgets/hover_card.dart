import 'package:flutter/material.dart';

/// Card with subtle lift + border glow on hover.
class HoverCard extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry padding;
  final BorderRadius? borderRadius;

  const HoverCard({
    super.key,
    required this.child,
    this.onTap,
    this.padding = const EdgeInsets.all(24),
    this.borderRadius,
  });

  @override
  State<HoverCard> createState() => _HoverCardState();
}

class _HoverCardState extends State<HoverCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final radius = widget.borderRadius ?? BorderRadius.circular(16);

    return MouseRegion(
      cursor:
          widget.onTap != null ? SystemMouseCursors.click : MouseCursor.defer,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
          transform: Matrix4.translationValues(0, _hovered ? -4 : 0, 0),
          decoration: BoxDecoration(
            color: cs.surface,
            borderRadius: radius,
            border: Border.all(
              color:
                  _hovered
                      ? cs.primary.withValues(alpha: 0.5)
                      : cs.outline.withValues(alpha: isDark ? 0.3 : 0.6),
              width: _hovered ? 1.5 : 1,
            ),
            boxShadow:
                _hovered
                    ? [
                      BoxShadow(
                        color: cs.primary.withValues(
                          alpha: isDark ? 0.15 : 0.08,
                        ),
                        blurRadius: 24,
                        offset: const Offset(0, 8),
                      ),
                    ]
                    : [],
          ),
          child: Padding(padding: widget.padding, child: widget.child),
        ),
      ),
    );
  }
}
