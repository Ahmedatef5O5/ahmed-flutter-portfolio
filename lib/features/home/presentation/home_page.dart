import 'package:flutter/material.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/responsive/responsive.dart';
import 'widgets/hero_section.dart';
import 'widgets/tech_strip.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final r = Responsive.of(context);
    final hPad = r.value(mobile: 20.0, desktop: 60.0);

    return SingleChildScrollView(
      primary: true,
      child: Column(
        children: [
          const HeroSection(),

          Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: AppSizes.maxContentWidth,
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: hPad, vertical: 24),
                child: const TechStrip(),
              ),
            ),
          ),

          const _Footer(),
        ],
      ),
    );
  }
}

class _Footer extends StatelessWidget {
  const _Footer();
  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    return Container(
      margin: const EdgeInsets.only(top: 32),
      padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 32),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: cs.outline.withValues(alpha: 0.3)),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '© ${DateTime.now().year} Ahmed Atef · Built with ',
            style: tt.bodySmall?.copyWith(color: cs.onSurfaceVariant),
          ),
          const Icon(
            Icons.flutter_dash_rounded,
            size: 14,
            color: Color(0xFF54C5F8),
          ),
          Text(
            ' Flutter',
            style: tt.bodySmall?.copyWith(
              color: const Color(0xFF54C5F8),
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
