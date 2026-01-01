import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Mars Icon - Arrow pulses outward
class MarsIcon extends AnimatedSVGIcon {
  const MarsIcon({
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
  String get animationDescription => "Mars arrow pulses outward";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return MarsPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

/// Painter for Mars icon
class MarsPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  MarsPainter({
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

    // Animation - arrow moves outward
    final oscillation = 4 * animationValue * (1 - animationValue);
    final arrowOffset = oscillation * 1.5;

    // Circle: cx="10" cy="14" r="6"
    canvas.drawCircle(
      Offset(10 * scale, 14 * scale),
      6 * scale,
      paint,
    );

    // Arrow head: M16 3h5v5 (with animation offset)
    final arrowPath = Path();
    arrowPath.moveTo((16 + arrowOffset) * scale, (3 - arrowOffset) * scale);
    arrowPath.lineTo((21 + arrowOffset) * scale, (3 - arrowOffset) * scale);
    arrowPath.lineTo((21 + arrowOffset) * scale, (8 - arrowOffset) * scale);
    canvas.drawPath(arrowPath, paint);

    // Arrow line: m21 3-6.75 6.75 (with animation offset)
    canvas.drawLine(
      Offset((21 + arrowOffset) * scale, (3 - arrowOffset) * scale),
      Offset(14.25 * scale, 9.75 * scale),
      paint,
    );
  }

  @override
  bool shouldRepaint(MarsPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
