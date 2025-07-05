# Contributing to not_static_icons

Thank you for considering contributing to **not_static_icons**! We welcome all kinds of contributions, whether it's fixing a bug, adding a feature, improving documentation, or reporting an issue.

## Project Structure

Understanding the project structure is crucial for contributing:

```
not_static_icons/
├── lib/                           # Main package code
│   ├── not_static_icons.dart      # Main package export file
│   └── src/
│       ├── core/                  # Core functionality
│       │   └── animated_svg_icon_base.dart
│       ├── icons/                 # Individual icon implementations
│       │   ├── anchor_icon.dart
│       │   ├── arrow_down_icon.dart
│       │   └── ...
│       └── all_icons.dart         # Exports all icons
└── example/
    └── not_static_icons_app/      # Demo application
        ├── lib/
        │   ├── main.dart          # Demo app entry point
        │   ├── pages/             # Demo pages
        │   ├── widgets/           # Demo-specific widgets
        │   ├── data/              # Demo data and icon registry
        │   └── templates/         # Icon development templates
        └── assets/                # Demo assets (SVG files, etc.)
```

## Quick Start

### Setup

1. **Fork & Clone**:
   ```bash
   git clone https://github.com/YOUR_USERNAME/not_static_icons.git
   cd not_static_icons
   ```

2. **Install Dependencies**:
   ```bash
   # Install package dependencies
   flutter pub get
   
   # Install demo app dependencies
   cd example/not_static_icons_app
   flutter pub get
   cd ../..
   ```

3. **Run Demo App**:
   ```bash
   cd example/not_static_icons_app
   flutter run
   ```

## Adding a New Icon

> [!IMPORTANT]
> Before implementing a new icon, please [open an issue](https://github.com/khlebobul/not_static_icons/issues/new) to discuss it. This ensures the icon fits the library's scope and avoids duplicate work.

### Step 1: Create the Icon Implementation

1. **Use the Template**: Copy `example/not_static_icons_app/lib/templates/icon_template.dart`
2. **Create Icon File**: Add your icon to `lib/src/icons/your_icon_name_icon.dart`
3. **Follow Naming Convention**: 
   - File: `snake_case_icon.dart`
   - Class: `SnakeCaseIcon` 
   - Painter: `SnakeCasePainter`

**Example structure:**
```dart
// lib/src/icons/heart_icon.dart
import 'dart:math';
import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

class HeartIcon extends AnimatedSVGIcon {
  const HeartIcon({
    super.key,
    super.size,
    super.color,
    super.animationDuration = const Duration(milliseconds: 1200),
    super.strokeWidth = 2.0,
    super.reverseOnExit = false,
    super.enableTouchInteraction = true,
    super.infiniteLoop = false,
  });

  @override
  String get animationDescription => 'Heart pulses with a gentle rhythm';

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return HeartPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

class HeartPainter extends CustomPainter {
  // Implementation here...
}
```

### Step 2: Export the Icon

Add your icon to `lib/src/all_icons.dart`:
```dart
export 'icons/heart_icon.dart';
```

### Step 3: Add to Demo App

1. **Register Icon**: Add to `example/not_static_icons_app/lib/data/icons_data.dart`:
   ```dart
   IconData(name: 'heart', widget: HeartIcon(size: 40)),
   ```

2. **Add SVG Reference**: Place the original SVG in `example/not_static_icons_app/assets/lucide_icons/heart.svg` (for reference)

### Step 4: Test Your Icon

```bash
cd example/not_static_icons_app
flutter run
```

Navigate to your icon in the demo app and verify:
- ✅ Animation works smoothly
- ✅ Hover effects function properly
- ✅ Touch interactions work on mobile
- ✅ Icon scales correctly
- ✅ Colors adapt to theme

## Types of Contributions

### Bug Fixes
- **Location**: Usually in `lib/src/core/` or specific icon files
- **Testing**: Ensure fix works in demo app
- **Documentation**: Update comments if behavior changes

### New Features
- **Core Features**: Add to `lib/src/core/`
- **Icon Features**: Enhance base `AnimatedSVGIcon` class
- **Demo Features**: Add to `example/not_static_icons_app/

### Demo App Improvements
- **Location**: `example/not_static_icons_app/`
- **Ideas**: 
  - New demo pages
  - Better icon organization
  - Performance improvements
  - UI/UX enhancements

## Development Guidelines

### Code Style

- Follow [Effective Dart](https://dart.dev/guides/language/effective-dart) guidelines
- Use `flutter format .` before committing
- Add meaningful comments for complex animations
- Keep file and class names consistent with existing patterns

## Getting Help

[![@khlebobul](https://img.shields.io/badge/@khlebobul-414141?style=for-the-badge&logo=X&logoColor=F1F1F1)](https://x.com/khlebobul) [![Email - khlebobul@gmail.com](https://img.shields.io/badge/Email-khlebobul%40gmail.com-414141?style=for-the-badge&logo=Email&logoColor=F1F1F1)](mailto:khlebobul@gmail.com) [![@khlebobul](https://img.shields.io/badge/%40khlebobul-414141?style=for-the-badge&logo=Telegram&logoColor=F1F1F1)](https://t.me/khlebobul) [![Personal - Website](https://img.shields.io/badge/Personal-Website-414141?style=for-the-badge&logo=Personal&logoColor=F1F1F1)](https://khlebobul.github.io/)

## Code of Conduct

This project follows the [Contributor Covenant Code of Conduct](CODE_OF_CONDUCT.md). By participating, you are expected to uphold this code.

---

We appreciate your contribution and look forward to building amazing animated icons together!