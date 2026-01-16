import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Chess Queen Icon - Queen tilts
class ChessQueenIcon extends AnimatedSVGIcon {
  const ChessQueenIcon({
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
  String get animationDescription => "Queen tilts";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return ChessQueenPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

class ChessQueenPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  ChessQueenPainter({
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
    basePath.moveTo(4 * scale, 20 * scale);
    basePath.arcToPoint(Offset(6 * scale, 18 * scale), radius: Radius.circular(2 * scale), clockwise: true);
    basePath.lineTo(18 * scale, 18 * scale);
    basePath.arcToPoint(Offset(20 * scale, 20 * scale), radius: Radius.circular(2 * scale), clockwise: true);
    basePath.lineTo(20 * scale, 21 * scale);
    basePath.arcToPoint(Offset(19 * scale, 22 * scale), radius: Radius.circular(1 * scale), clockwise: true);
    basePath.lineTo(5 * scale, 22 * scale);
    basePath.arcToPoint(Offset(4 * scale, 21 * scale), radius: Radius.circular(1 * scale), clockwise: true);
    basePath.close();
    canvas.drawPath(basePath, paint);

    // Right arm path
    final rightArm = Path();
    rightArm.moveTo(12.474 * scale, 5.943 * scale);
    rightArm.lineTo(14.041 * scale, 11.283 * scale);
    rightArm.arcToPoint(Offset(15.791 * scale, 11.611 * scale), radius: Radius.circular(1 * scale), clockwise: false);
    rightArm.lineTo(18.407 * scale, 8.209 * scale);
    canvas.drawPath(rightArm, paint);

    // Right line: m20 9-3 9
    final rightLine = Path();
    rightLine.moveTo(20 * scale, 9 * scale);
    rightLine.lineTo(17 * scale, 18 * scale);
    canvas.drawPath(rightLine, paint);

    // Left arm path
    final leftArm = Path();
    leftArm.moveTo(5.594 * scale, 8.209 * scale);
    leftArm.lineTo(8.209 * scale, 11.612 * scale);
    leftArm.arcToPoint(Offset(9.959 * scale, 11.283 * scale), radius: Radius.circular(1 * scale), clockwise: false);
    leftArm.lineTo(11.526 * scale, 5.943 * scale);
    canvas.drawPath(leftArm, paint);

    // Left line: M7 18 L4 9
    final leftLine = Path();
    leftLine.moveTo(7 * scale, 18 * scale);
    leftLine.lineTo(4 * scale, 9 * scale);
    canvas.drawPath(leftLine, paint);

    // Crown circles
    canvas.drawCircle(Offset(12 * scale, 4 * scale), 2 * scale, paint);
    canvas.drawCircle(Offset(20 * scale, 7 * scale), 2 * scale, paint);
    canvas.drawCircle(Offset(4 * scale, 7 * scale), 2 * scale, paint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(ChessQueenPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
