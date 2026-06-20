import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../features/home/presentation/about_page.dart';
import '../features/home/presentation/home_page.dart';
import '../features/contact/presentation/contact_page.dart';
import '../features/projects/presentation/projects_page.dart';
import '../shared/layout/shell_layout.dart';

abstract class AppRoutes {
  static const String home = '/';
  static const String about = '/about';
  static const String projects = '/projects';
  static const String contact = '/contact';
}

final GoRouter appRouter = GoRouter(
  initialLocation: AppRoutes.home,
  debugLogDiagnostics: false,
  routes: [
    ShellRoute(
      builder: (context, state, child) => ShellLayout(child: child),
      routes: [
        GoRoute(
          path: AppRoutes.home,
          pageBuilder: (context, state) => _fade(const HomePage()),
        ),
        GoRoute(
          path: AppRoutes.about,
          pageBuilder: (context, state) => _fade(const AboutPage()),
        ),
        GoRoute(
          path: AppRoutes.projects,
          pageBuilder: (context, state) => _fade(const ProjectsPage()),
        ),
        GoRoute(
          path: AppRoutes.contact,
          pageBuilder: (context, state) => _fade(const ContactPage()),
        ),
      ],
    ),
  ],
);

CustomTransitionPage<void> _fade(Widget child) {
  return CustomTransitionPage<void>(
    child: child,
    transitionsBuilder: (context, animation, _, child) {
      return FadeTransition(
        opacity: CurveTween(curve: Curves.easeInOut).animate(animation),
        child: child,
      );
    },
    transitionDuration: const Duration(milliseconds: 300),
  );
}
