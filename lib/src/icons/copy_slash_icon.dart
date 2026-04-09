import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Copy Slash Icon - Slash appears
class CopySlashIcon extends AnimatedSVGIcon {
  const CopySlashIcon({
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
  String get animationDescription => "Slash appears";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return CopySlashPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

class CopySlashPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  CopySlashPainter({
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

    // Slash with scale animation: x1="12" x2="18" y1="18" y2="12"
    final oscillation = 4 * animationValue * (1 - animationValue);
    final slashScale = 1.0 + oscillation * 0.15;

    canvas.save();
    canvas.translate(15 * scale, 15 * scale);
    canvas.scale(slashScale);
    canvas.translate(-15 * scale, -15 * scale);

    canvas.drawLine(
        Offset(12 * scale, 18 * scale), Offset(18 * scale, 12 * scale), paint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(CopySlashPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
