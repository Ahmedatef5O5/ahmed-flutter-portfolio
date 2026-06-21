import 'package:flutter/material.dart';
import '../../core/widgets/grid_background.dart';
import 'nav_bar.dart';

class ShellLayout extends StatefulWidget {
  final Widget child;
  const ShellLayout({super.key, required this.child});

  @override
  State<ShellLayout> createState() => _ShellLayoutState();
}

class _ShellLayoutState extends State<ShellLayout> {
  final ScrollController _scrollController = ScrollController();
  double _parallax = 0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final next = _scrollController.offset * 0.12;
    if ((next - _parallax).abs() > 0.5) {
      setState(() => _parallax = next);
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridBackground(
        parallaxOffset: _parallax,
        child: Column(
          children: [
            const NavBar(),
            Expanded(
              child: PrimaryScrollController(
                controller: _scrollController,
                child: widget.child,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
