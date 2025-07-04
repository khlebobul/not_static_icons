import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

class ArrowDown10Icon extends AnimatedSVGIcon {
  const ArrowDown10Icon({
    super.key,
    super.size = 24,
    super.color = Colors.black,
    super.animationDuration = const Duration(milliseconds: 1500),
    super.strokeWidth = 2.0,
  });

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return _ArrowDown10Painter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }

  @override
  String get animationDescription =>
      'Digit 1 shrinks while 0 grows, showing 1 to 0 sorting';
}

class _ArrowDown10Painter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  _ArrowDown10Painter({
    required this.color,
    required this.animationValue,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth / 1.7
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final scaleX = size.width / 24;
    final scaleY = size.height / 24;
    canvas.scale(scaleX, scaleY);

    // Static arrow pointing down
    final arrowHeadPath = Path();
    arrowHeadPath.moveTo(3, 16);
    arrowHeadPath.lineTo(7, 20);
    arrowHeadPath.lineTo(11, 16);
    canvas.drawPath(arrowHeadPath, paint);

    final arrowLinePath = Path();
    arrowLinePath.moveTo(7, 20);
    arrowLinePath.lineTo(7, 4);
    canvas.drawPath(arrowLinePath, paint);

    // Animation scale factors
    double scale1, scale0;
    if (animationValue <= 0.5) {
      // First half: 1 shrinks, 0 grows
      double progress = animationValue * 2;
      scale1 = 1.0 - (progress * 0.3); // 1 shrinks to 70%
      scale0 = 1.0 + (progress * 0.3); // 0 grows to 130%
    } else {
      // Second half: return to normal size
      double progress = (animationValue - 0.5) * 2;
      scale1 = 0.7 + (progress * 0.3); // 1 returns to 100%
      scale0 = 1.3 - (progress * 0.3); // 0 returns to 100%
    }

    // Draw digit 1 (source) - at top
    canvas.save();
    canvas.translate(17, 7); // Center of 1 area
    canvas.scale(scale1, scale1);
    canvas.translate(-17, -7);

    // 1 vertical line with top hook
    final oneVerticalPath = Path();
    oneVerticalPath.moveTo(17, 10);
    oneVerticalPath.lineTo(17, 4);
    oneVerticalPath.lineTo(15, 4);
    canvas.drawPath(oneVerticalPath, paint);

    // 1 bottom horizontal line
    final oneBottomPath = Path();
    oneBottomPath.moveTo(15, 10);
    oneBottomPath.lineTo(19, 10);
    canvas.drawPath(oneBottomPath, paint);

    canvas.restore();

    // Draw digit 0 (target) - at bottom
    canvas.save();
    canvas.translate(17, 17); // Center of 0 area
    canvas.scale(scale0, scale0);
    canvas.translate(-17, -17);

    // 0 as rounded rectangle
    final zeroRect = RRect.fromLTRBR(15, 14, 19, 20, const Radius.circular(2));
    canvas.drawRRect(zeroRect, paint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _ArrowDown10Painter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
