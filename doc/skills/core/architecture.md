# Architecture

## Structure

```text
lib/
├── not_static_icons.dart              # public barrel
└── src/
    ├── core/
    │   ├── animated_svg_icon_base.dart
    │   ├── badge_base_icon.dart
    │   └── folder_base_icon.dart
    ├── icons/                         # Lucide implementations
    ├── custom_icons/                  # non-Lucide implementations
    ├── template/icon_template.dart
    ├── all_icons.dart                 # Lucide exports
    └── all_custom_icons.dart          # custom exports
example/                               # minimal API example
not_static_icons_app/                  # searchable showcase/web app
tool/check_lucide_icons.dart           # compares repo with Lucide SVG names
```

## Runtime Flow

```text
Icon widget
  → AnimatedSVGIconState
    → AnimationController (0..1)
      → icon.createPainter(...)
        → CustomPainter.paint(Canvas, Size)
```

`AnimatedSVGIconState` owns gestures, hover state, animation lifecycle, effective color, and external controller attachment. Individual icons own only defaults, animation description, and drawing.

Folder variants share their outline and painter through `FolderIconBase`; each public folder widget still lives in its own icon file.

When `interactive` is `false`, the icon returns bare `CustomPaint`; use this inside `IconButton` with `AnimatedIconController`. Otherwise hover/touch starts animation and `onTap` fires on touch release.

## Coordinate System

Lucide SVG geometry is normally 24×24. Painters use either:

```dart
final scale = size.width / 24;
```

and multiply coordinates, or scale the canvas once:

```dart
canvas.scale(size.width / 24, size.height / 24);
```

Use `PaintingStyle.stroke`, rounded caps, and rounded joins unless source SVG says otherwise. Preserve every SVG primitive in the idle frame.

## Registration

A Lucide icon requires three synchronized entries:

1. implementation: `lib/src/icons/<name>_icon.dart`
2. export: `lib/src/all_icons.dart`
3. demo entry: `not_static_icons_app/lib/data/icons_data.dart`

Custom icons use `lib/src/custom_icons/`, `lib/src/all_custom_icons.dart`, and the custom section of the same demo registry.

The demo sorts/searches its registry. Its “view code” URL assumes Lucide implementation paths; do not move icon files without updating `AnimatedIconsStrings.githubIconsBaseUrl` usage.

---

[Back to SKILLS.md](../../SKILLS.md)
