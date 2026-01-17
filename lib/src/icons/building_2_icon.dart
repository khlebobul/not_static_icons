import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Building 2 Icon - Building rises from ground
class Building2Icon extends AnimatedSVGIcon {
  const Building2Icon({
    super.key,
    super.size = 40.0,
    super.color,
    super.hoverColor,
    super.animationDuration = const Duration(milliseconds: 800),
    super.strokeWidth = 2.0,
    super.reverseOnExit = false,
    super.enableTouchInteraction = true,
    super.infiniteLoop = false,
    super.onTap,
    super.interactive,
    super.controller,
  });

  @override
  String get animationDescription => "Building rises from ground";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return Building2Painter(
      color: color,
      progress: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

class Building2Painter extends CustomPainter {
  final Color color;
  final double progress;
  final double strokeWidth;

  Building2Painter({
    required this.color,
    required this.progress,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..style = PaintingStyle.stroke;

    final scale = size.width / 24.0;

    // Logic:
    // If progress is 0 (idle), draw full icon.
    // If progress > 0, we are animating.
    // The user wants: "start of animation - it disappears and then is drawn".
    // So we treat progress as the drawing progress.
    // When animation starts (progress increases from 0), we want to start from empty.
    // But AnimatedSVGIcon interpolates 0 -> 1.
    // So at 0.0 it's full. At 0.01 it should be empty and start growing?
    // That would cause a flicker.
    // Maybe the user means the animation itself is "rising from nothing".
    // And in idle state it should be visible.
    // Yes.

    double drawProgress = progress;

    // If we are strictly at 0, we want full icon.
    // But if we are animating 0->1, we want to start at 0.
    // This is tricky with just one value.
    // Usually 0 means "start state".
    // If start state is "full icon", and end state is "full icon" (after rising),
    // then we need a cycle.
    // But here we have 0->1.
    // Let's assume when progress is exactly 0, we draw full.
    // When progress is > 0, we use progress.

    // However, this creates a jump from 100% visible to 0% visible at start of hover.
    // Maybe that's what is requested: "icon exists, start animation - it disappears and then draws".

    if (progress == 0) {
      drawProgress = 1.0;
    }

    // Animation phases
    // 0.0 - 0.6: Main building rises
    // 0.4 - 1.0: Side parts rise (overlap slightly)

    final mainBuildProgress = (drawProgress / 0.6).clamp(0.0, 1.0);
    final sideBuildProgress = ((drawProgress - 0.4) / 0.6).clamp(0.0, 1.0);

    // Main Building (Center)
    // M6 21V5a2 2 0 0 1 2-2h8a2 2 0 0 1 2 2v16

    final mainHeight = 18.0 * mainBuildProgress;
    final currentMainTop = 21.0 - mainHeight;

    if (mainBuildProgress > 0) {
      final mainPath = Path();

      canvas.save();
      // Clip from bottom to simulate rising
      // Expand clip rect by strokeWidth/2 to avoid cutting off strokes
      canvas.clipRect(Rect.fromLTWH(
          -strokeWidth,
          (21 - mainHeight) * scale - strokeWidth,
          24 * scale + 2 * strokeWidth,
          mainHeight * scale + 2 * strokeWidth));

      mainPath.moveTo(6 * scale, 21 * scale);
      mainPath.lineTo(6 * scale, 5 * scale);
      mainPath.arcToPoint(
        Offset(8 * scale, 3 * scale),
        radius: Radius.circular(2 * scale),
        clockwise: true,
      );
      mainPath.lineTo(16 * scale, 3 * scale);
      mainPath.arcToPoint(
        Offset(18 * scale, 5 * scale),
        radius: Radius.circular(2 * scale),
        clockwise: true,
      );
      mainPath.lineTo(18 * scale, 21 * scale);
      canvas.drawPath(mainPath, paint);

      // Windows on main building
      // M10 12h4
      // M10 8h4
      // Draw them if they are within the visible area
      if (currentMainTop <= 12) {
        canvas.drawLine(Offset(10 * scale, 12 * scale),
            Offset(14 * scale, 12 * scale), paint);
      }
      if (currentMainTop <= 8) {
        canvas.drawLine(Offset(10 * scale, 8 * scale),
            Offset(14 * scale, 8 * scale), paint);
      }

      // Door
      // M14 21v-3a2 2 0 0 0-4 0v3
      if (currentMainTop <= 18) {
        final doorPath = Path();
        doorPath.moveTo(14 * scale, 21 * scale);
        doorPath.lineTo(14 * scale, 18 * scale);
        doorPath.arcToPoint(
          Offset(10 * scale, 18 * scale),
          radius: Radius.circular(2 * scale),
          clockwise: false,
        );
        doorPath.lineTo(10 * scale, 21 * scale);
        canvas.drawPath(doorPath, paint);
      }

      canvas.restore();
    }

    // Side Parts
    // M6 10H4a2 2 0 0 0-2 2v7a2 2 0 0 0 2 2h16a2 2 0 0 0 2-2V9a2 2 0 0 0-2-2h-2

    if (sideBuildProgress > 0) {
      final sideHeight =
          14.0 * sideBuildProgress; // Max height roughly 21-7 = 14

      canvas.save();
      canvas.clipRect(Rect.fromLTWH(
          -strokeWidth,
          (21 - sideHeight) * scale - strokeWidth,
          24 * scale + 2 * strokeWidth,
          sideHeight * scale + 2 * strokeWidth));

      final sidePath = Path();
      sidePath.moveTo(6 * scale, 10 * scale);
      sidePath.lineTo(4 * scale, 10 * scale);
      sidePath.arcToPoint(
        Offset(2 * scale, 12 * scale),
        radius: Radius.circular(2 * scale),
        clockwise: false,
      );
      sidePath.lineTo(2 * scale, 19 * scale);
      sidePath.arcToPoint(
        Offset(4 * scale, 21 * scale),
        radius: Radius.circular(2 * scale),
        clockwise: false,
      );
      sidePath.lineTo(20 * scale, 21 * scale);
      sidePath.arcToPoint(
        Offset(22 * scale, 19 * scale),
        radius: Radius.circular(2 * scale),
        clockwise: false,
      );
      sidePath.lineTo(22 * scale, 9 * scale);
      sidePath.arcToPoint(
        Offset(20 * scale, 7 * scale),
        radius: Radius.circular(2 * scale),
        clockwise: false,
      );
      sidePath.lineTo(18 * scale, 7 * scale);

      canvas.drawPath(sidePath, paint);
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(Building2Painter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.progress != progress ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
