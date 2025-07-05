import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

class ArrowUp01Icon extends AnimatedSVGIcon {
  const ArrowUp01Icon({
    super.key,
    super.size = 40,
    super.color = Colors.black,
    super.animationDuration = const Duration(milliseconds: 1500),
    super.strokeWidth = 2.0,
    super.reverseOnExit = false,
    super.enableTouchInteraction = true,
  });

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return _ArrowUp01Painter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }

  @override
  String get animationDescription =>
      'Digit 0 shrinks while 1 grows, showing 0 to 1 sorting upward';
}

class _ArrowUp01Painter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  _ArrowUp01Painter({
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

    // Static arrow pointing up
    final arrowHeadPath = Path();
    arrowHeadPath.moveTo(3, 8);
    arrowHeadPath.lineTo(7, 4);
    arrowHeadPath.lineTo(11, 8);
    canvas.drawPath(arrowHeadPath, paint);

    final arrowLinePath = Path();
    arrowLinePath.moveTo(7, 4);
    arrowLinePath.lineTo(7, 20);
    canvas.drawPath(arrowLinePath, paint);

    // Animation scale factors
    double scale0, scale1;
    if (animationValue <= 0.5) {
      // First half: 0 shrinks, 1 grows
      double progress = animationValue * 2;
      scale0 = 1.0 - (progress * 0.3); // 0 shrinks to 70%
      scale1 = 1.0 + (progress * 0.3); // 1 grows to 130%
    } else {
      // Second half: return to normal size
      double progress = (animationValue - 0.5) * 2;
      scale0 = 0.7 + (progress * 0.3); // 0 returns to 100%
      scale1 = 1.3 - (progress * 0.3); // 1 returns to 100%
    }

    // Draw digit 0 (source) - at bottom
    canvas.save();
    canvas.translate(17, 17); // Center of 0 area
    canvas.scale(scale0, scale0);
    canvas.translate(-17, -17);

    // 0 as rounded rectangle
    final zeroRect = RRect.fromLTRBR(15, 14, 19, 20, const Radius.circular(2));
    canvas.drawRRect(zeroRect, paint);

    canvas.restore();

    // Draw digit 1 (target) - at top
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
  }

  @override
  bool shouldRepaint(covariant _ArrowUp01Painter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
