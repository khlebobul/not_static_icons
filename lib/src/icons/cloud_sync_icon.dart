import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Cloud Sync Icon - Sync arrows rotate
class CloudSyncIcon extends AnimatedSVGIcon {
  const CloudSyncIcon({
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
  String get animationDescription => "Sync arrows rotate";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return CloudSyncPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

class CloudSyncPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  CloudSyncPainter({
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

    // Cloud: M20.996 15.251A4.5 4.5 0 0 0 17.495 8h-1.79a7 7 0 1 0-12.709 5.607
    final cloudPath = Path();
    cloudPath.moveTo(20.996 * scale, 15.251 * scale);
    cloudPath.arcToPoint(
      Offset(17.495 * scale, 8 * scale),
      radius: Radius.circular(4.5 * scale),
      clockwise: false,
    );
    cloudPath.lineTo(15.705 * scale, 8 * scale);
    cloudPath.arcToPoint(
      Offset(2.996 * scale, 13.607 * scale),
      radius: Radius.circular(7 * scale),
      clockwise: false,
      largeArc: true,
    );
    canvas.drawPath(cloudPath, paint);

    // Sync arrows with smooth rotation animation
    final oscillation = 4 * animationValue * (1 - animationValue);
    final rotation = oscillation * math.pi * 0.5;

    canvas.save();
    canvas.translate(12 * scale, 16 * scale);
    canvas.rotate(rotation);
    canvas.translate(-12 * scale, -16 * scale);

    // Top arrow: m17 18-1.535 1.605a5 5 0 0 1-8-1.5
    final topArrow = Path();
    topArrow.moveTo(17 * scale, 18 * scale);
    topArrow.lineTo(15.465 * scale, 19.605 * scale);
    topArrow.arcToPoint(
      Offset(7.465 * scale, 18.105 * scale),
      radius: Radius.circular(5 * scale),
      clockwise: true,
    );
    canvas.drawPath(topArrow, paint);

    // Top arrow head: M17 22v-4h-4
    final topArrowHead = Path();
    topArrowHead.moveTo(17 * scale, 22 * scale);
    topArrowHead.lineTo(17 * scale, 18 * scale);
    topArrowHead.lineTo(13 * scale, 18 * scale);
    canvas.drawPath(topArrowHead, paint);

    // Bottom arrow: m7 14 1.535-1.605a5 5 0 0 1 8 1.5
    final bottomArrow = Path();
    bottomArrow.moveTo(7 * scale, 14 * scale);
    bottomArrow.lineTo(8.535 * scale, 12.395 * scale);
    bottomArrow.arcToPoint(
      Offset(16.535 * scale, 13.895 * scale),
      radius: Radius.circular(5 * scale),
      clockwise: true,
    );
    canvas.drawPath(bottomArrow, paint);

    // Bottom arrow head: M7 10v4h4
    final bottomArrowHead = Path();
    bottomArrowHead.moveTo(7 * scale, 10 * scale);
    bottomArrowHead.lineTo(7 * scale, 14 * scale);
    bottomArrowHead.lineTo(11 * scale, 14 * scale);
    canvas.drawPath(bottomArrowHead, paint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(CloudSyncPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
