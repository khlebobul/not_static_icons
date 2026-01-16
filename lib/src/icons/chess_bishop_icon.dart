import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Chess Bishop Icon - Bishop tilts
class ChessBishopIcon extends AnimatedSVGIcon {
  const ChessBishopIcon({
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
  String get animationDescription => "Bishop tilts";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return ChessBishopPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

class ChessBishopPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  ChessBishopPainter({
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

    // Base: M5 20a2 2 0 0 1 2-2h10a2 2 0 0 1 2 2v1a1 1 0 0 1-1 1H6a1 1 0 0 1-1-1z
    final basePath = Path();
    basePath.moveTo(5 * scale, 20 * scale);
    basePath.arcToPoint(Offset(7 * scale, 18 * scale),
        radius: Radius.circular(2 * scale), clockwise: true);
    basePath.lineTo(17 * scale, 18 * scale);
    basePath.arcToPoint(Offset(19 * scale, 20 * scale),
        radius: Radius.circular(2 * scale), clockwise: true);
    basePath.lineTo(19 * scale, 21 * scale);
    basePath.arcToPoint(Offset(18 * scale, 22 * scale),
        radius: Radius.circular(1 * scale), clockwise: true);
    basePath.lineTo(6 * scale, 22 * scale);
    basePath.arcToPoint(Offset(5 * scale, 21 * scale),
        radius: Radius.circular(1 * scale), clockwise: true);
    basePath.close();
    canvas.drawPath(basePath, paint);

    // Body
    final bodyPath = Path();
    bodyPath.moveTo(15 * scale, 18 * scale);
    bodyPath.cubicTo(16.5 * scale, 17.385 * scale, 18 * scale, 15.539 * scale,
        18 * scale, 13.077 * scale);
    bodyPath.cubicTo(18 * scale, 8.769 * scale, 14.5 * scale, 4.462 * scale,
        12 * scale, 2 * scale);
    bodyPath.cubicTo(9.5 * scale, 4.462 * scale, 6 * scale, 8.77 * scale,
        6 * scale, 13.077 * scale);
    bodyPath.cubicTo(6 * scale, 15.539 * scale, 7.5 * scale, 17.385 * scale,
        9 * scale, 18 * scale);
    canvas.drawPath(bodyPath, paint);

    // Diagonal line: m16 7-2.5 2.5
    final diagPath = Path();
    diagPath.moveTo(16 * scale, 7 * scale);
    diagPath.lineTo(13.5 * scale, 9.5 * scale);
    canvas.drawPath(diagPath, paint);

    // Top line: M9 2h6
    final topPath = Path();
    topPath.moveTo(9 * scale, 2 * scale);
    topPath.lineTo(15 * scale, 2 * scale);
    canvas.drawPath(topPath, paint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(ChessBishopPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
