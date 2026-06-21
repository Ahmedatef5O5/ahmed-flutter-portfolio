import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/animations/scroll_reveal.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/responsive/responsive.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/widgets/hover_card.dart';
import '../../../shared/widgets/primary_button.dart';
import '../../../shared/widgets/section_header.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

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
                  label: 'Get in touch',
                  title: "Let's Connect",
                  subtitle: AppStrings.contactSubtitle,
                ),
                const SizedBox(height: 60),
                r.isDesktop ? _DesktopContactLayout() : _MobileContactLayout(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _DesktopContactLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(flex: 5, child: _ContactLinks()),
        const SizedBox(width: 48),
        Expanded(flex: 4, child: _QuickMessage()),
      ],
    );
  }
}

class _MobileContactLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [_ContactLinks(), const SizedBox(height: 40), _QuickMessage()],
    );
  }
}

class _ContactLinks extends StatelessWidget {
  static const _items = [
    (
      icon: Icons.email_rounded,
      label: 'Email',
      value: AppStrings.email,
      url: 'mailto:${AppStrings.email}',
    ),
    (
      icon: Icons.code_rounded,
      label: 'GitHub',
      value: 'github.com/Ahmedatef5O5',
      url: AppStrings.github,
    ),
    (
      icon: Icons.work_outline_rounded,
      label: 'LinkedIn',
      value: 'linkedin.com/in/ahmed-atef',
      url: AppStrings.linkedin,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (final item in _items)
          ScrollReveal(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: _ContactRow(
                icon: item.icon,
                label: item.label,
                value: item.value,
                url: item.url,
              ),
            ),
          ),
      ],
    );
  }
}

class _ContactRow extends StatefulWidget {
  final IconData icon;
  final String label;
  final String value;
  final String url;
  const _ContactRow({
    required this.icon,
    required this.label,
    required this.value,
    required this.url,
  });

  @override
  State<_ContactRow> createState() => _ContactRowState();
}

class _ContactRowState extends State<_ContactRow> {
  bool _copied = false;

  Future<void> _copyToClipboard() async {
    await Clipboard.setData(ClipboardData(text: widget.value));
    setState(() => _copied = true);
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) setState(() => _copied = false);
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return HoverCard(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      onTap: () => launchUrl(Uri.parse(widget.url)),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: cs.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(widget.icon, size: 20, color: cs.primary),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.label,
                  style: tt.bodySmall?.copyWith(color: cs.onSurfaceVariant),
                ),
                const SizedBox(height: 2),
                Text(
                  widget.value,
                  style: tt.titleLarge?.copyWith(fontSize: 15),
                ),
              ],
            ),
          ),
          // Copy button
          Tooltip(
            message: _copied ? 'Copied!' : 'Copy',
            child: IconButton(
              onPressed: _copyToClipboard,
              icon: AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                child: Icon(
                  _copied ? Icons.check_circle_rounded : Icons.copy_rounded,
                  key: ValueKey(_copied),
                  size: 18,
                  color: _copied ? AppColors.success : cs.onSurfaceVariant,
                ),
              ),
            ),
          ),
          Icon(
            Icons.arrow_forward_ios_rounded,
            size: 14,
            color: cs.onSurfaceVariant.withValues(alpha: 0.4),
          ),
        ],
      ),
    );
  }
}

class _QuickMessage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return ScrollReveal(
      delay: const Duration(milliseconds: 150),
      child: HoverCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Open to:', style: tt.titleLarge),
            const SizedBox(height: 16),
            for (final item in const [
              'Junior Flutter Developer roles',
              'Internship opportunities',
              'Freelance Flutter projects',
              'Open source collaboration',
            ])
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  children: [
                    Container(
                      width: 6,
                      height: 6,
                      decoration: BoxDecoration(
                        color: AppColors.accent,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(item, style: tt.bodyMedium),
                  ],
                ),
              ),
            const SizedBox(height: 20),
            PrimaryButton(
              label: 'Send Email',
              icon: Icons.send_rounded,
              onTap: () => launchUrl(Uri.parse('mailto:${AppStrings.email}')),
            ),
          ],
        ),
      ),
    );
  }
}
