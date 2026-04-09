import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Copy Icon - Documents slide
class CopyIcon extends AnimatedSVGIcon {
  const CopyIcon({
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
  String get animationDescription => "Documents slide";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return CopyPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

class CopyPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  CopyPainter({
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

    // Front document with slide animation
    final oscillation = 4 * animationValue * (1 - animationValue);
    final slideOffset = oscillation * 2.0;

    canvas.save();
    canvas.translate(slideOffset * scale, slideOffset * scale);

    // Front rect: width="14" height="14" x="8" y="8" rx="2" ry="2"
    final frontRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(8 * scale, 8 * scale, 14 * scale, 14 * scale),
      Radius.circular(2 * scale),
    );
    canvas.drawRRect(frontRect, paint);

    canvas.restore();

    // Back document: M4 16c-1.1 0-2-.9-2-2V4c0-1.1.9-2 2-2h10c1.1 0 2 .9 2 2
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
  }

  @override
  bool shouldRepaint(CopyPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
