import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Rotate CCW Icon - Rotates counter-clockwise
class RotateCcwIcon extends AnimatedSVGIcon {
  const RotateCcwIcon({
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
  String get animationDescription => "Rotates counter-clockwise";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return RotateCcwPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

/// Painter for Rotate CCW icon
class RotateCcwPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  RotateCcwPainter({
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

    // Animation - rotate entire icon counter-clockwise
    final oscillation = 4 * animationValue * (1 - animationValue);
    final rotation = -oscillation * 0.5;

    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(rotation);
    canvas.translate(-center.dx, -center.dy);

    // Arrow: M3 3v5h5
    final arrowPath = Path();
    arrowPath.moveTo(3 * scale, 3 * scale);
    arrowPath.lineTo(3 * scale, 8 * scale);
    arrowPath.lineTo(8 * scale, 8 * scale);
    canvas.drawPath(arrowPath, paint);

    // Circle arc: M3 12a9 9 0 1 0 9-9 9.75 9.75 0 0 0-6.74 2.74L3 8
    final circlePath = Path();
    circlePath.moveTo(3 * scale, 12 * scale);
    // Almost full circle (counter-clockwise from left to top)
    circlePath.arcToPoint(
      Offset(12 * scale, 3 * scale),
      radius: Radius.circular(9 * scale),
      largeArc: true,
      clockwise: false,
    );
    // Curve from (12,3) to (5.26, 5.74) then to (3, 8)
    circlePath.cubicTo(
      9.48 * scale,
      3 * scale,
      7.07 * scale,
      4 * scale,
      5.26 * scale,
      5.74 * scale,
    );
    circlePath.lineTo(3 * scale, 8 * scale);
    canvas.drawPath(circlePath, paint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(RotateCcwPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
