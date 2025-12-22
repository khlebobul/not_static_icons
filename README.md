### `not_static_icons` | animated icons for Flutter

<div align="center">

[![LICENCE - MIT](https://img.shields.io/badge/LICENCE-MIT-414141?style=for-the-badge&logo=Licence&logoColor=414141)](https://github.com/khlebobul/not_static_icons/blob/main/LICENSE) [![pub package](https://img.shields.io/pub/v/not_static_icons.svg?style=for-the-badge&color=414141)](https://pub.dartlang.org/packages/not_static_icons)

Seamlessly animated Flutter icons — no Rive or Lottie required. Made with [Lucide icons](https://lucide.dev/) inspired by [pqoqubbw/icons](https://icons.pqoqubbw.dev/).

<a href="https://not-static-icons.vercel.app/" target="_blank" rel="noopener noreferrer">
  <img src="https://github.com/khlebobul/not_static_icons/raw/main/screenshots/web_demo.png" width="650px">
</a>

</div>

## Features

- **300+ Animated Icons**: Based on popular Lucide icon set
- **Interactive Animations**: Hover and touch effects
- **Customizable**: Size, color, animation duration, stroke width

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

[![Web demo](https://img.shields.io/badge/WEB_DEMO-414141?style=for-the-badge&logo=md&logoColor=F1F1F1)](https://not-static-icons.vercel.app/) [![MEDIUM ARTICLE](https://img.shields.io/badge/MEDIUM_ARTICLE-414141?style=for-the-badge&logo=md&logoColor=F1F1F1)](https://medium.com/@khlebobul/animating-svgs-in-flutter-without-rive-or-lottie-the-story-behind-my-animated-icon-package-c3808d2931cf)

## Animation Types

Each icon has its own unique animation:
- **Rotation**: Icons rotate around their center
- **Scale**: Icons scale up/down
- **Path Drawing**: Icons draw their paths progressively
- **Morphing**: Icons transform between states

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

[![CONTRIBUTING.md](https://img.shields.io/badge/CONTRIBUTING.md-414141?style=for-the-badge&logo=md&logoColor=F1F1F1)](https://github.com/khlebobul/not_static_icons/blob/main/CONTRIBUTING.md) [![CODE_OF_CONDUCT.md](https://img.shields.io/badge/CODE_OF_CONDUCT.md-414141?style=for-the-badge&logo=md&logoColor=F1F1F1)](https://github.com/khlebobul/not_static_icons/blob/main/CODE_OF_CONDUCT.md) [![ICON_CHECKLIST.md](https://img.shields.io/badge/ICON_CHECKLIST.md-414141?style=for-the-badge&logo=md&logoColor=F1F1F1)](https://github.com/khlebobul/not_static_icons/blob/main/ICON_CHECKLIST.md)

## Project support

[![Support - Stars](https://img.shields.io/badge/Support-Stars-414141?style=for-the-badge&logo=Telegram&logoColor=F1F1F1)](https://t.me/khlebobul_dev) [![Support - YooMoney](https://img.shields.io/badge/Support-YooMoney-414141?style=for-the-badge&logo=YooMoney&logoColor=F1F1F1)](https://yoomoney.ru/to/4100118234947004)

## Contacts

[![@khlebobul](https://img.shields.io/badge/@khlebobul-414141?style=for-the-badge&logo=X&logoColor=F1F1F1)](https://x.com/khlebobul) [![Email - khlebobul@gmail.com](https://img.shields.io/badge/Email-khlebobul%40gmail.com-414141?style=for-the-badge&logo=Email&logoColor=F1F1F1)](mailto:khlebobul@gmail.com) [![@khlebobul](https://img.shields.io/badge/%40khlebobul-414141?style=for-the-badge&logo=Telegram&logoColor=F1F1F1)](https://t.me/khlebobul) [![Personal - Website](https://img.shields.io/badge/Personal-Website-414141?style=for-the-badge&logo=Personal&logoColor=F1F1F1)](https://khlebobul.github.io/)

## License

[![LICENCE - MIT](https://img.shields.io/badge/LICENCE-MIT-414141?style=for-the-badge&logo=Licence&logoColor=F1F1F1)](https://github.com/khlebobul/not_static_icons/blob/main/LICENSE)

## Credits

Icons based on [Lucide Icons](https://lucide.dev/) inspired by [pqoqubbw/icons](https://icons.pqoqubbw.dev/)
