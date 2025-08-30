import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Binoculars Icon - exact geometry; center bridge and baseline draw progressively
class BinocularsIcon extends AnimatedSVGIcon {
  const BinocularsIcon({
    super.key,
    super.size = 40.0,
    super.color,
    super.hoverColor,
    super.animationDuration = const Duration(milliseconds: 900),
    super.strokeWidth = 2.0,
    super.reverseOnExit = false,
    super.enableTouchInteraction = true,
    super.infiniteLoop = false,
    super.resetToStartOnComplete = true,
  });

  @override
  String get animationDescription =>
      'Binoculars: slight tilt animation, then return to original';

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) =>
      _BinocularsPainter(
        color: color,
        animationValue: animationValue,
        strokeWidth: strokeWidth,
      );
}

class _BinocularsPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  _BinocularsPainter({
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

    // Calculate tilt animation
    final tiltAngle = animationValue == 0.0
        ? 0.0
        : 0.15 *
            (animationValue < 0.5
                ? (animationValue / 0.5)
                : (1 - (animationValue - 0.5) / 0.5));

    // Apply tilt transformation
    canvas.save();
    canvas.translate(12 * scale, 12 * scale); // Center of binoculars
    canvas.rotate(tiltAngle);
    canvas.translate(-12 * scale, -12 * scale);

    // Eyepiece stems
    // Right: M19 7 V4 a1 1 0 0 0 -1 -1 h-2 a1 1 0 0 0 -1 1 v3
    final rightStem = Path()
      ..moveTo(19 * scale, 7 * scale)
      ..lineTo(19 * scale, 4 * scale)
      ..arcToPoint(Offset(18 * scale, 3 * scale),
          radius: Radius.circular(1 * scale), clockwise: false)
      ..lineTo(16 * scale, 3 * scale)
      ..arcToPoint(Offset(15 * scale, 4 * scale),
          radius: Radius.circular(1 * scale), clockwise: false)
      ..lineTo(15 * scale, 7 * scale);
    canvas.drawPath(rightStem, paint);

    // Left: M9 7 V4 a1 1 0 0 0 -1 -1 H6 a1 1 0 0 0 -1 1 v3
    final leftStem = Path()
      ..moveTo(9 * scale, 7 * scale)
      ..lineTo(9 * scale, 4 * scale)
      ..arcToPoint(Offset(8 * scale, 3 * scale),
          radius: Radius.circular(1 * scale), clockwise: false)
      ..lineTo(6 * scale, 3 * scale)
      ..arcToPoint(Offset(5 * scale, 4 * scale),
          radius: Radius.circular(1 * scale), clockwise: false)
      ..lineTo(5 * scale, 7 * scale);
    canvas.drawPath(leftStem, paint);

    // Right body: M20 21 a2 2 0 0 0 2 -2 v-3.851 c0 -1.39 -2 -2.962 -2 -4.829 V8 a1 1 0 0 0 -1 -1 h-4 a1 1 0 0 0 -1 1 v11 a2 2 0 0 0 2 2 z
    final rightBody = Path()
      ..moveTo(20 * scale, 21 * scale)
      ..arcToPoint(Offset(22 * scale, 19 * scale),
          radius: Radius.circular(2 * scale), clockwise: false)
      ..lineTo(22 * scale, 15.149 * scale)
      ..relativeCubicTo(0, -1.39 * scale, -2 * scale, -2.962 * scale,
          -2 * scale, -4.829 * scale)
      ..lineTo(20 * scale, 8 * scale)
      ..arcToPoint(Offset(19 * scale, 7 * scale),
          radius: Radius.circular(1 * scale), clockwise: false)
      ..lineTo(15 * scale, 7 * scale)
      ..arcToPoint(Offset(14 * scale, 8 * scale),
          radius: Radius.circular(1 * scale), clockwise: false)
      ..lineTo(14 * scale, 19 * scale)
      ..arcToPoint(Offset(16 * scale, 21 * scale),
          radius: Radius.circular(2 * scale), clockwise: false)
      ..close();
    canvas.drawPath(rightBody, paint);

    // Left body: M4 21 a2 2 0 0 1 -2 -2 v-3.851 c0 -1.39 2 -2.962 2 -4.829 V8 a1 1 0 0 1 1 -1 h4 a1 1 0 0 1 1 1 v11 a2 2 0 0 1 -2 2 z
    final leftBody = Path()
      ..moveTo(4 * scale, 21 * scale)
      ..arcToPoint(Offset(2 * scale, 19 * scale),
          radius: Radius.circular(2 * scale), clockwise: true)
      ..lineTo(2 * scale, 15.149 * scale)
      ..relativeCubicTo(0, -1.39 * scale, 2 * scale, -2.962 * scale, 2 * scale,
          -4.829 * scale)
      ..lineTo(4 * scale, 8 * scale)
      ..arcToPoint(Offset(5 * scale, 7 * scale),
          radius: Radius.circular(1 * scale), clockwise: true)
      ..lineTo(9 * scale, 7 * scale)
      ..arcToPoint(Offset(10 * scale, 8 * scale),
          radius: Radius.circular(1 * scale), clockwise: true)
      ..lineTo(10 * scale, 19 * scale)
      ..arcToPoint(Offset(8 * scale, 21 * scale),
          radius: Radius.circular(2 * scale), clockwise: true)
      ..close();
    canvas.drawPath(leftBody, paint);

    // Static baseline: M 22 16 L 2 16
    canvas.drawLine(
        Offset(2 * scale, 16 * scale), Offset(22 * scale, 16 * scale), paint);

    // Static center bridge: M10 10h4
    canvas.drawLine(
        Offset(10 * scale, 10 * scale), Offset(14 * scale, 10 * scale), paint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(_BinocularsPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
