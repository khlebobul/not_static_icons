import 'package:flutter/material.dart';
import 'dart:math';
import '../core/animated_svg_icon_base.dart';

/// Animated Accessibility Icon - Wheelchair with moving wheel
class AccessibilityIcon extends AnimatedSVGIcon {
  const AccessibilityIcon({
    super.key,
    super.size = 40.0,
    super.color,
    super.hoverColor,
    super.animationDuration = const Duration(milliseconds: 800),
    super.strokeWidth = 2.0,
  });

  @override
  String get animationDescription => "Wheelchair with rotating wheel";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return AccessibilityPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

/// Painter for Accessibility icon
class AccessibilityPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  AccessibilityPainter({
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
    Offset p(double x, double y) => Offset(x * scale, y * scale);

    // Head circle (circle cx="16" cy="4" r="1")
    canvas.drawCircle(p(16, 4), 1 * scale, paint);

    // Right arm/body path (m18 19 1-7-6 1)
    final rightPath = Path();
    rightPath.moveTo(18 * scale, 19 * scale);
    rightPath.lineTo(19 * scale, 12 * scale); // 19 - 7 = 12
    rightPath.lineTo(13 * scale, 13 * scale); // 19 - 6 = 13
    canvas.drawPath(rightPath, paint);

    // Left arm/body path (m5 8 3-3 5.5 3-2.36 3.5)
    final leftPath = Path();
    leftPath.moveTo(5 * scale, 8 * scale);
    leftPath.lineTo(8 * scale, 5 * scale); // 5 + 3 = 8, 8 - 3 = 5
    leftPath.lineTo(13.5 * scale, 8 * scale); // 8 + 5.5 = 13.5, 5 + 3 = 8
    leftPath.lineTo(
      11.14 * scale,
      11.5 * scale,
    ); // 13.5 - 2.36 = 11.14, 8 + 3.5 = 11.5
    canvas.drawPath(leftPath, paint);

    // First wheel arc (lower part, with gentle rotation): M4.24 14.5a5 5 0 0 0 6.88 6
    final wheelRotation =
        sin(animationValue * 2 * pi) * 0.2; // Small rotation angle
    canvas.save();
    // Rotate around the wheel center (approximately 7.68, 17.5)
    canvas.translate(7.68 * scale, 17.5 * scale);
    canvas.rotate(wheelRotation);
    canvas.translate(-7.68 * scale, -17.5 * scale);

    final arc1Path = Path();
    arc1Path.moveTo(4.24 * scale, 14.5 * scale);
    arc1Path.arcToPoint(
      p(11.12, 20.5), // 4.24 + 6.88 = 11.12, 14.5 + 6 = 20.5
      radius: Radius.circular(5 * scale),
      largeArc: false,
      clockwise: false,
    );
    canvas.drawPath(arc1Path, paint);
    canvas.restore();

    // Second wheel arc (upper part, static): M13.76 17.5a5 5 0 0 0-6.88-6
    final arc2Path = Path();
    arc2Path.moveTo(13.76 * scale, 17.5 * scale);
    arc2Path.arcToPoint(
      p(6.88, 11.5), // 13.76 - 6.88 = 6.88, 17.5 - 6 = 11.5
      radius: Radius.circular(5 * scale),
      largeArc: false,
      clockwise: false,
    );
    canvas.drawPath(arc2Path, paint);
  }

  @override
  bool shouldRepaint(AccessibilityPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
