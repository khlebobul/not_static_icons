# Creating an Animated Icon

## 1. Find Source and Nearest Pattern

For a Lucide icon, use its canonical SVG from a local Lucide checkout. Confirm its `viewBox`, paths, lines, circles, rectangles, polylines, and groups.

Search this repository before writing:

```bash
rg "class .*Icon" lib/src/icons
rg "drawCircle|arcToPoint|computeMetrics|canvas.rotate" lib/src/icons
```

Copy the closest geometric/animation pattern, not an arbitrary large icon. Use `lib/src/template/icon_template.dart` only when no close implementation exists.

## 2. Choose One Small Animation

Animation should communicate the icon's meaning while preserving recognition. Common patterns already present:

| Intent | Technique |
|---|---|
| direction/movement | `canvas.translate` out and back |
| pulse/emphasis | centered `canvas.scale` |
| refresh/loading | centered `canvas.rotate` |
| drawing/reveal | `PathMetric.extractPath` |
| repeated flow | moving dash offset |
| state change | interpolate coordinates/opacity |

Prefer one transform over several staged effects. For an out-and-back motion:

```dart
final t = 4 * animationValue * (1 - animationValue);
```

`t` is 0 at both ends and 1 halfway through, so the icon returns to its idle geometry.

## 3. Implement

Create `lib/src/icons/<lucide_name>_icon.dart` for Lucide, or `lib/src/custom_icons/<name>_icon.dart` for custom artwork.

Minimum shape:

```dart
import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

class ExampleIcon extends AnimatedSVGIcon {
  const ExampleIcon({
    super.key,
    super.size = 40,
    super.color,
    super.hoverColor,
    super.animationDuration = const Duration(milliseconds: 600),
    super.strokeWidth = 2,
    super.reverseOnExit = false,
    super.enableTouchInteraction = true,
    super.infiniteLoop = false,
    super.onTap,
    super.interactive,
    super.controller,
  });

  @override
  String get animationDescription => 'Short behavior description';

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) => _ExamplePainter(
        color: color,
        animationValue: animationValue,
        strokeWidth: strokeWidth,
      );
}
```

Painter requirements:

- configure stroke paint with round cap/join;
- render all source primitives;
- scale from the 24×24 source system;
- apply animation with balanced `canvas.save()` / `canvas.restore()`;
- compare color, animation value, and stroke width in `shouldRepaint`.

## 4. Export and Register

Lucide:

```dart
// lib/src/all_icons.dart
export "icons/example_icon.dart";

// not_static_icons_app/lib/data/icons_data.dart
IconData(name: 'example', widget: ExampleIcon(size: 40)),
```

Custom:

```dart
// lib/src/all_custom_icons.dart
export 'custom_icons/example_icon.dart';
```

Also add its demo registry entry in the custom section. Reference SVGs under `not_static_icons_app/assets/lucide_icons/` and `assets/custom_icons/` are source aids, not runtime package assets; add one only when maintaining that mirror.

## 5. Validate

Follow [validation.md](validation.md). An icon is unfinished until idle fidelity, animation, scaling, theme color, touch, hover, controller use, export, and demo registration are checked.

---

[Back to SKILLS.md](../../SKILLS.md)

