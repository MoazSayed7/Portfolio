import 'package:easy_localization/easy_localization.dart';
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
      eyebrow: tr('sections.contact.eyebrow'),
      title: tr('sections.contact.title'),
      description: tr('sections.contact.description'),
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
                  child: Text(tr('common.email')),
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
                  child: Text(tr('common.download_cv')),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
