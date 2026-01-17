import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Rotate CW Icon - Rotates clockwise
class RotateCwIcon extends AnimatedSVGIcon {
  const RotateCwIcon({
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
  String get animationDescription => "Rotates clockwise";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return RotateCwPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

/// Painter for Rotate CW icon
class RotateCwPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  RotateCwPainter({
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
    final center = Offset(12 * scale, 12 * scale);

    // Animation - rotate entire icon clockwise
    final oscillation = 4 * animationValue * (1 - animationValue);
    final rotation = oscillation * 0.5;

    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(rotation);
    canvas.translate(-center.dx, -center.dy);

    // Arrow: M21 3v5h-5
    final arrowPath = Path();
    arrowPath.moveTo(21 * scale, 3 * scale);
    arrowPath.lineTo(21 * scale, 8 * scale);
    arrowPath.lineTo(16 * scale, 8 * scale);
    canvas.drawPath(arrowPath, paint);

    // Circle arc: M21 12a9 9 0 1 1-9-9c2.52 0 4.93 1 6.74 2.74L21 8
    final circlePath = Path();
    circlePath.moveTo(21 * scale, 12 * scale);
    // Almost full circle (clockwise from right to top)
    circlePath.arcToPoint(
      Offset(12 * scale, 3 * scale),
      radius: Radius.circular(9 * scale),
      largeArc: true,
      clockwise: true,
    );
    // Curve from (12,3) to (18.74, 5.74) then to (21, 8)
    circlePath.cubicTo(
      14.52 * scale,
      3 * scale,
      16.93 * scale,
      4 * scale,
      18.74 * scale,
      5.74 * scale,
    );
    circlePath.lineTo(21 * scale, 8 * scale);
    canvas.drawPath(circlePath, paint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(RotateCwPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
