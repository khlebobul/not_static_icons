import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated House Icon - House rises from ground
class HouseIcon extends AnimatedSVGIcon {
  const HouseIcon({
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
  String get animationDescription => "House rises from ground";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return HousePainter(
      color: color,
      progress: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

class HousePainter extends CustomPainter {
  final Color color;
  final double progress;
  final double strokeWidth;

  HousePainter({
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

    double drawProgress = progress;

    if (progress == 0) {
      drawProgress = 1.0;
    }

    // Animation phases
    // 0.0 - 0.6: Main house body rises
    // 0.4 - 1.0: Door appears

    final houseProgress = (drawProgress / 0.6).clamp(0.0, 1.0);
    final doorProgress = ((drawProgress - 0.4) / 0.6).clamp(0.0, 1.0);

    // House outline with roof
    // M3 10a2 2 0 0 1 .709-1.528l7-6a2 2 0 0 1 2.582 0l7 6A2 2 0 0 1 21 10v9a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2z

    if (houseProgress > 0) {
      final houseHeight = 19.0 * houseProgress; // From y=2 to y=21
      final currentTop = 21.0 - houseHeight;

      canvas.save();
      canvas.clipRect(Rect.fromLTWH(
          -strokeWidth,
          currentTop * scale - strokeWidth,
          24 * scale + 2 * strokeWidth,
          houseHeight * scale + 2 * strokeWidth));

      final housePath = Path();

      // Start at left side of house body
      housePath.moveTo(3 * scale, 10 * scale);

      // Arc for left side of roof connection
      housePath.arcToPoint(
        Offset(3.709 * scale, 8.472 * scale),
        radius: Radius.circular(2 * scale),
        clockwise: true,
      );

      // Roof left slope - line to top
      housePath.lineTo(10.709 * scale, 2.472 * scale);

      // Arc at roof peak
      housePath.arcToPoint(
        Offset(13.291 * scale, 2.472 * scale),
        radius: Radius.circular(2 * scale),
        clockwise: true,
      );

      // Roof right slope
      housePath.lineTo(20.291 * scale, 8.472 * scale);

      // Arc for right side of roof connection
      housePath.arcToPoint(
        Offset(21 * scale, 10 * scale),
        radius: Radius.circular(2 * scale),
        clockwise: true,
      );

      // Right wall down
      housePath.lineTo(21 * scale, 19 * scale);

      // Bottom right corner arc
      housePath.arcToPoint(
        Offset(19 * scale, 21 * scale),
        radius: Radius.circular(2 * scale),
        clockwise: true,
      );

      // Bottom
      housePath.lineTo(5 * scale, 21 * scale);

      // Bottom left corner arc
      housePath.arcToPoint(
        Offset(3 * scale, 19 * scale),
        radius: Radius.circular(2 * scale),
        clockwise: true,
      );

      // Close - left wall up
      housePath.close();

      canvas.drawPath(housePath, paint);
      canvas.restore();
    }

    // Door
    // M15 21v-8a1 1 0 0 0-1-1h-4a1 1 0 0 0-1 1v8
    if (doorProgress > 0) {
      final doorHeight = 8.0 * doorProgress;

      canvas.save();
      canvas.clipRect(Rect.fromLTWH(
          -strokeWidth,
          (21 - doorHeight) * scale - strokeWidth,
          24 * scale + 2 * strokeWidth,
          doorHeight * scale + 2 * strokeWidth));

      final doorPath = Path();
      doorPath.moveTo(15 * scale, 21 * scale);
      doorPath.lineTo(15 * scale, 13 * scale);
      doorPath.arcToPoint(
        Offset(14 * scale, 12 * scale),
        radius: Radius.circular(1 * scale),
        clockwise: false,
      );
      doorPath.lineTo(10 * scale, 12 * scale);
      doorPath.arcToPoint(
        Offset(9 * scale, 13 * scale),
        radius: Radius.circular(1 * scale),
        clockwise: false,
      );
      doorPath.lineTo(9 * scale, 21 * scale);

      canvas.drawPath(doorPath, paint);
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(HousePainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.progress != progress ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
