import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Chess Pawn Icon - Pawn tilts
class ChessPawnIcon extends AnimatedSVGIcon {
  const ChessPawnIcon({
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
  String get animationDescription => "Pawn tilts";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return ChessPawnPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

class ChessPawnPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  ChessPawnPainter({
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

    // Right leg: m14.5 10 1.5 8
    final rightLeg = Path();
    rightLeg.moveTo(14.5 * scale, 10 * scale);
    rightLeg.lineTo(16 * scale, 18 * scale);
    canvas.drawPath(rightLeg, paint);

    // Horizontal line: M7 10h10
    final horizLine = Path();
    horizLine.moveTo(7 * scale, 10 * scale);
    horizLine.lineTo(17 * scale, 10 * scale);
    canvas.drawPath(horizLine, paint);

    // Left leg: m8 18 1.5-8
    final leftLeg = Path();
    leftLeg.moveTo(8 * scale, 18 * scale);
    leftLeg.lineTo(9.5 * scale, 10 * scale);
    canvas.drawPath(leftLeg, paint);

    // Head circle: cx="12" cy="6" r="4"
    canvas.drawCircle(Offset(12 * scale, 6 * scale), 4 * scale, paint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(ChessPawnPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
