import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/content/app_links.dart';
import '../../../core/widgets/glass_card.dart';
import '../../../core/widgets/hover_lift.dart';
import 'section_shell.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  Future<void> _open(String url) async {
    final uri = Uri.parse(url);
    await launchUrl(uri, mode: LaunchMode.platformDefault);
  }

  @override
  Widget build(BuildContext context) {
    return SectionShell(
      eyebrow: 'Contact',
      title: 'Available for Flutter freelance and remote opportunities.',
      description:
          'If you need a Flutter engineer who can work across product logic, architecture, and shipping detail, reach out through the channel that fits your workflow.',
      child: HoverLift(
        child: GlassCard(
          borderRadius: 32,
          child: Padding(
            padding: const EdgeInsets.all(28),
            child: Wrap(
              spacing: 14,
              runSpacing: 14,
              children: [
                ElevatedButton(
                  onPressed: () => _open(AppLinks.email),
                  child: const Text('Email'),
                ),
                OutlinedButton(
                  onPressed: () => _open(AppLinks.whatsapp),
                  child: const Text('WhatsApp'),
                ),
                OutlinedButton(
                  onPressed: () => _open(AppLinks.linkedIn),
                  child: const Text('LinkedIn'),
                ),
                OutlinedButton(
                  onPressed: () => _open(AppLinks.github),
                  child: const Text('GitHub'),
                ),
                OutlinedButton(
                  onPressed: () => _open(AppLinks.cv),
                  child: const Text('Download CV'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
