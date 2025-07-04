import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

class ArrowDown01Icon extends AnimatedSVGIcon {
  const ArrowDown01Icon({
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
    return _ArrowDown01Painter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }

  @override
  String get animationDescription =>
      'Digit 0 shrinks while 1 grows, showing 0 to 1 sorting';
}

class _ArrowDown01Painter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  _ArrowDown01Painter({
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

    // Draw digit 0 (source) - at top
    canvas.save();
    canvas.translate(17, 7); // Center of 0 area
    canvas.scale(scale0, scale0);
    canvas.translate(-17, -7);

    // 0 as rounded rectangle
    final zeroRect = RRect.fromLTRBR(15, 4, 19, 10, const Radius.circular(2));
    canvas.drawRRect(zeroRect, paint);

    canvas.restore();

    // Draw digit 1 (target) - at bottom
    canvas.save();
    canvas.translate(17, 17); // Center of 1 area
    canvas.scale(scale1, scale1);
    canvas.translate(-17, -17);

    // 1 vertical line with top hook
    final oneVerticalPath = Path();
    oneVerticalPath.moveTo(17, 20);
    oneVerticalPath.lineTo(17, 14);
    oneVerticalPath.lineTo(15, 14);
    canvas.drawPath(oneVerticalPath, paint);

    // 1 bottom horizontal line
    final oneBottomPath = Path();
    oneBottomPath.moveTo(15, 20);
    oneBottomPath.lineTo(19, 20);
    canvas.drawPath(oneBottomPath, paint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _ArrowDown01Painter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
