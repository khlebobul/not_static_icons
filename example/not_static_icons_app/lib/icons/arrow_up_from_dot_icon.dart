import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

class ArrowUpFromDotIcon extends AnimatedSVGIcon {
  const ArrowUpFromDotIcon({
    super.key,
    super.size = 24,
    super.color = Colors.black,
    super.animationDuration = const Duration(milliseconds: 1500),
  });

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
  }) {
    return _ArrowUpFromDotPainter(color: color, animationValue: animationValue);
  }

  @override
  String get animationDescription => 'Arrow moving up from dot and back once';
}

class _ArrowUpFromDotPainter extends CustomPainter {
  final Color color;
  final double animationValue;

  _ArrowUpFromDotPainter({required this.color, required this.animationValue});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final scaleX = size.width / 24;
    final scaleY = size.height / 24;
    canvas.scale(scaleX, scaleY);

    // Static dot at bottom
    final dotPaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    canvas.drawCircle(const Offset(12, 21), 1, dotPaint);

    // Calculate arrow movement animation (up from dot and back)
    double offsetY = 0.0;
    if (animationValue <= 0.5) {
      // Move up from dot
      offsetY = -3.0 * (animationValue * 2);
    } else {
      // Move back to dot
      offsetY = -3.0 * (2 - animationValue * 2);
    }

    canvas.save();
    canvas.translate(0, offsetY);

    // Arrow head
    final arrowHeadPath = Path();
    arrowHeadPath.moveTo(5, 9);
    arrowHeadPath.lineTo(12, 2);
    arrowHeadPath.lineTo(19, 9);
    canvas.drawPath(arrowHeadPath, paint);

    // Arrow vertical line
    final arrowLinePath = Path();
    arrowLinePath.moveTo(12, 2);
    arrowLinePath.lineTo(12, 16);
    canvas.drawPath(arrowLinePath, paint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
