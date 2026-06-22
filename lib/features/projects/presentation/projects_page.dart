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
      primary: true,
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

                    if (cols == 1) {
                      return Column(
                        children: [
                          for (int i = 0; i < kProjects.length; i++) ...[
                            ProjectCard(project: kProjects[i], index: i),
                            if (i != kProjects.length - 1)
                              const SizedBox(height: 20),
                          ],
                        ],
                      );
                    }

                    return
                    //  Wrap(
                    //   spacing: 20,
                    //   runSpacing: 20,
                    //   children: List.generate(
                    //     kProjects.length,
                    //     (i) => SizedBox(
                    //       width: (constraints.maxWidth - 20) / 2,
                    //       child: ProjectCard(project: kProjects[i], index: i),
                    //     ),
                    //   ),
                    // );
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: cols,
                        mainAxisSpacing: 20,
                        crossAxisSpacing: 20,
                        childAspectRatio: 1.3,
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
