import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Circle Question Mark Icon - Pulses/scales
class CircleQuestionMarkIcon extends AnimatedSVGIcon {
  const CircleQuestionMarkIcon({
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
  String get animationDescription => "Question mark icon pulses";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return CircleQuestionMarkPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

/// Painter for Circle Question Mark icon
class CircleQuestionMarkPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  CircleQuestionMarkPainter({
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

    // Animation - pulse scale
    final oscillation = 4 * animationValue * (1 - animationValue);
    final scaleAnim = 1.0 + oscillation * 0.1;

    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.scale(scaleAnim);
    canvas.translate(-center.dx, -center.dy);

    // Circle: cx="12" cy="12" r="10"
    canvas.drawCircle(center, 10 * scale, paint);

    // Question mark curve: M9.09 9a3 3 0 0 1 5.83 1c0 2-3 3-3 3
    final questionPath = Path();
    questionPath.moveTo(9.09 * scale, 9 * scale);
    // Arc for the top of question mark
    questionPath.arcToPoint(
      Offset(14.92 * scale, 10 * scale),
      radius: Radius.circular(3 * scale),
      clockwise: true,
    );
    // Curve down to the stem
    questionPath.cubicTo(
      14.92 * scale,
      12 * scale,
      11.92 * scale,
      12 * scale,
      11.92 * scale,
      13 * scale,
    );
    canvas.drawPath(questionPath, paint);

    // Question mark dot: M12 17h.01
    canvas.drawLine(
      Offset(12 * scale, 17 * scale),
      Offset(12.01 * scale, 17 * scale),
      paint,
    );

    canvas.restore();
  }

  @override
  bool shouldRepaint(CircleQuestionMarkPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
