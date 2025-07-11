import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:not_static_icons_app/data/app_consts.dart';
import 'package:not_static_icons_app/data/icons_data.dart' as icons_data;
import 'package:url_launcher/url_launcher.dart';
import '../widgets/icon_card.dart';

class AnimatedIconsDemo extends StatefulWidget {
  const AnimatedIconsDemo({super.key});

  @override
  State<AnimatedIconsDemo> createState() => _AnimatedIconsDemoState();
}

class _AnimatedIconsDemoState extends State<AnimatedIconsDemo> {
  static const double _gridMaxCrossAxisExtent = 170.0;
  static const double _gridSpacing = 16.0;

  final TextEditingController _searchController = TextEditingController();
  List<icons_data.IconData> _filteredIcons = [];
  bool _showSupportDropdown = false;

  List<icons_data.IconData> get _sortedIcons {
    final sorted = List<icons_data.IconData>.from(icons_data.icons);
    sorted.sort((a, b) => a.name.compareTo(b.name));
    return sorted;
  }

  @override
  void initState() {
    super.initState();
    _filteredIcons = _sortedIcons;
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
      _filteredIcons = _sortedIcons
          .where((icon) => icon.name.toLowerCase().contains(query))
          .toList();
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
            '${AnimatedIconsStrings.copiedToClipboardPrefix}$text',
            style: const TextStyle(fontFamily: AnimatedIconsStrings.fontFamily),
          ),
          duration: const Duration(seconds: 2),
          backgroundColor: Colors.black87,
        ),
      );
    }
  }

  String _generateIconCodeUrl(String iconName) {
    final fileName = '${iconName.replaceAll('-', '_')}_icon.dart';
    return '${AnimatedIconsStrings.githubIconsBaseUrl}$fileName';
  }

  Future<void> _openIconCode(String iconName) async {
    final url = _generateIconCodeUrl(iconName);
    await _launchUrl(url);
  }

  String _convertToIconClassName(String kebabCaseName) {
    // Convert kebab-case to PascalCase and add 'Icon' suffix
    // e.g., 'activity' -> 'ActivityIcon', 'a-arrow-down' -> 'AArrowDownIcon'
    return '${kebabCaseName.split('-').map((word) => word.isEmpty ? '' : word[0].toUpperCase() + word.substring(1)).join('')}Icon';
  }

  Future<void> _copyIconCode(String iconName) async {
    final className = _convertToIconClassName(iconName);
    await _copyToClipboard('$className()');
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: Colors.white,
          appBar: _buildAppBar(),
          body: GestureDetector(
            onTap: () {
              if (_showSupportDropdown) {
                setState(() {
                  _showSupportDropdown = false;
                });
              }
            },
            child: SingleChildScrollView(
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
          ),
        ),
        _buildSupportDropdown(),
      ],
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.grey,
      elevation: 0,
      centerTitle: false,
      title: const SelectableText(
        AnimatedIconsStrings.appBarTitle,
        style: TextStyle(
          fontSize: 18,
          fontFamily: AnimatedIconsStrings.fontFamily,
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: Row(
            children: [
              _buildTextLinkContainer(
                AnimatedIconsStrings.pubDevLabel,
                AnimatedIconsStrings.pubDevUrl,
              ),
              _buildTextLinkContainer(
                AnimatedIconsStrings.githubLabel,
                AnimatedIconsStrings.githubUrl,
              ),
              _buildSupportButton(),
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
        _buildDescriptionText(AnimatedIconsStrings.description1),
        const SizedBox(height: 12),
        _buildDescriptionText(AnimatedIconsStrings.description2),
        const SizedBox(height: 12),
        _buildCreditsRow(),
      ],
    );
  }

  Widget _buildDescriptionText(String text) {
    return SelectableText(
      text,
      style: const TextStyle(
        fontSize: 14,
        color: Colors.black54,
        fontFamily: AnimatedIconsStrings.fontFamily,
      ),
    );
  }

  Widget _buildCreditsRow() {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 4.0,
      runSpacing: 4.0,
      children: [
        _buildDescriptionText(AnimatedIconsStrings.madeWith),
        _buildTextLinkContainer(
          AnimatedIconsStrings.flutterLabel,
          AnimatedIconsStrings.flutterUrl,
        ),
        _buildDescriptionText(AnimatedIconsStrings.and),
        _buildTextLinkContainer(
          AnimatedIconsStrings.lucideLabel,
          AnimatedIconsStrings.lucideUrl,
        ),
        _buildDescriptionText(AnimatedIconsStrings.inspiredBy),
        _buildTextLinkContainer(
          AnimatedIconsStrings.pqoqubbwLabel,
          AnimatedIconsStrings.pqoqubbwUrl,
        ),
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
            onTap: () => _copyToClipboard(AnimatedIconsStrings.installCommand),
            child: SvgPicture.asset(
              AnimatedIconsStrings.copyIconPath,
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
              AnimatedIconsStrings.installCommand,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black54,
                fontFamily: AnimatedIconsStrings.fontFamily,
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
            AnimatedIconsStrings.searchIconPath,
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
                hintText:
                    '${AnimatedIconsStrings.searchHintPrefix} ${icons_data.icons.length} icons',
                hintStyle: TextStyle(
                  color: Colors.grey.shade500,
                  fontFamily: AnimatedIconsStrings.fontFamily,
                  fontSize: 14,
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.zero,
              ),
              style: const TextStyle(
                fontFamily: AnimatedIconsStrings.fontFamily,
                fontSize: 14,
              ),
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

    return LayoutBuilder(
      builder: (context, constraints) {
        final crossAxisCount = (constraints.maxWidth / _gridMaxCrossAxisExtent)
            .floor()
            .clamp(1, 7);

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: _gridSpacing,
            mainAxisSpacing: _gridSpacing,
            childAspectRatio: 1.0,
          ),
          itemCount: _filteredIcons.length,
          itemBuilder: (context, index) {
            final icon = _filteredIcons[index];
            return IconCard(
              name: icon.name,
              iconWidget: icon.widget,
              onViewCode: () => _openIconCode(icon.name),
              onCopy: () => _copyIconCode(icon.name),
            );
          },
        );
      },
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(48.0),
        child: Column(
          children: [
            Text(
              AnimatedIconsStrings.noIconsFound,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey.shade600,
                fontFamily: AnimatedIconsStrings.fontFamily,
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
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      focusColor: Colors.transparent,
      splashColor: Colors.transparent,
      overlayColor: WidgetStateProperty.all(Colors.transparent),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
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
            fontFamily: AnimatedIconsStrings.fontFamily,
          ),
        ),
      ),
    );
  }

  Widget _buildSupportButton() {
    return InkWell(
      onTap: () {
        setState(() {
          _showSupportDropdown = !_showSupportDropdown;
        });
      },
      borderRadius: BorderRadius.circular(6),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
        decoration: BoxDecoration(
          color: _showSupportDropdown
              ? Colors.grey.shade200
              : Colors.grey.shade50,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: Colors.grey),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              AnimatedIconsStrings.supportLabel,
              style: TextStyle(
                fontSize: 14,
                color: Colors.black,
                fontFamily: AnimatedIconsStrings.fontFamily,
              ),
            ),
            const SizedBox(width: 4),
            Icon(
              _showSupportDropdown
                  ? Icons.keyboard_arrow_up
                  : Icons.keyboard_arrow_down,
              size: 16,
              color: Colors.grey.shade600,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSupportDropdown() {
    if (!_showSupportDropdown) return const SizedBox.shrink();

    return Positioned(
      top: kToolbarHeight,
      right: 16,
      child: Material(
        elevation: 4,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          width: 120,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildSupportDropdownItem(
                AnimatedIconsStrings.telegramLabel,
                AnimatedIconsStrings.telegramUrl,
                isFirst: true,
              ),
              Divider(height: 1, color: Colors.grey.shade200),
              _buildSupportDropdownItem(
                AnimatedIconsStrings.yoomoneyLabel,
                AnimatedIconsStrings.yoomoneyUrl,
                isLast: true,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSupportDropdownItem(
    String text,
    String url, {
    bool isFirst = false,
    bool isLast = false,
  }) {
    return InkWell(
      onTap: () {
        _launchUrl(url);
        setState(() {
          _showSupportDropdown = false;
        });
      },
      borderRadius: BorderRadius.vertical(
        top: isFirst ? const Radius.circular(8) : Radius.zero,
        bottom: isLast ? const Radius.circular(8) : Radius.zero,
      ),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.black,
            fontFamily: AnimatedIconsStrings.fontFamily,
          ),
        ),
      ),
    );
  }
}
