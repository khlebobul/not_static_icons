import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Copy Check Icon - Checkmark appears
class CopyCheckIcon extends AnimatedSVGIcon {
  const CopyCheckIcon({
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
  String get animationDescription => "Checkmark appears";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return CopyCheckPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

class CopyCheckPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  CopyCheckPainter({
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

    // Front rect
    final frontRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(8 * scale, 8 * scale, 14 * scale, 14 * scale),
      Radius.circular(2 * scale),
    );
    canvas.drawRRect(frontRect, paint);

    // Back document
    final backPath = Path();
    backPath.moveTo(4 * scale, 16 * scale);
    backPath.cubicTo(
      2.9 * scale,
      16 * scale,
      2 * scale,
      15.1 * scale,
      2 * scale,
      14 * scale,
    );
    backPath.lineTo(2 * scale, 4 * scale);
    backPath.cubicTo(
      2 * scale,
      2.9 * scale,
      2.9 * scale,
      2 * scale,
      4 * scale,
      2 * scale,
    );
    backPath.lineTo(14 * scale, 2 * scale);
    backPath.cubicTo(
      15.1 * scale,
      2 * scale,
      16 * scale,
      2.9 * scale,
      16 * scale,
      4 * scale,
    );
    canvas.drawPath(backPath, paint);

    // Checkmark with scale animation: m12 15 2 2 4-4
    final oscillation = 4 * animationValue * (1 - animationValue);
    final checkScale = 1.0 + oscillation * 0.2;

    canvas.save();
    canvas.translate(15 * scale, 15.5 * scale);
    canvas.scale(checkScale);
    canvas.translate(-15 * scale, -15.5 * scale);

    final checkPath = Path();
    checkPath.moveTo(12 * scale, 15 * scale);
    checkPath.lineTo(14 * scale, 17 * scale);
    checkPath.lineTo(18 * scale, 13 * scale);
    canvas.drawPath(checkPath, paint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(CopyCheckPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
