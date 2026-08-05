# Development Conventions

## Naming

For Lucide name `arrow-down-0-1`:

| Item | Value |
|---|---|
| Dart file | `arrow_down_0_1_icon.dart` |
| Widget | `ArrowDown01Icon` |
| Painter | `ArrowDown01Painter` or private `_ArrowDown01Painter` |
| Export | `export "icons/arrow_down_0_1_icon.dart";` |
| Demo name | `arrow-down-0-1` |

Follow nearby icons for acronym/number capitalization. Public widget names are API: do not rename existing classes casually.

## Icon Rules

- Extend `AnimatedSVGIcon`; reuse `BadgeBaseIcon` only for badge variants sharing its exact outline animation.
- Keep one icon implementation per file.
- Accept the base constructor surface used by nearby icons: key, size, color, hover color, duration, stroke width, interaction flags, `onTap`, `interactive`, and controller.
- Default color should remain nullable so `IconTheme` works. Do not add `Colors.black` to new icons.
- Draw from source SVG geometry. Do not approximate recognizable paths when exact coordinates are available.
- Keep idle frame complete. Animation may transform parts, but must return cleanly to source geometry.
- Scale geometry; avoid pixel constants tied to size 40.
- Implement selective `shouldRepaint`; do not return `true` unconditionally.
- Add `dart:math` only when animation math needs it. No new dependency for drawing.
- Prefer local painter helpers. Add shared core code only after multiple icons need identical behavior.

## Repository Rules

- `lib/src/all_icons.dart` is alphabetical by file path.
- Keep `not_static_icons_app/lib/data/icons_data.dart` grouped: Lucide first, custom last.
- Do not edit `ICON_CHECKLIST.md` manually for Lucide synchronization; regenerate it with `make check-icons` when a Lucide checkout is available.
- Do not bump versions, refresh locks, or run `make all` while merely adding an icon; `make all` performs release mutations.
- Format touched Dart files and run package analysis before handoff.

## Commands

```bash
dart format <touched-dart-files>
flutter analyze
flutter test
cd not_static_icons_app && flutter analyze
cd not_static_icons_app && flutter run -d chrome
make check-icons LUCIDE_REPO_PATH=/absolute/path/to/lucide
```

---

[Back to SKILLS.md](../../SKILLS.md)

