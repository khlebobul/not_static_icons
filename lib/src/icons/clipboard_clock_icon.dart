import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Clipboard Clock Icon - Clock hands move
class ClipboardClockIcon extends AnimatedSVGIcon {
  const ClipboardClockIcon({
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
  String get animationDescription => "Clock hands move";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return ClipboardClockPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

class ClipboardClockPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  ClipboardClockPainter({
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

    final clipRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(8 * scale, 2 * scale, 8 * scale, 4 * scale),
      Radius.circular(1 * scale),
    );
    canvas.drawRRect(clipRect, paint);

    final leftPath = Path();
    leftPath.moveTo(8 * scale, 4 * scale);
    leftPath.lineTo(6 * scale, 4 * scale);
    leftPath.arcToPoint(Offset(4 * scale, 6 * scale), radius: Radius.circular(2 * scale), clockwise: false);
    leftPath.lineTo(4 * scale, 20 * scale);
    leftPath.arcToPoint(Offset(6 * scale, 22 * scale), radius: Radius.circular(2 * scale), clockwise: false);
    leftPath.lineTo(8 * scale, 22 * scale);
    canvas.drawPath(leftPath, paint);

    final topPath = Path();
    topPath.moveTo(16 * scale, 4 * scale);
    topPath.lineTo(18 * scale, 4 * scale);
    topPath.arcToPoint(Offset(20 * scale, 6 * scale), radius: Radius.circular(2 * scale), clockwise: true);
    topPath.lineTo(20 * scale, 6.832 * scale);
    canvas.drawPath(topPath, paint);

    // Clock circle
    canvas.drawCircle(Offset(16 * scale, 16 * scale), 6 * scale, paint);

    // Clock hands with animation
    final oscillation = 4 * animationValue * (1 - animationValue);
    final handAngle = oscillation * 0.3;

    // Hour hand: M16 14v2.2
    canvas.save();
    canvas.translate(16 * scale, 16 * scale);
    canvas.rotate(handAngle);
    canvas.translate(-16 * scale, -16 * scale);
    canvas.drawLine(Offset(16 * scale, 14 * scale), Offset(16 * scale, 16.2 * scale), paint);
    canvas.restore();

    // Minute hand: l1.6 1
    canvas.drawLine(Offset(16 * scale, 16.2 * scale), Offset(17.6 * scale, 17.2 * scale), paint);
  }

  @override
  bool shouldRepaint(ClipboardClockPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
