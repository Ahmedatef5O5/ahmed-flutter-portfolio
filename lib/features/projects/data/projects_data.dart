class ProjectModel {
  final String id;
  final String title;
  final String description;
  final List<String> techStack;
  final String? imageAsset;
  final String? githubUrl;
  final String? demoUrl;
  final String? apkUrl;
  final bool isFeatured;

  const ProjectModel({
    required this.id,
    required this.title,
    required this.description,
    required this.techStack,
    this.imageAsset,
    this.githubUrl,
    this.demoUrl,
    this.apkUrl,
    this.isFeatured = false,
  });
}

const List<ProjectModel> kProjects = [
  ProjectModel(
    id: 'tafawuq',
    title: 'Tafawuq',
    description:
        'A full-featured e-commerce app with product catalog, cart, orders, and Firebase authentication. Built with Clean Architecture and BLoC state management.',
    techStack: ['Flutter', 'BLoC', 'Firebase', 'Clean Architecture'],
    githubUrl: 'https://github.com/Ahmedatef5O5/tafawuq',
    isFeatured: true,
  ),
  ProjectModel(
    id: 'newswave',
    title: 'NewsWave',
    description:
        'A news aggregator with Arabic locale support, offline caching with Hive, real-time translation via MyMemory API, and Glassmorphism UI.',
    techStack: ['Flutter', 'Cubit', 'Hive', 'REST API', 'Supabase'],
    githubUrl: 'https://github.com/Ahmedatef5O5/newswave',
    isFeatured: true,
  ),
  ProjectModel(
    id: 'chat',
    title: 'Real-Time Chat',
    description:
        'Live messaging app with Supabase Realtime, ZEGOCLOUD video calls, user presence, and clean chat UI.',
    techStack: ['Flutter', 'Cubit', 'Supabase', 'ZEGOCLOUD'],
    githubUrl: 'https://github.com/Ahmedatef5O5/chat-app',
    isFeatured: true,
  ),
  ProjectModel(
    id: 'bookly',
    title: 'Bookly',
    description:
        'Book discovery app using Open Library REST API with search, categories, and offline bookmarking. Clean Architecture with Cubit.',
    techStack: ['Flutter', 'Cubit', 'REST API', 'Clean Architecture'],
    githubUrl: 'https://github.com/Ahmedatef5O5/bookly',
  ),
];
