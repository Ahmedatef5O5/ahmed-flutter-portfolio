import 'package:ahmed_portfolio/routing/app_routing.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/theme_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final themeController = await ThemeController.init();
  runApp(
    ChangeNotifierProvider.value(
      value: themeController,
      child: const PortfolioApp(),
    ),
  );
}

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = context.watch<ThemeController>();
    return MaterialApp.router(
      title: 'Ahmed Atef — Flutter Developer',
      debugShowCheckedModeBanner: false,
      themeMode: themeController.mode,
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      routerConfig: appRouter,
    );
  }
}
