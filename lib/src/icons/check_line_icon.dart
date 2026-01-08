import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Check Line Icon - Check with underline bounces
class CheckLineIcon extends AnimatedSVGIcon {
  const CheckLineIcon({
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
  String get animationDescription => "Check line bounces";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return CheckLinePainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

/// Painter for Check Line icon
class CheckLinePainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  CheckLinePainter({
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

    // Animation - scale bounce
    final oscillation = 4 * animationValue * (1 - animationValue);
    final scaleAnim = 1.0 + oscillation * 0.15;

    canvas.save();
    canvas.translate(12 * scale, 12 * scale);
    canvas.scale(scaleAnim);
    canvas.translate(-12 * scale, -12 * scale);

    // Check part: M20 4 L9 15 L4 10
    final checkPath = Path();
    checkPath.moveTo(20 * scale, 4 * scale);
    checkPath.lineTo(9 * scale, 15 * scale);
    checkPath.lineTo(4 * scale, 10 * scale);
    canvas.drawPath(checkPath, paint);

    // Bottom line: M3 19 L21 19
    final linePath = Path();
    linePath.moveTo(3 * scale, 19 * scale);
    linePath.lineTo(21 * scale, 19 * scale);
    canvas.drawPath(linePath, paint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(CheckLinePainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
