import 'package:flutter/material.dart';
import 'dart:math';
import '../core/animated_svg_icon_base.dart';

/// Animated Baggage Claim Icon - Cart moves with bouncing effect
class BaggageClaimIcon extends AnimatedSVGIcon {
  const BaggageClaimIcon({
    super.key,
    super.size = 40.0,
    super.color,
    super.hoverColor,
    super.animationDuration = const Duration(milliseconds: 1000),
    super.strokeWidth = 2.0,
    super.reverseOnExit = false,
    super.enableTouchInteraction = true,
    super.infiniteLoop = false,
    super.onTap,
    super.interactive,
    super.controller,
  });

  @override
  String get animationDescription => "Baggage cart moves with bouncing effect";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return BaggageClaimPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

/// Painter for Baggage Claim icon
class BaggageClaimPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  BaggageClaimPainter({
    required this.color,
    required this.animationValue,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final scale = size.width / 24.0;

    final bounceOffset = sin(animationValue * 2 * pi) * 1.5 * scale;

    canvas.save();
    canvas.translate(bounceOffset, 0);

    // Path 1: conveyor belt - "M22 18H6a2 2 0 0 1-2-2V7a2 2 0 0 0-2-2"
    final path1 = Path()
      ..moveTo(22 * scale, 18 * scale)
      ..lineTo(6 * scale, 18 * scale)
      ..arcToPoint(
        Offset(4 * scale, 16 * scale),
        radius: Radius.circular(2 * scale),
        clockwise: true,
      )
      ..lineTo(4 * scale, 7 * scale)
      ..arcToPoint(
        Offset(2 * scale, 5 * scale),
        radius: Radius.circular(2 * scale),
        clockwise: false,
      );
    canvas.drawPath(path1, paint);

    // Path 2: suitcase handle - "M17 14V4a2 2 0 0 0-2-2h-1a2 2 0 0 0-2 2v10"
    final path2 = Path()
      ..moveTo(17 * scale, 14 * scale)
      ..lineTo(17 * scale, 4 * scale)
      ..arcToPoint(
        Offset(15 * scale, 2 * scale),
        radius: Radius.circular(2 * scale),
        clockwise: false,
      )
      ..lineTo(14 * scale, 2 * scale)
      ..arcToPoint(
        Offset(12 * scale, 4 * scale),
        radius: Radius.circular(2 * scale),
        clockwise: false,
      )
      ..lineTo(12 * scale, 14 * scale);
    canvas.drawPath(path2, paint);

    // Rect: suitcase body - rect x="8" y="6" width="13" height="8" rx="1"
    final rect = RRect.fromRectAndRadius(
      Rect.fromLTWH(8 * scale, 6 * scale, 13 * scale, 8 * scale),
      Radius.circular(1 * scale),
    );
    canvas.drawRRect(rect, paint);

    // Wheels: circles at (18,20) and (9,20), radius 2
    canvas.drawCircle(Offset(18 * scale, 20 * scale), 2 * scale, paint);
    canvas.drawCircle(Offset(9 * scale, 20 * scale), 2 * scale, paint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(BaggageClaimPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
