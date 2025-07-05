import 'package:flutter/material.dart';
import 'package:not_static_icons_app/icons/a_arrow_down_icon.dart';
import 'package:not_static_icons_app/icons/airplay_icon.dart';

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
                size: 45, // icon size
                color: Colors.blue, // icon color
                animationDuration: Duration(
                  milliseconds: 800,
                ), // animation duration
                strokeWidth: 3.0, // icon stroke width
                hoverColor: Colors.red, // icon hover color
                enableTouchInteraction:
                    true, // enable touch interaction (for mobile devices)
                infiniteLoop: false, // infinite loop
                reverseOnExit: false, // reverse animation on exit
              ),
            ],
          ),
        ),
      ),
    );
  }
}
