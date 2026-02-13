import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Circle Dot Dashed Icon - Dashes rotate around dot
class CircleDotDashedIcon extends AnimatedSVGIcon {
  const CircleDotDashedIcon({
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
  String get animationDescription => "Dashed circle rotates around dot";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return CircleDotDashedPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

/// Painter for Circle Dot Dashed icon
class CircleDotDashedPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  CircleDotDashedPainter({
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

    // Center dot (stroke): cx="12" cy="12" r="1"
    canvas.drawCircle(center, 1 * scale, paint);

    // Rotation animation for dashed circle
    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(animationValue * math.pi / 4);
    canvas.translate(-center.dx, -center.dy);

    // Draw 8 arc segments matching the SVG paths
    // These are small arcs around the ~10 radius circle

    // Path 1: M10.1 2.18a9.93 9.93 0 0 1 3.8 0
    final path1 = Path();
    path1.moveTo(10.1 * scale, 2.18 * scale);
    path1.arcToPoint(
      Offset(13.9 * scale, 2.18 * scale),
      radius: Radius.circular(9.93 * scale),
      clockwise: true,
    );
    canvas.drawPath(path1, paint);

    // Path 2: M17.6 3.71a9.95 9.95 0 0 1 2.69 2.7
    final path2 = Path();
    path2.moveTo(17.6 * scale, 3.71 * scale);
    path2.arcToPoint(
      Offset(20.29 * scale, 6.41 * scale),
      radius: Radius.circular(9.95 * scale),
      clockwise: true,
    );
    canvas.drawPath(path2, paint);

    // Path 3: M21.82 10.1a9.93 9.93 0 0 1 0 3.8
    final path3 = Path();
    path3.moveTo(21.82 * scale, 10.1 * scale);
    path3.arcToPoint(
      Offset(21.82 * scale, 13.9 * scale),
      radius: Radius.circular(9.93 * scale),
      clockwise: true,
    );
    canvas.drawPath(path3, paint);

    // Path 4: M20.29 17.6a9.95 9.95 0 0 1-2.7 2.69
    final path4 = Path();
    path4.moveTo(20.29 * scale, 17.6 * scale);
    path4.arcToPoint(
      Offset(17.59 * scale, 20.29 * scale),
      radius: Radius.circular(9.95 * scale),
      clockwise: true,
    );
    canvas.drawPath(path4, paint);

    // Path 5: M13.9 21.82a9.94 9.94 0 0 1-3.8 0
    final path5 = Path();
    path5.moveTo(13.9 * scale, 21.82 * scale);
    path5.arcToPoint(
      Offset(10.1 * scale, 21.82 * scale),
      radius: Radius.circular(9.94 * scale),
      clockwise: true,
    );
    canvas.drawPath(path5, paint);

    // Path 6: M6.4 20.29a9.95 9.95 0 0 1-2.69-2.7
    final path6 = Path();
    path6.moveTo(6.4 * scale, 20.29 * scale);
    path6.arcToPoint(
      Offset(3.71 * scale, 17.59 * scale),
      radius: Radius.circular(9.95 * scale),
      clockwise: true,
    );
    canvas.drawPath(path6, paint);

    // Path 7: M2.18 13.9a9.93 9.93 0 0 1 0-3.8
    final path7 = Path();
    path7.moveTo(2.18 * scale, 13.9 * scale);
    path7.arcToPoint(
      Offset(2.18 * scale, 10.1 * scale),
      radius: Radius.circular(9.93 * scale),
      clockwise: true,
    );
    canvas.drawPath(path7, paint);

    // Path 8: M3.71 6.4a9.95 9.95 0 0 1 2.7-2.69
    final path8 = Path();
    path8.moveTo(3.71 * scale, 6.4 * scale);
    path8.arcToPoint(
      Offset(6.41 * scale, 3.71 * scale),
      radius: Radius.circular(9.95 * scale),
      clockwise: true,
    );
    canvas.drawPath(path8, paint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(CircleDotDashedPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
