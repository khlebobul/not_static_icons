import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class IconCard extends StatelessWidget {
  final String name;
  final Widget iconWidget;

  const IconCard({super.key, required this.name, required this.iconWidget});

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
              fontFamily: 'JetBrainsMono',
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
                    'assets/icons/copy.svg',
                    width: 16,
                    height: 16,
                    colorFilter: ColorFilter.mode(
                      Colors.grey.shade700,
                      BlendMode.srcIn,
                    ),
                  ),
                  onTap: () {
                    // TODO: Implement copy functionality
                    debugPrint('Copying $name');
                  },
                ),
              ),

              // Code button
              Tooltip(
                message: 'View code',
                child: _buildActionButton(
                  icon: SvgPicture.asset(
                    'assets/icons/code.svg',
                    width: 16,
                    height: 16,
                    colorFilter: ColorFilter.mode(
                      Colors.grey.shade700,
                      BlendMode.srcIn,
                    ),
                  ),
                  onTap: () {
                    // TODO: Implement view code functionality
                    debugPrint('View code for $name');
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
