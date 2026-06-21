import 'package:ahmed_portfolio/shared/layout/app_drawer.dart';
import 'package:flutter/material.dart';
import '../../core/animations/scroll_notifier.dart';
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
  final ValueNotifier<Offset?> _spotlight = ValueNotifier(null);
  double _parallax = 0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final shouldBeScrolled = _scrollController.offset > 10;
    if (navScrolled.value != shouldBeScrolled) {
      navScrolled.value = shouldBeScrolled;
    }

    final next = _scrollController.offset * 0.12;
    if ((next - _parallax).abs() > 0.5) {
      setState(() => _parallax = next);
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    _spotlight.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: const AppDrawer(),
      body: MouseRegion(
        opaque: false,
        onHover: (e) => _spotlight.value = e.localPosition,
        onExit: (_) => _spotlight.value = null,
        child: ValueListenableBuilder<Offset?>(
          valueListenable: _spotlight,
          builder: (context, spotlight, child) {
            return GridBackground(
              parallaxOffset: _parallax,
              spotlight: spotlight,
              child: child!,
            );
          },
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
      ),
    );
  }
}
