import 'package:flutter/material.dart';
import 'widgets/hero_section.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        children: [
          HeroSection(),
          // More sections added later (skills strip, featured projects teaser)
        ],
      ),
    );
  }
}
