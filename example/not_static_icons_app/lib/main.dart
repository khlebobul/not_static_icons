import 'package:flutter/material.dart';
import 'pages/animated_icons_demo.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title:
          'not_static_icons | beautifully crafted animated icons for Flutter',
      debugShowCheckedModeBanner: false,
      home: AnimatedIconsDemo(),
    );
  }
}
