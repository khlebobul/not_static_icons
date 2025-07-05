import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:not_static_icons_app/data/app_consts.dart';

class IconCard extends StatelessWidget {
  final String name;
  final Widget iconWidget;
  final VoidCallback? onViewCode;
  final VoidCallback? onCopy;

  const IconCard({
    super.key,
    required this.name,
    required this.iconWidget,
    this.onViewCode,
    this.onCopy,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(child: Center(child: iconWidget)),

          // Icon name
          Text(
            name,
            style: TextStyle(
              fontSize: 12,
              fontFamily: AnimatedIconsStrings.fontFamily,
              color: Colors.grey.shade600,
            ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 8),

          // Bottom actions row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Copy button
              Tooltip(
                message: 'Copy',
                child: _buildActionButton(
                  icon: SvgPicture.asset(
                    AnimatedIconsStrings.copyIconPath,
                    width: 16,
                    height: 16,
                    colorFilter: ColorFilter.mode(
                      Colors.grey.shade700,
                      BlendMode.srcIn,
                    ),
                  ),
                  onTap: () {
                    if (onCopy != null) {
                      onCopy!();
                    }
                  },
                ),
              ),

              // Code button
              Tooltip(
                message: 'View code',
                child: _buildActionButton(
                  icon: SvgPicture.asset(
                    AnimatedIconsStrings.codeIconPath,
                    width: 16,
                    height: 16,
                    colorFilter: ColorFilter.mode(
                      Colors.grey.shade700,
                      BlendMode.srcIn,
                    ),
                  ),
                  onTap: () {
                    if (onViewCode != null) {
                      onViewCode!();
                    } else {
                      debugPrint('View code for $name');
                    }
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required Widget icon,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(6),
      child: Container(padding: const EdgeInsets.all(6), child: icon),
    );
  }
}
