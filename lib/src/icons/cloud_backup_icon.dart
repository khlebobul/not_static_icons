import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Cloud Backup Icon - Backup arrow rotates
class CloudBackupIcon extends AnimatedSVGIcon {
  const CloudBackupIcon({
    super.key,
    super.size = 40.0,
    super.color,
    super.hoverColor,
    super.animationDuration = const Duration(milliseconds: 1500),
    super.strokeWidth = 2.0,
    super.reverseOnExit = false,
    super.enableTouchInteraction = true,
    super.infiniteLoop = false,
    super.onTap,
    super.interactive,
    super.controller,
  });

  @override
  String get animationDescription => "Backup arrow rotates";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return CloudBackupPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

class CloudBackupPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  CloudBackupPainter({
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

    // Cloud top part: M21 15.251A4.5 4.5 0 0 0 17.5 8h-1.79A7 7 0 1 0 3 13.607
    final cloudPath = Path();
    cloudPath.moveTo(21 * scale, 15.251 * scale);
    // A4.5 4.5 0 0 0 17.5 8 - arc from (21, 15.251) to (17.5, 8)
    cloudPath.arcToPoint(
      Offset(17.5 * scale, 8 * scale),
      radius: Radius.circular(4.5 * scale),
      clockwise: false,
    );
    // h-1.79
    cloudPath.lineTo(15.71 * scale, 8 * scale);
    // A7 7 0 1 0 3 13.607 - arc from (15.71, 8) to (3, 13.607)
    cloudPath.arcToPoint(
      Offset(3 * scale, 13.607 * scale),
      radius: Radius.circular(7 * scale),
      clockwise: false,
      largeArc: true,
    );
    canvas.drawPath(cloudPath, paint);

    // Backup arrow with rotation animation around arrow center
    final oscillation = 4 * animationValue * (1 - animationValue);
    final rotation = oscillation * math.pi * 0.5;

    canvas.save();
    canvas.translate(12 * scale, 15.5 * scale);
    canvas.rotate(rotation);
    canvas.translate(-12 * scale, -15.5 * scale);

    // Arrow line: M7 11v4h4
    final arrowPath = Path();
    arrowPath.moveTo(7 * scale, 11 * scale);
    arrowPath.lineTo(7 * scale, 15 * scale);
    arrowPath.lineTo(11 * scale, 15 * scale);
    canvas.drawPath(arrowPath, paint);

    // Circular arrow: M8 19a5 5 0 0 0 9-3 4.5 4.5 0 0 0-4.5-4.5 4.82 4.82 0 0 0-3.41 1.41L7 15
    final circularArrow = Path();
    circularArrow.moveTo(8 * scale, 19 * scale);
    // a5 5 0 0 0 9-3 - arc to (17, 16)
    circularArrow.arcToPoint(
      Offset(17 * scale, 16 * scale),
      radius: Radius.circular(5 * scale),
      clockwise: false,
    );
    // 4.5 4.5 0 0 0-4.5-4.5 - arc to (12.5, 11.5)
    circularArrow.arcToPoint(
      Offset(12.5 * scale, 11.5 * scale),
      radius: Radius.circular(4.5 * scale),
      clockwise: false,
    );
    // 4.82 4.82 0 0 0-3.41 1.41 - arc to (9.09, 12.91)
    circularArrow.arcToPoint(
      Offset(9.09 * scale, 12.91 * scale),
      radius: Radius.circular(4.82 * scale),
      clockwise: false,
    );
    // L7 15
    circularArrow.lineTo(7 * scale, 15 * scale);
    canvas.drawPath(circularArrow, paint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(CloudBackupPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
