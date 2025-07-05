# not_static_icons

<div align="center">

[![LICENCE - MIT](https://img.shields.io/badge/LICENCE-MIT-F4F0D9?style=for-the-badge&logo=Licence&logoColor=F4F0D9)](https://github.com/khlebobul/use_scramble/blob/main/LICENSE) [![pub package](https://img.shields.io/pub/v/use_scramble.svg?style=for-the-badge&color=F4F0D9)](https://pub.dartlang.org/packages/use_scramble)

</div>

Beautifully crafted animated icons for Flutter. Made with [Lucide icons](https://lucide.dev/) ispired by [pqoqubbw/icons](https://icons.pqoqubbw.dev/).

<div align="center">

<a href="https://not-static-icons.vercel.app/">
  <img src="https://github.com/khlebobul/not_static_icons/raw/main/screenshots/web_demo.png" width="550px">
</a>

</div>

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

[![CONTRIBUTING.md](https://img.shields.io/badge/CONTRIBUTING.md-414141?style=for-the-badge&logo=md&logoColor=F1F1F1)](https://github.com/khlebobul/board_buddy/blob/main/CONTRIBUTING.md)

## Animation Types

Each icon has its own unique animation:
- **Rotation**: Icons rotate around their center
- **Scale**: Icons scale up/down
- **Path Drawing**: Icons draw their paths progressively
- **Morphing**: Icons transform between states

// TODO: add medium article

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

[![CONTRIBUTING.md](https://img.shields.io/badge/CONTRIBUTING.md-414141?style=for-the-badge&logo=md&logoColor=F1F1F1)](https://github.com/khlebobul/board_buddy/blob/main/CONTRIBUTING.md) [![CODE_OF_CONDUCT.md](https://img.shields.io/badge/CODE_OF_CONDUCT.md-414141?style=for-the-badge&logo=md&logoColor=F1F1F1)](https://github.com/khlebobul/board_buddy/blob/main/CODE_OF_CONDUCT.md)

## Project support

[![Support - Stars](https://img.shields.io/badge/Support-Stars-414141?style=for-the-badge&logo=Telegram&logoColor=F1F1F1)](https://t.me/khlebobul_dev) [![Support - YooMoney](https://img.shields.io/badge/Support-YooMoney-414141?style=for-the-badge&logo=YooMoney&logoColor=F1F1F1)](https://yoomoney.ru/to/4100118234947004)

## Contacts

[![@khlebobul](https://img.shields.io/badge/@khlebobul-414141?style=for-the-badge&logo=X&logoColor=F1F1F1)](https://x.com/khlebobul) [![Email - khlebobul@gmail.com](https://img.shields.io/badge/Email-khlebobul%40gmail.com-414141?style=for-the-badge&logo=Email&logoColor=F1F1F1)](mailto:khlebobul@gmail.com) [![@khlebobul](https://img.shields.io/badge/%40khlebobul-414141?style=for-the-badge&logo=Telegram&logoColor=F1F1F1)](https://t.me/khlebobul) [![Personal - Website](https://img.shields.io/badge/Personal-Website-414141?style=for-the-badge&logo=Personal&logoColor=F1F1F1)](https://khlebobul.github.io/)

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Credits

Icons based on [Lucide Icons](https://lucide.dev/) inspired by [pqoqubbw/icons](https://icons.pqoqubbw.dev/)
