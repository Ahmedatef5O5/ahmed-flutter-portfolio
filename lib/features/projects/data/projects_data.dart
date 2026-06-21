import 'package:flutter/material.dart';

class ProjectFeature {
  final IconData icon;
  final String title;
  final String description;

  const ProjectFeature({
    required this.icon,
    required this.title,
    required this.description,
  });
}

class ProjectModel {
  final String id;
  final String title;
  final String tagline;
  final String description;
  final String fullDescription;
  final List<String> techStack;
  final List<Color> gradientColors;
  final IconData appIcon;
  final List<ProjectFeature> features;
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
    required this.fullDescription,
    required this.techStack,
    required this.gradientColors,
    required this.appIcon,
    required this.features,
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
    fullDescription:
        'Social Mate is a comprehensive cross-platform social networking app that brings together real-time messaging, audio/video calling, stories, and smart push notifications — all under a beautifully themed, highly customizable UI. Built on Feature-First Clean Architecture with BLoC/Cubit state management, every feature is a self-contained module with its own data, domain, and presentation layers.',
    techStack: ['Flutter', 'Supabase', 'Firebase', 'ZEGOCLOUD', 'BLoC'],
    gradientColors: [Color(0xFF7C6FFF), Color(0xFF3B1FA3)],
    appIcon: Icons.chat_bubble_rounded,
    features: [
      ProjectFeature(
        icon: Icons.chat_rounded,
        title: 'Real-time Messaging',
        description:
            '1-on-1 & group chats with rich media, emoji reactions, typing indicators, and read receipts — powered by Supabase Realtime.',
      ),
      ProjectFeature(
        icon: Icons.videocam_rounded,
        title: 'Audio & Video Calls',
        description:
            'High-quality calls via ZEGOCLOUD SDK with full-screen incoming call UI, ringtone alerts, and live call duration — even when the app is closed (FCM full-screen intents).',
      ),
      ProjectFeature(
        icon: Icons.auto_stories_rounded,
        title: 'Stories & Status',
        description:
            'Text, image, and video stories with gradient backgrounds, tap-to-pause progress bar, and auto-expiry following standard social media conventions.',
      ),
      ProjectFeature(
        icon: Icons.notifications_rounded,
        title: 'Smart Push Notifications',
        description:
            'FCM + flutter_local_notifications for instant alerts on messages, group chats, and calls — with actionable reply/decline directly from the notification shade.',
      ),
      ProjectFeature(
        icon: Icons.palette_rounded,
        title: '6+ Dynamic Themes',
        description:
            'Ocean, Sunset, Midnight, Emerald, Carbon, and more — with seamless light/dark switching and smooth Lottie animations throughout.',
      ),
      ProjectFeature(
        icon: Icons.circle_rounded,
        title: 'Live Presence System',
        description:
            'Real-time Online / Last Seen status for all users, auto-updated based on app foreground/background state and integrated into every chat surface.',
      ),
    ],
    githubUrl: 'https://github.com/Ahmedatef5O5/Social-Media-App',
    isFeatured: true,
  ),
  ProjectModel(
    id: 'newswave',
    title: 'NewsWave',
    tagline: 'Your world, curated — in real time',
    description:
        'Bilingual (EN/AR) news reader with reactive RTL support, offline-first Hive caching, dependency-free network resilience, on-device translation via MyMemory API, and Clean Architecture with strict DIP enforcement.',
    fullDescription:
        'NewsWave is a production-ready Flutter news application delivering breaking headlines, personalized feeds, and offline-first reading — fully bilingual (English/Arabic) with reactive RTL support. Built with strict Clean Architecture and enforced Dependency Inversion at every repository boundary, it handles real-world failure modes like captive portals, API rate limits, and stale cross-language caches by construction.',
    techStack: ['Flutter', 'Cubit', 'Hive', 'Supabase', 'REST API'],
    gradientColors: [Color(0xFF1A73E8), Color(0xFF0D47A1)],
    appIcon: Icons.newspaper_rounded,
    features: [
      ProjectFeature(
        icon: Icons.language_rounded,
        title: 'Fully Bilingual (EN/AR)',
        description:
            '100% localized with zero hardcoded strings — reactive RTL/LTR layout switching, locale-aware typography (Poppins/Cairo), and locale-namespaced Hive caching to prevent cross-language cache pollution.',
      ),
      ProjectFeature(
        icon: Icons.wifi_off_rounded,
        title: 'Offline-First Architecture',
        description:
            'Hive-backed locale-namespaced cache for headlines and paginated feeds. Articles already seen are always available offline, in the correct language, with zero JSON overhead on the hot path.',
      ),
      ProjectFeature(
        icon: Icons.translate_rounded,
        title: 'On-Device Translation',
        description:
            'Chunked, field-merged translation pipeline via MyMemory API — batches of 3 articles at a time, cutting API calls by 80%+ vs naive per-field approach. Cached per-article, purged on locale switch.',
      ),
      ProjectFeature(
        icon: Icons.radar_rounded,
        title: 'Dependency-Free Connectivity',
        description:
            'No connectivity_plus. Custom NetworkInfoImpl races multiple HTTP endpoints simultaneously — correctly detecting captive portals that appear online but block real traffic.',
      ),
      ProjectFeature(
        icon: Icons.search_rounded,
        title: 'Smart Search',
        description:
            '500ms debounced search with infinite scroll, locale-aware results, and automatic re-query on language switch — powered by NewsAPI /v2/everything with title-scoped precision.',
      ),
      ProjectFeature(
        icon: Icons.bookmark_rounded,
        title: 'Locale-Aware Favorites',
        description:
            'Save articles in any language — they are dynamically re-translated when you revisit your list in a different locale. Persisted indefinitely via Hive.',
      ),
    ],
    githubUrl: 'https://github.com/Ahmedatef5O5/News-App',
    isFeatured: true,
  ),
  ProjectModel(
    id: 'findash',
    title: 'FinDash',
    tagline: 'Responsive Finance Dashboard',
    description:
        'Fully responsive admin dashboard adapting across mobile, tablet, and desktop via custom AdaptiveLayout & SizeConfig. Features interactive FL Charts, card carousel, transaction history, and quick invoice creation.',
    fullDescription:
        'FinDash is a production-ready financial admin dashboard built entirely with Flutter. It demonstrates a clean, scalable architecture that elegantly handles layout adaptation across all screen sizes — from compact mobile viewports to wide desktop monitors — without a single line of platform-specific code. Every breakpoint has a dedicated layout class for pixel-perfect results.',
    techStack: ['Flutter', 'fl_chart', 'Adaptive UI', 'Dart'],
    gradientColors: [Color(0xFF00C853), Color(0xFF00695C)],
    appIcon: Icons.bar_chart_rounded,
    features: [
      ProjectFeature(
        icon: Icons.devices_rounded,
        title: 'Adaptive Layouts',
        description:
            'Three dedicated layouts (Mobile/Tablet/Desktop) selected automatically at runtime via AdaptiveLayout + LayoutBuilder — breakpoints at 800px and 1300px for pixel-perfect results on every device.',
      ),
      ProjectFeature(
        icon: Icons.pie_chart_rounded,
        title: 'Interactive FL Charts',
        description:
            'Touch-responsive donut chart with animated segment expansion showing income breakdown by category. Tap any segment to highlight and see the detailed value.',
      ),
      ProjectFeature(
        icon: Icons.credit_card_rounded,
        title: 'Card Carousel',
        description:
            'ExpandablePageView-powered card carousel with animated dot indicators for smooth swipe-through navigation between multiple financial cards.',
      ),
      ProjectFeature(
        icon: Icons.receipt_long_rounded,
        title: 'Quick Invoice',
        description:
            'Inline invoice creation form with Recipient, Amount, and Bank Name fields — Cancel and Send Payment actions with a clean, minimal UI.',
      ),
      ProjectFeature(
        icon: Icons.swap_vert_rounded,
        title: 'Transaction History',
        description:
            'Color-coded transaction list distinguishing withdrawals from deposits at a glance — with title, subtitle, and signed amounts in TransactionItem cards.',
      ),
      ProjectFeature(
        icon: Icons.text_fields_rounded,
        title: 'Responsive Typography',
        description:
            'Custom getResponsiveFontSize() utility scales all text with clamp(min, scaleFactor × baseSize, max) based on viewport width — readable on every screen size.',
      ),
    ],
    githubUrl: 'https://github.com/Ahmedatef5O5/responsive_dash_board',
    isFeatured: true,
  ),
];
