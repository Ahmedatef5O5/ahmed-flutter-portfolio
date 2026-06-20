import 'package:flutter/material.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/responsive/responsive.dart';
import '../../../shared/widgets/section_header.dart';
import '../data/projects_data.dart';
import 'widgets/project_card.dart';

class ProjectsPage extends StatelessWidget {
  const ProjectsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final r = Responsive.of(context);

    return SingleChildScrollView(
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: AppSizes.maxContentWidth),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: r.value(mobile: 20.0, desktop: 60.0),
              vertical: AppSizes.sectionPadding,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SectionHeader(
                  label: 'What I built',
                  title: 'Projects',
                  subtitle:
                      'Production-grade apps built with Flutter, Clean Architecture, and modern tooling.',
                ),
                const SizedBox(height: 56),
                LayoutBuilder(
                  builder: (ctx, constraints) {
                    final cols = constraints.maxWidth > 800 ? 2 : 1;
                    return GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: cols,
                        mainAxisSpacing: 20,
                        crossAxisSpacing: 20,
                        childAspectRatio: cols == 2 ? 1.55 : 1.8,
                      ),
                      itemCount: kProjects.length,
                      itemBuilder:
                          (_, i) =>
                              ProjectCard(project: kProjects[i], index: i),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
