import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Chess Knight Icon - Knight tilts
class ChessKnightIcon extends AnimatedSVGIcon {
  const ChessKnightIcon({
    super.key,
    super.size = 40.0,
    super.color,
    super.hoverColor,
    super.animationDuration = const Duration(milliseconds: 600),
    super.strokeWidth = 2.0,
    super.reverseOnExit = false,
    super.enableTouchInteraction = true,
    super.infiniteLoop = false,
  });

  @override
  String get animationDescription => "Knight tilts";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return ChessKnightPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

class ChessKnightPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  ChessKnightPainter({
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

    // Animation - slight tilt
    final oscillation = 4 * animationValue * (1 - animationValue);
    final tiltAngle = oscillation * 0.08;

    canvas.save();
    canvas.translate(12 * scale, 21 * scale);
    canvas.rotate(tiltAngle);
    canvas.translate(-12 * scale, -21 * scale);

    // Base
    final basePath = Path();
    basePath.moveTo(5 * scale, 20 * scale);
    basePath.arcToPoint(Offset(7 * scale, 18 * scale), radius: Radius.circular(2 * scale), clockwise: true);
    basePath.lineTo(17 * scale, 18 * scale);
    basePath.arcToPoint(Offset(19 * scale, 20 * scale), radius: Radius.circular(2 * scale), clockwise: true);
    basePath.lineTo(19 * scale, 21 * scale);
    basePath.arcToPoint(Offset(18 * scale, 22 * scale), radius: Radius.circular(1 * scale), clockwise: true);
    basePath.lineTo(6 * scale, 22 * scale);
    basePath.arcToPoint(Offset(5 * scale, 21 * scale), radius: Radius.circular(1 * scale), clockwise: true);
    basePath.close();
    canvas.drawPath(basePath, paint);

    // Body (horse head shape)
    final bodyPath = Path();
    bodyPath.moveTo(16.5 * scale, 18 * scale);
    bodyPath.cubicTo(17.5 * scale, 16 * scale, 19 * scale, 13 * scale, 19 * scale, 9 * scale);
    bodyPath.arcToPoint(Offset(12 * scale, 2 * scale), radius: Radius.circular(7 * scale), clockwise: false);
    bodyPath.lineTo(6.635 * scale, 2 * scale);
    bodyPath.arcToPoint(Offset(5.867 * scale, 3.64 * scale), radius: Radius.circular(1 * scale), clockwise: false);
    bodyPath.lineTo(7 * scale, 5 * scale);
    bodyPath.lineTo(4.68 * scale, 10.802 * scale);
    bodyPath.arcToPoint(Offset(5.63 * scale, 13.328 * scale), radius: Radius.circular(2 * scale), clockwise: false);
    bodyPath.lineTo(8.5 * scale, 14.784 * scale);
    canvas.drawPath(bodyPath, paint);

    // Mane lines
    final mane1 = Path();
    mane1.moveTo(15 * scale, 5 * scale);
    mane1.lineTo(16.425 * scale, 3.575 * scale);
    canvas.drawPath(mane1, paint);

    final mane2 = Path();
    mane2.moveTo(17 * scale, 8 * scale);
    mane2.lineTo(18.53 * scale, 6.47 * scale);
    canvas.drawPath(mane2, paint);

    // Eye to base line
    final eyeLine = Path();
    eyeLine.moveTo(9.713 * scale, 12.185 * scale);
    eyeLine.lineTo(7 * scale, 18 * scale);
    canvas.drawPath(eyeLine, paint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(ChessKnightPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
