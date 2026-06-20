import 'package:flutter/material.dart';

enum ButtonVariant { filled, outlined, ghost }

class PrimaryButton extends StatefulWidget {
  final String label;
  final VoidCallback? onTap;
  final IconData? icon;
  final ButtonVariant variant;

  const PrimaryButton({
    super.key,
    required this.label,
    this.onTap,
    this.icon,
    this.variant = ButtonVariant.filled,
  });

  @override
  State<PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton> {
  bool _hovered = false;
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final isFilled = widget.variant == ButtonVariant.filled;
    final isOutlined = widget.variant == ButtonVariant.outlined;

    final bgColor =
        isFilled
            ? (_hovered ? cs.primary.withValues(alpha: 0.85) : cs.primary)
            : (_hovered
                ? cs.primary.withValues(alpha: 0.06)
                : Colors.transparent);

    final fgColor = isFilled ? Colors.white : cs.primary;

    return MouseRegion(
      cursor:
          widget.onTap != null
              ? SystemMouseCursors.click
              : SystemMouseCursors.forbidden,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTapDown: (_) => setState(() => _pressed = true),
        onTapUp: (_) => setState(() => _pressed = false),
        onTapCancel: () => setState(() => _pressed = false),
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          transform:
              Matrix4.identity()..scaleByDouble(
                _pressed ? 0.97 : 1.0,
                _pressed ? 0.97 : 1.0,
                1.0,
                1.0,
              ),
          transformAlignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color:
                  isOutlined || widget.variant == ButtonVariant.ghost
                      ? cs.primary.withValues(alpha: isOutlined ? 0.6 : 0)
                      : Colors.transparent,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.icon != null) ...[
                Icon(widget.icon, size: 18, color: fgColor),
                const SizedBox(width: 8),
              ],
              Text(
                widget.label,
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: fgColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
