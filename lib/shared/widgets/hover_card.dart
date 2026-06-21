import 'package:flutter/material.dart';

class HoverCard extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry padding;
  final BorderRadius? borderRadius;
  final bool useGradientBorder;

  const HoverCard({
    super.key,
    required this.child,
    this.onTap,
    this.padding = const EdgeInsets.all(24),
    this.borderRadius,
    this.useGradientBorder = false,
  });

  @override
  State<HoverCard> createState() => _HoverCardState();
}

class _HoverCardState extends State<HoverCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _anim;
  bool _hovered = false;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _anim = CurvedAnimation(parent: _ctrl, curve: Curves.easeOut);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final radius = widget.borderRadius ?? BorderRadius.circular(16);

    return MouseRegion(
      cursor:
          widget.onTap != null ? SystemMouseCursors.click : MouseCursor.defer,
      onEnter: (_) {
        setState(() => _hovered = true);
        _ctrl.forward();
      },
      onExit: (_) {
        setState(() => _hovered = false);
        _ctrl.reverse();
      },
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedBuilder(
          animation: _anim,
          builder:
              (_, child) => Transform.translate(
                offset: Offset(0, -4 * _anim.value),
                child: Container(
                  decoration: BoxDecoration(
                    color: cs.surface,
                    borderRadius: radius,
                    border: Border.all(
                      color:
                          Color.lerp(
                            cs.outline.withValues(alpha: isDark ? 0.25 : 0.55),
                            cs.primary.withValues(alpha: 0.55),
                            _anim.value,
                          )!,
                      width: 1.0 + (0.5 * _anim.value),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: cs.primary.withValues(
                          alpha: (isDark ? 0.15 : 0.07) * _anim.value,
                        ),
                        blurRadius: 24 * _anim.value,
                        offset: Offset(0, 8 * _anim.value),
                      ),
                    ],
                  ),
                  child: child,
                ),
              ),
          child: Padding(padding: widget.padding, child: widget.child),
        ),
      ),
    );
  }
}
