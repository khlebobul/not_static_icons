# Project Overview

`not_static_icons` is a dependency-light Flutter package of animated, Lucide-based icons. Icons are drawn with Flutter `Canvas`/`CustomPainter`; the package does not ship Rive, Lottie, SVG rendering, or generated icon code.

## Current Scope

- 754 Lucide icons in `lib/src/icons/`
- 6 non-Lucide icons in `lib/src/custom_icons/`
- Shared interaction and animation lifecycle through `AnimatedSVGIcon`
- Pointer hover, touch, `onTap`, and external `AnimatedIconController` support
- Simple example app and searchable web demo

## Boundaries

- Source artwork uses Lucide's 24×24 coordinate system.
- Each public icon is one Dart widget backed by a `CustomPainter`.
- `animationValue == 0` must render the complete source icon, not an empty first frame.
- Package runtime dependencies stay Flutter-only unless a feature cannot reasonably use Flutter APIs.
- Lucide icons and custom icons remain separate collections.

## Entry Points

| Purpose | File |
|---|---|
| Public package API | `lib/not_static_icons.dart` |
| Shared widget/controller | `lib/src/core/animated_svg_icon_base.dart` |
| Shared badge painter | `lib/src/core/badge_base_icon.dart` |
| Shared folder painter | `lib/src/core/folder_base_icon.dart` |
| Lucide exports | `lib/src/all_icons.dart` |
| Custom exports | `lib/src/all_custom_icons.dart` |
| Development template | `lib/src/template/icon_template.dart` |
| Demo registry | `not_static_icons_app/lib/data/icons_data.dart` |
| Lucide coverage tool | `tool/check_lucide_icons.dart` |

---

[Back to SKILLS.md](../../SKILLS.md)
