import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Bow Arrow Icon - arrow shooting animation
class BowArrowIcon extends AnimatedSVGIcon {
  const BowArrowIcon({
    super.key,
    super.size = 40.0,
    super.color,
    super.hoverColor,
    super.animationDuration = const Duration(milliseconds: 1800),
    super.strokeWidth = 2.0,
    super.reverseOnExit = false,
    super.enableTouchInteraction = true,
    super.infiniteLoop = false,
    super.resetToStartOnComplete = true,
  });

  @override
  String get animationDescription => 'BowArrow: arrow shooting animation';

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) =>
      _BowArrowPainter(
        color: color,
        animationValue: animationValue,
        strokeWidth: strokeWidth,
      );
}

class _BowArrowPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  _BowArrowPainter({
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

    if (animationValue == 0) {
      _drawCompleteIcon(canvas, paint, scale);
    } else {
      _drawAnimated(canvas, paint, scale);
    }
  }

  void _drawCompleteIcon(Canvas canvas, Paint paint, double scale) {
    _drawBowStrings(canvas, paint, scale);
    _drawArrow(canvas, paint, scale, 0);
  }

  void _drawAnimated(Canvas canvas, Paint paint, double scale) {
    final t = animationValue;

    // Do not draw static target here; it's drawn translated with the arrow below
    _drawBowStrings(canvas, paint, scale);

    // Entire arrow moves diagonally up-right
    final offset = t * 4 * scale;
    _drawArrow(canvas, paint, scale, offset);
  }

  void _drawBowStrings(Canvas canvas, Paint paint, double scale) {
    // M18.575 11.082a13 13 0 0 1 1.048 9.027 1.17 1.17 0 0 1-1.914.597L14 17
    final rightString = Path()
      ..moveTo(18.575 * scale, 11.082 * scale)
      ..arcToPoint(
        Offset(19.623 * scale, 20.109 * scale),
        radius: Radius.circular(13 * scale),
        clockwise: true,
        largeArc: false,
      )
      ..arcToPoint(
        Offset(17.709 * scale, 20.706 * scale),
        radius: Radius.circular(1.17 * scale),
        clockwise: true,
      )
      ..lineTo(14 * scale, 17 * scale);
    canvas.drawPath(rightString, paint);

    // M7 10 L3.29 6.29a1.17 1.17 0 0 1 .6-1.91 13 13 0 0 1 9.03 1.05
    final leftString = Path()
      ..moveTo(7 * scale, 10 * scale)
      ..lineTo(3.29 * scale, 6.29 * scale)
      ..arcToPoint(
        Offset(3.89 * scale, 4.38 * scale),
        radius: Radius.circular(1.17 * scale),
        clockwise: true,
      )
      ..arcToPoint(
        Offset(12.92 * scale, 5.43 * scale),
        radius: Radius.circular(13 * scale),
        clockwise: true,
      );
    canvas.drawPath(leftString, paint);
  }

  void _drawArrow(Canvas canvas, Paint paint, double scale, double offset) {
    canvas.save();
    canvas.translate(offset, -offset);

    // Arrow tip
    final tip = Path()
      ..moveTo(7 * scale, 14 * scale)
      ..arcToPoint(
        Offset(5.793 * scale, 14.5 * scale),
        radius: Radius.circular(1.7 * scale),
        clockwise: false,
      )
      ..relativeLineTo(-2.646 * scale, 2.646 * scale)
      ..arcToPoint(
        Offset(3.5 * scale, 18 * scale),
        radius: Radius.circular(0.5 * scale),
        clockwise: false,
      )
      ..lineTo(5 * scale, 18 * scale)
      ..arcToPoint(
        Offset(6 * scale, 19 * scale),
        radius: Radius.circular(1 * scale),
        clockwise: true,
      )
      ..lineTo(6 * scale, 20.5 * scale)
      ..arcToPoint(
        Offset(6.854 * scale, 20.854 * scale),
        radius: Radius.circular(0.5 * scale),
        clockwise: false,
      )
      ..lineTo(9.5 * scale, 18.207 * scale)
      ..arcToPoint(
        Offset(10 * scale, 17 * scale),
        radius: Radius.circular(1.7 * scale),
        clockwise: false,
      )
      ..lineTo(10 * scale, 15 * scale)
      ..arcToPoint(
        Offset(9 * scale, 14 * scale),
        radius: Radius.circular(1 * scale),
        clockwise: false,
      )
      ..close();
    canvas.drawPath(tip, paint);

    // Arrow line: M9.707 14.293 L21 3
    canvas.drawLine(
      Offset(9.707 * scale, 14.293 * scale),
      Offset(21 * scale, 3 * scale),
      paint,
    );

    // Target corner moves with arrow in animated state
    final target = Path()
      ..moveTo(17 * scale, 3 * scale)
      ..lineTo(21 * scale, 3 * scale)
      ..lineTo(21 * scale, 7 * scale);
    canvas.drawPath(target, paint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(_BowArrowPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
