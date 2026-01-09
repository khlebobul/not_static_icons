import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Cherry Icon - Cherries swing
class CherryIcon extends AnimatedSVGIcon {
  const CherryIcon({
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
  String get animationDescription => "Cherries swing";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return CherryPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

/// Painter for Cherry icon
class CherryPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  CherryPainter({
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

    // Animation - slight swing rotation
    final oscillation = 4 * animationValue * (1 - animationValue);
    final swingAngle = oscillation * 0.1;

    canvas.save();
    canvas.translate(12 * scale, 5 * scale);
    canvas.rotate(swingAngle);
    canvas.translate(-12 * scale, -5 * scale);

    // Left cherry: M2 17a5 5 0 0 0 10 0c0-2.76-2.5-5-5-3-2.5-2-5 .24-5 3Z
    final leftCherry = Path();
    leftCherry.moveTo(2 * scale, 17 * scale);
    leftCherry.arcToPoint(
      Offset(12 * scale, 17 * scale),
      radius: Radius.circular(5 * scale),
      clockwise: false,
    );
    leftCherry.cubicTo(
      12 * scale, 14.24 * scale,
      9.5 * scale, 12 * scale,
      7 * scale, 14 * scale,
    );
    leftCherry.cubicTo(
      4.5 * scale, 12 * scale,
      2 * scale, 14.24 * scale,
      2 * scale, 17 * scale,
    );
    canvas.drawPath(leftCherry, paint);

    // Right cherry: M12 17a5 5 0 0 0 10 0c0-2.76-2.5-5-5-3-2.5-2-5 .24-5 3Z
    final rightCherry = Path();
    rightCherry.moveTo(12 * scale, 17 * scale);
    rightCherry.arcToPoint(
      Offset(22 * scale, 17 * scale),
      radius: Radius.circular(5 * scale),
      clockwise: false,
    );
    rightCherry.cubicTo(
      22 * scale, 14.24 * scale,
      19.5 * scale, 12 * scale,
      17 * scale, 14 * scale,
    );
    rightCherry.cubicTo(
      14.5 * scale, 12 * scale,
      12 * scale, 14.24 * scale,
      12 * scale, 17 * scale,
    );
    canvas.drawPath(rightCherry, paint);

    // Stems: M7 14c3.22-2.91 4.29-8.75 5-12 1.66 2.38 4.94 9 5 12
    final stems = Path();
    stems.moveTo(7 * scale, 14 * scale);
    stems.cubicTo(
      10.22 * scale, 11.09 * scale,
      11.29 * scale, 5.25 * scale,
      12 * scale, 2 * scale,
    );
    stems.cubicTo(
      13.66 * scale, 4.38 * scale,
      16.94 * scale, 11 * scale,
      17 * scale, 14 * scale,
    );
    canvas.drawPath(stems, paint);

    // Leaf: M22 9c-4.29 0-7.14-2.33-10-7 5.71 0 10 4.67 10 7Z
    final leaf = Path();
    leaf.moveTo(22 * scale, 9 * scale);
    leaf.cubicTo(
      17.71 * scale, 9 * scale,
      14.86 * scale, 6.67 * scale,
      12 * scale, 2 * scale,
    );
    leaf.cubicTo(
      17.71 * scale, 2 * scale,
      22 * scale, 6.67 * scale,
      22 * scale, 9 * scale,
    );
    canvas.drawPath(leaf, paint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(CherryPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
