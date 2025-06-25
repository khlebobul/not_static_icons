import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:not_static_icons_app/data/icons_data.dart' as icons_data;
import 'package:url_launcher/url_launcher.dart';
import '../widgets/icon_card.dart';

/// Demo page showcasing animated SVG icons
class AnimatedIconsDemo extends StatefulWidget {
  const AnimatedIconsDemo({super.key});

  @override
  State<AnimatedIconsDemo> createState() => _AnimatedIconsDemoState();
}

class _AnimatedIconsDemoState extends State<AnimatedIconsDemo> {
  static const String _installCommand = 'flutter pub add not_static_icons';
  static const double _gridMaxCrossAxisExtent = 170.0;
  static const double _gridSpacing = 16.0;

  final TextEditingController _searchController = TextEditingController();
  List<icons_data.IconData> _filteredIcons = [];

  @override
  void initState() {
    super.initState();
    _filteredIcons = icons_data.icons;
    _searchController.addListener(_filterIcons);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterIcons() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredIcons = icons_data.icons.where((icon) {
        return icon.name.toLowerCase().contains(query);
      }).toList();
    });
  }

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      debugPrint('Could not launch $url');
    }
  }

  Future<void> _copyToClipboard(String text) async {
    await Clipboard.setData(ClipboardData(text: text));
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'copied to clipboard: $text',
            style: const TextStyle(fontFamily: 'JetBrainsMono'),
          ),
          duration: const Duration(seconds: 2),
          backgroundColor: Colors.black87,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDescriptionSection(),
            const SizedBox(height: 24),
            _buildInstallationSection(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Divider(color: Colors.grey.shade200),
            ),
            _buildSearchSection(),
            const SizedBox(height: 16),
            _buildIconsGrid(),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: false,
      title: const Text(
        'not_static_icons',
        style: TextStyle(fontSize: 18, fontFamily: 'JetBrainsMono'),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: Row(
            spacing: 10,
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildTextLinkContainer(
                'pub.dev',
                'https://pub.dev/packages/not_static_icons',
              ),
              _buildTextLinkContainer(
                'github',
                'https://github.com/khlebobul/not_static_icons',
              ),
              _buildTextLinkContainer('support', 'https://t.me/khlebobul_dev'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDescriptionSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildDescriptionText(
          'simple flutter package for adding animated icons into your project',
        ),
        const SizedBox(height: 12),
        _buildDescriptionText('let\'s make this library awesome together'),
        const SizedBox(height: 12),
        _buildCreditsRow(),
      ],
    );
  }

  Widget _buildDescriptionText(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 14,
        color: Colors.black54,
        fontFamily: 'JetBrainsMono',
      ),
    );
  }

  Widget _buildCreditsRow() {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 4.0,
      runSpacing: 4.0,
      children: [
        _buildDescriptionText('made with '),
        _buildTextLinkContainer('flutter', 'https://flutter.dev'),
        _buildDescriptionText(' and '),
        _buildTextLinkContainer('lucide icons', 'https://lucide.dev'),
        _buildDescriptionText(' inspired by '),
        _buildTextLinkContainer('pqoqubbw/icons', 'https://icons.pqoqubbw.dev'),
      ],
    );
  }

  Widget _buildInstallationSection() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          InkWell(
            onTap: () => _copyToClipboard(_installCommand),
            child: SvgPicture.asset(
              'assets/icons/copy.svg',
              width: 16,
              height: 16,
              colorFilter: ColorFilter.mode(
                Colors.grey.shade700,
                BlendMode.srcIn,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              _installCommand,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black54,
                fontFamily: 'JetBrainsMono',
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchSection() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          SvgPicture.asset(
            'assets/icons/search.svg',
            width: 16,
            height: 16,
            colorFilter: ColorFilter.mode(
              Colors.grey.shade700,
              BlendMode.srcIn,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'search ${icons_data.icons.length} icons',
                hintStyle: TextStyle(
                  color: Colors.grey.shade500,
                  fontFamily: 'JetBrainsMono',
                  fontSize: 14,
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.zero,
              ),
              style: const TextStyle(fontFamily: 'JetBrainsMono', fontSize: 14),
            ),
          ),
          if (_searchController.text.isNotEmpty)
            InkWell(
              onTap: _searchController.clear,
              borderRadius: BorderRadius.circular(4),
              child: Padding(
                padding: const EdgeInsets.all(4),
                child: Icon(Icons.clear, color: Colors.grey.shade600, size: 18),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildIconsGrid() {
    if (_filteredIcons.isEmpty) {
      return _buildEmptyState();
    }

    return Wrap(
      spacing: _gridSpacing,
      runSpacing: _gridSpacing,
      children: _filteredIcons.map((icon) {
        return SizedBox(
          width: _gridMaxCrossAxisExtent,
          height: _gridMaxCrossAxisExtent,
          child: IconCard(name: icon.name, iconWidget: icon.widget),
        );
      }).toList(),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(48.0),
        child: Column(
          children: [
            Text(
              'no icons found',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey.shade600,
                fontFamily: 'JetBrainsMono',
              ),
            ),
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
