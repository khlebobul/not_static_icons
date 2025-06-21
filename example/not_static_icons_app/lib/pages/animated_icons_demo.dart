import 'package:flutter/material.dart';
import '../icons/a_arrow_down_icon.dart';
import '../icons/a_arrow_up_icon.dart';

/// Demo page showcasing animated SVG icons
class AnimatedIconsDemo extends StatelessWidget {
  const AnimatedIconsDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(40.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AArrowDownIcon(size: 120),
                  SizedBox(height: 16),
                  Text(
                    'a-arrow-down',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AArrowUpIcon(size: 120),
                  SizedBox(height: 16),
                  Text(
                    'a-arrow-up',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
