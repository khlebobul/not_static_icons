import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Circle Fading Plus Icon - Plus pulses with fading circle
class CircleFadingPlusIcon extends AnimatedSVGIcon {
  const CircleFadingPlusIcon({
    super.key,
    super.size = 40.0,
    super.color,
    super.hoverColor,
    super.animationDuration = const Duration(milliseconds: 600),
    super.strokeWidth = 2.0,
    super.reverseOnExit = false,
    super.enableTouchInteraction = true,
    super.infiniteLoop = false,
    super.onTap,
    super.interactive,
    super.controller,
  });

  @override
  String get animationDescription => "Plus pulses";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return CircleFadingPlusPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

/// Painter for Circle Fading Plus icon
class CircleFadingPlusPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  CircleFadingPlusPainter({
    required this.color,
    required this.animationValue,
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
    final center = Offset(12 * scale, 12 * scale);
    final rect = Rect.fromCircle(center: center, radius: 10 * scale);

    // Main arc: M12 2a10 10 0 0 1 7.38 16.75
    canvas.drawArc(rect, -math.pi / 2, math.pi * 0.85, false, paint);

    // Small arc segments around the circle
    // M2.5 8.875a10 10 0 0 0-.5 3
    final path1 = Path();
    path1.moveTo(2.5 * scale, 8.875 * scale);
    path1.arcToPoint(
      Offset(2 * scale, 11.875 * scale),
      radius: Radius.circular(10 * scale),
      clockwise: false,
    );
    canvas.drawPath(path1, paint);

    // M2.83 16a10 10 0 0 0 2.43 3.4
    final path2 = Path();
    path2.moveTo(2.83 * scale, 16 * scale);
    path2.arcToPoint(
      Offset(5.26 * scale, 19.4 * scale),
      radius: Radius.circular(10 * scale),
      clockwise: false,
    );
    canvas.drawPath(path2, paint);

    // M4.636 5.235a10 10 0 0 1 .891-.857
    final path3 = Path();
    path3.moveTo(4.636 * scale, 5.235 * scale);
    path3.arcToPoint(
      Offset(5.527 * scale, 4.378 * scale),
      radius: Radius.circular(10 * scale),
      clockwise: true,
    );
    canvas.drawPath(path3, paint);

    // M8.644 21.42a10 10 0 0 0 7.631-.38
    final path4 = Path();
    path4.moveTo(8.644 * scale, 21.42 * scale);
    path4.arcToPoint(
      Offset(16.275 * scale, 21.04 * scale),
      radius: Radius.circular(10 * scale),
      clockwise: false,
    );
    canvas.drawPath(path4, paint);

    // Animated plus sign - pulse scale
    final oscillation = 4 * animationValue * (1 - animationValue);
    final scaleAnim = 1.0 + oscillation * 0.15;

    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.scale(scaleAnim);
    canvas.translate(-center.dx, -center.dy);

    // Vertical line: M12 8v8
    canvas.drawLine(
      Offset(12 * scale, 8 * scale),
      Offset(12 * scale, 16 * scale),
      paint,
    );

    // Horizontal line: M16 12H8
    canvas.drawLine(
      Offset(16 * scale, 12 * scale),
      Offset(8 * scale, 12 * scale),
      paint,
    );

    canvas.restore();
  }

  @override
  bool shouldRepaint(CircleFadingPlusPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
