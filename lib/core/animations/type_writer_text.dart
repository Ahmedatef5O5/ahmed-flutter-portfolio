import 'package:flutter/material.dart';

class TypewriterText extends StatefulWidget {
  final List<String> texts;
  final TextStyle? style;
  final Duration charDuration;
  final Duration pauseDuration;
  final TextAlign textAlign;

  const TypewriterText({
    super.key,
    required this.texts,
    this.style,
    this.charDuration = const Duration(milliseconds: 65),
    this.pauseDuration = const Duration(milliseconds: 2200),
    this.textAlign = TextAlign.start,
  });

  @override
  State<TypewriterText> createState() => _TypewriterTextState();
}

class _TypewriterTextState extends State<TypewriterText> {
  int _textIndex = 0;
  int _charIndex = 0;
  bool _deleting = false;
  bool _running = true;

  @override
  void initState() {
    super.initState();
    _tick();
  }

  @override
  void dispose() {
    _running = false;
    super.dispose();
  }

  Future<void> _tick() async {
    while (_running && mounted) {
      final current = widget.texts[_textIndex];
      if (!_deleting) {
        if (_charIndex < current.length) {
          _charIndex++;
          if (mounted) setState(() {});
          await Future.delayed(widget.charDuration);
        } else {
          await Future.delayed(widget.pauseDuration);
          if (mounted) _deleting = true;
        }
      } else {
        if (_charIndex > 0) {
          _charIndex--;
          if (mounted) setState(() {});
          await Future.delayed(
            Duration(milliseconds: widget.charDuration.inMilliseconds ~/ 2),
          );
        } else {
          _deleting = false;
          _textIndex = (_textIndex + 1) % widget.texts.length;
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final current = widget.texts[_textIndex];
    final displayed = current.substring(0, _charIndex.clamp(0, current.length));

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(displayed, style: widget.style, textAlign: widget.textAlign),
        _BlinkingCursor(style: widget.style),
      ],
    );
  }
}

class _BlinkingCursor extends StatefulWidget {
  final TextStyle? style;
  const _BlinkingCursor({this.style});

  @override
  State<_BlinkingCursor> createState() => _BlinkingCursorState();
}

class _BlinkingCursorState extends State<_BlinkingCursor>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 530),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _ctrl,
      child: Text(
        '|',
        style: widget.style?.copyWith(
          color: Theme.of(context).colorScheme.primary,
          fontWeight: FontWeight.w300,
        ),
      ),
    );
  }
}
