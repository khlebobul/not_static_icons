import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Closed Caption Icon - Caption brackets pulse
class ClosedCaptionIcon extends AnimatedSVGIcon {
  const ClosedCaptionIcon({
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
  String get animationDescription => "Caption brackets pulse";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return ClosedCaptionPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

class ClosedCaptionPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  ClosedCaptionPainter({
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

    // Rectangle: x="2" y="5" width="20" height="14" rx="2"
    final rect = RRect.fromRectAndRadius(
      Rect.fromLTWH(2 * scale, 5 * scale, 20 * scale, 14 * scale),
      Radius.circular(2 * scale),
    );
    canvas.drawRRect(rect, paint);

    // Caption brackets pulse animation
    final oscillation = 4 * animationValue * (1 - animationValue);
    final pulseScale = 1.0 + oscillation * 0.15;

    // Left C: M10 9.17a3 3 0 1 0 0 5.66
    canvas.save();
    canvas.translate(10 * scale, 12 * scale);
    canvas.scale(pulseScale);
    canvas.translate(-10 * scale, -12 * scale);

    final leftC = Path();
    leftC.moveTo(10 * scale, 9.17 * scale);
    leftC.arcToPoint(
      Offset(10 * scale, 14.83 * scale),
      radius: Radius.circular(3 * scale),
      clockwise: false,
      largeArc: true,
    );
    canvas.drawPath(leftC, paint);

    canvas.restore();

    // Right C: M17 9.17a3 3 0 1 0 0 5.66
    canvas.save();
    canvas.translate(17 * scale, 12 * scale);
    canvas.scale(pulseScale);
    canvas.translate(-17 * scale, -12 * scale);

    final rightC = Path();
    rightC.moveTo(17 * scale, 9.17 * scale);
    rightC.arcToPoint(
      Offset(17 * scale, 14.83 * scale),
      radius: Radius.circular(3 * scale),
      clockwise: false,
      largeArc: true,
    );
    canvas.drawPath(rightC, paint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(ClosedCaptionPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
