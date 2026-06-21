import 'package:flutter/material.dart';

class ProjectModel {
  final String id;
  final String title;
  final String tagline;
  final String description;
  final List<String> techStack;
  final List<Color> gradientColors;
  final IconData appIcon;
  final String? imageAsset;
  final String? githubUrl;
  final String? demoUrl;
  final String? apkUrl;
  final bool isFeatured;

  const ProjectModel({
    required this.id,
    required this.title,
    required this.tagline,
    required this.description,
    required this.techStack,
    required this.gradientColors,
    required this.appIcon,
    this.imageAsset,
    this.githubUrl,
    this.demoUrl,
    this.apkUrl,
    this.isFeatured = false,
  });
}

const List<ProjectModel> kProjects = [
  ProjectModel(
    id: 'social_mate',
    title: 'Social Mate',
    tagline: 'Connect · Share · Discover · Belong',
    description:
        'Production-grade social media platform with real-time 1-on-1 & group chat, audio/video calls via ZEGOCLOUD, stories, push notifications via FCM, 6+ dynamic themes, and live presence system — all on Supabase Realtime.',
    techStack: ['Flutter', 'Supabase', 'Firebase', 'ZEGOCLOUD', 'BLoC'],
    gradientColors: [Color(0xFF6C63FF), Color(0xFF3B1FA3)],
    appIcon: Icons.chat_bubble_rounded,
    githubUrl: 'https://github.com/Ahmedatef5O5/Social-Media-App',
    isFeatured: true,
  ),
  ProjectModel(
    id: 'newswave',
    title: 'NewsWave',
    tagline: 'Your world, curated — in real time',
    description:
        'Bilingual (EN/AR) news reader with reactive RTL support, offline-first Hive caching, dependency-free network resilience, on-device translation via MyMemory API, and Clean Architecture with strict DIP enforcement.',
    techStack: ['Flutter', 'Cubit', 'Hive', 'Supabase', 'REST API'],
    gradientColors: [Color(0xFF1A73E8), Color(0xFF0D47A1)],
    appIcon: Icons.newspaper_rounded,
    githubUrl: 'https://github.com/Ahmedatef5O5/News-App',
    isFeatured: true,
  ),
  ProjectModel(
    id: 'findash',
    title: 'FinDash',
    tagline: 'Responsive Finance Dashboard',
    description:
        'Fully responsive admin dashboard adapting across mobile, tablet, and desktop via custom AdaptiveLayout & SizeConfig. Features interactive FL Charts, card carousel, transaction history, and quick invoice creation.',
    techStack: ['Flutter', 'fl_chart', 'Adaptive UI', 'Dart'],
    gradientColors: [Color(0xFF00C853), Color(0xFF00695C)],
    appIcon: Icons.bar_chart_rounded,
    githubUrl: 'https://github.com/Ahmedatef5O5/responsive_dash_board',
    isFeatured: true,
  ),
];
