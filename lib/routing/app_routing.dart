import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../features/about/presentation/about_page.dart';
import '../features/home/presentation/home_page.dart';
import '../features/contact/presentation/contact_page.dart';
import '../features/projects/presentation/project_details_page.dart';
import '../features/projects/presentation/projects_page.dart';
import '../shared/layout/shell_layout.dart';

abstract class AppRoutes {
  static const String home = '/';
  static const String about = '/about';
  static const String projects = '/projects';
  static const String projectDetail = '/projects/:id';
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
          pageBuilder: (context, state) => _fadeScale(state, const HomePage()),
        ),
        GoRoute(
          path: AppRoutes.about,
          pageBuilder: (context, state) => _fadeScale(state, const AboutPage()),
        ),
        GoRoute(
          path: AppRoutes.projects,
          pageBuilder:
              (context, state) => _fadeScale(state, const ProjectsPage()),
          routes: [
            GoRoute(
              path: ':id',
              pageBuilder: (context, state) {
                final id = state.pathParameters['id'] ?? '';
                return _fadeScale(state, ProjectDetailPage(projectId: id));
              },
            ),
          ],
        ),
        GoRoute(
          path: AppRoutes.contact,
          pageBuilder:
              (context, state) => _fadeScale(state, const ContactPage()),
        ),
      ],
    ),
  ],
);

CustomTransitionPage<void> _fadeScale(GoRouterState state, Widget child) {
  return CustomTransitionPage<void>(
    key: state.pageKey,
    name: state.name,
    child: child,
    transitionsBuilder: (context, animation, _, child) {
      final curved = CurvedAnimation(
        parent: animation,
        curve: Curves.easeOutCubic,
      );
      return FadeTransition(
        opacity: curved,
        child: Transform.scale(
          scale: 0.98 + (0.02 * curved.value),
          child: child,
        ),
      );
    },
    transitionDuration: const Duration(milliseconds: 380),
    reverseTransitionDuration: const Duration(milliseconds: 280),
  );
}
