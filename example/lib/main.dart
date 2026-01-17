import 'package:flutter/material.dart';
import 'package:not_static_icons/not_static_icons.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Simple icon usage
              AirplayIcon(),
              SizedBox(height: 20),

              // Customized icon
              AArrowDownIcon(
                size: 45,
                color: Colors.blue,
                animationDuration: Duration(milliseconds: 800),
                strokeWidth: 3.0,
                hoverColor: Colors.red,
                enableTouchInteraction: true,
                infiniteLoop: false,
                reverseOnExit: false,
              ),
              SizedBox(height: 20),

              // Icon with onTap callback
              CheckIcon(
                size: 40,
                color: Colors.green,
                onTap: () {
                  debugPrint('Icon tapped!');
                },
              ),
              SizedBox(height: 20),

              // Icon inside IconButton with controller
              IconButtonExample(),
            ],
          ),
        ),
      ),
    );
  }
}

/// Example of using AnimatedIconController with IconButton
class IconButtonExample extends StatefulWidget {
  const IconButtonExample({super.key});

  @override
  State<IconButtonExample> createState() => _IconButtonExampleState();
}

class _IconButtonExampleState extends State<IconButtonExample> {
  final _iconController = AnimatedIconController();

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        _iconController.animate();
        debugPrint('IconButton pressed!');
      },
      icon: HeartIcon(
        size: 32,
        color: Colors.red,
        interactive: false, // disable internal gesture handlers
        controller: _iconController,
      ),
    );
  }
}
