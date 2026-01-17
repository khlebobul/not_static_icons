import 'dart:math';
import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

class AnchorIcon extends AnimatedSVGIcon {
  const AnchorIcon({
    super.key,
    super.size,
    super.color,
    super.animationDuration = const Duration(milliseconds: 1500),
    super.strokeWidth = 2.0,
    super.reverseOnExit = false,
    super.enableTouchInteraction = true,
    super.infiniteLoop = false,
    super.onTap,
    super.interactive,
    super.controller,
  });

  @override
  String get animationDescription =>
      'The anchor rotates 360 degrees on its axis on hover.';

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return AnchorPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

class AnchorPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  AnchorPainter({
    required this.color,
    required this.animationValue,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final scale = size.width / 24.0;
    final center = Offset(size.width / 2, size.height / 2);

    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    // Apply rotation animation
    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(animationValue * 2 * pi);
    canvas.translate(-center.dx, -center.dy);

    // Path 1: Vertical line (M12 22V8)
    final path1 = Path()
      ..moveTo(12 * scale, 22 * scale)
      ..lineTo(12 * scale, 8 * scale);
    canvas.drawPath(path1, paint);

    // Path 2: Curved base (M5 12H2a10 10 0 0 0 20 0h-3)
    final path2 = Path();
    path2.moveTo(5 * scale, 12 * scale);
    path2.lineTo(2 * scale, 12 * scale);
    path2.arcTo(
      Rect.fromCircle(
        center: Offset(12 * scale, 12 * scale),
        radius: 10 * scale,
      ),
      pi,
      -pi,
      false,
    );
    path2.moveTo(22 * scale, 12 * scale);
    path2.lineTo(19 * scale, 12 * scale);
    canvas.drawPath(path2, paint);

    // Path 3: Top circle (circle cx="12" cy="5" r="3")
    canvas.drawCircle(Offset(12 * scale, 5 * scale), 3 * scale, paint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(AnchorPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
