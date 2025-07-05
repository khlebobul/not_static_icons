# not_static_icons

// TODO: badges

Beautifully crafted animated icons for Flutter. Made with [Lucide icons](https://lucide.dev/) ispired by [pqoqubbw/icons](https://icons.pqoqubbw.dev/).

// TODO: image

// TODO: web demo badge

## Features

- **100+ Animated Icons**: Based on popular Lucide icon set
- **Interactive Animations**: Hover and touch effects
- **Customizable**: Size, color, animation duration, stroke width
- **Performance**: Efficient CustomPainter implementation
- **Easy to Use**: Simple widget API

## Usage

### Basic Usage

```dart
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
            ],
          ),
        ),
      ),
    );
  }
}
```

### Advanced Configuration

```dart
ActivityIcon(
  size: 48.0, // Icon size
  color: Colors.black87, // Default color
  hoverColor: Colors.blue, // Hover color
  animationDuration: Duration(milliseconds: 600), // Animation duration
  strokeWidth: 2.0, // Stroke width
  reverseOnExit: true, // Reverse animation on exit
  enableTouchInteraction: true, // Enable touch interaction
  infiniteLoop: false, // Enable infinite loop
)
```

## Available Icons

// TODO: demo page link

## Animation Types

Each icon has its own unique animation:
- **Rotation**: Icons rotate around their center
- **Scale**: Icons scale up/down
- **Path Drawing**: Icons draw their paths progressively
- **Morphing**: Icons transform between states

// TODO: add medium article

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

// TODO: add Code of Conduct and Contributing bagdes

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Credits

Icons based on [Lucide Icons](https://lucide.dev/) inspired by [pqoqubbw/icons](https://icons.pqoqubbw.dev/)
