import 'package:flutter/material.dart';
import 'package:not_static_icons_app/data/icons_data.dart';
import 'package:url_launcher/url_launcher.dart';
import '../widgets/icon_card.dart';

/// Demo page showcasing animated SVG icons
class AnimatedIconsDemo extends StatelessWidget {
  const AnimatedIconsDemo({super.key});

  // TODO
  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      debugPrint('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        title: const Text(
          'not_static_icons',
          style: TextStyle(fontSize: 24, fontFamily: 'JetBrainsMono'),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Row(
              spacing: 10,
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildTextLinkContainer('pub.dev', 'https://pub.dev'), // TODO
                _buildTextLinkContainer('github', 'https://github.com'), // TODO
                _buildTextLinkContainer(
                  'support',
                  'mailto:support@example.com',
                ), // TODO
              ],
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Description Section
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'simple flutter package for adding animated icons into your project',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                    fontFamily: 'JetBrainsMono',
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'let\'s make this library awesome together',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                    fontFamily: 'JetBrainsMono',
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    const Text(
                      'made with ',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black54,
                        fontFamily: 'JetBrainsMono',
                      ),
                    ),
                    _buildTextLinkContainer('flutter', 'https://flutter.dev'),
                    const Text(
                      ' and ',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black54,
                        fontFamily: 'JetBrainsMono',
                      ),
                    ),
                    _buildTextLinkContainer(
                      'lucide icons',
                      'https://lucide.dev',
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    const Text(
                      'inspired by ',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black54,
                        fontFamily: 'JetBrainsMono',
                      ),
                    ),
                    _buildTextLinkContainer(
                      'pqoqubbw/icons',
                      'https://icons.pqoqubbw.dev',
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 48),

            // Icons Grid Section
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 6,
                childAspectRatio: 1.7,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: icons.length,
              itemBuilder: (context, index) {
                final icon = icons[index];
                return IconCard(name: icon.name, iconWidget: icon.widget);
              },
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildTextLinkContainer(String text, String url) {
    return InkWell(
      onTap: () => _launchUrl(url),
      borderRadius: BorderRadius.circular(6),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
        decoration: BoxDecoration(
          color: Colors.grey.shade50,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: Colors.grey),
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.black,
            fontFamily: 'JetBrainsMono',
          ),
        ),
      ),
    );
  }
}
