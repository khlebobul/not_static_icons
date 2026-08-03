# Icon Validation

## Required Checks

### Idle fidelity

- At `animationValue == 0`, every source SVG primitive is visible.
- Geometry matches canonical 24×24 source.
- Stroke caps, joins, fill/stroke mode, and closed paths match.
- No clipping at sizes 16, 24, 40, and 96.

### Animation

- Motion explains icon meaning and remains recognizable.
- First frame does not flash empty or partially drawn.
- Non-looping motion finishes cleanly; out-and-back motion returns exactly.
- `reverseOnExit`, `infiniteLoop`, and reset behavior do not jump.

### API and interaction

- Nullable color follows surrounding `IconTheme`.
- `strokeWidth`, `size`, `hoverColor`, and custom duration work.
- Touch/hover triggers animation when interactive.
- `onTap` fires once.
- `interactive: false` plus `AnimatedIconController` works inside `IconButton`.

### Registration

- implementation path/name, export, demo name, and widget class agree;
- Lucide and custom sections are not mixed;
- demo search finds the icon and “view code” points to the implementation.

## Commands

From repository root:

```bash
dart format <touched-dart-files>
flutter analyze
flutter test
git diff --check
cd not_static_icons_app && flutter analyze
```

Run the demo for visual checks:

```bash
cd not_static_icons_app
flutter run -d chrome
```

When synchronizing against a Lucide checkout:

```bash
make check-icons LUCIDE_REPO_PATH=/absolute/path/to/lucide
```

Review generated `ICON_CHECKLIST.md`; this command rewrites it.

## Test Boundary

Painter geometry is primarily visual. Add a focused widget/unit test when changing shared core lifecycle, gesture behavior, controller attachment, or reusable animation math. Do not create one screenshot test per icon unless visual regressions become frequent enough to justify maintenance.

---

[Back to SKILLS.md](../../SKILLS.md)
