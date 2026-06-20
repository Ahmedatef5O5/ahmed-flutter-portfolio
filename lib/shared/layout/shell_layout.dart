import 'package:flutter/material.dart';
import 'nav_bar.dart';

class ShellLayout extends StatelessWidget {
  final Widget child;
  const ShellLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [const NavBar(), Expanded(child: child)]),
    );
  }
}
