import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Air Vent Icon - Airflow lines are drawn sequentially.
class AirVentIcon extends AnimatedSVGIcon {
  const AirVentIcon({
    super.key,
    super.size = 100.0,
    super.color,
    super.hoverColor,
    super.animationDuration = const Duration(milliseconds: 1000),
  });

  @override
  String get animationDescription => "Airflow lines are drawn sequentially.";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
  }) {
    return AirVentPainter(color: color, animationValue: animationValue);
  }
}

/// Painter for Air Vent icon
class AirVentPainter extends CustomPainter {
  final Color color;
  final double animationValue;

  AirVentPainter({required this.color, required this.animationValue});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 2.0
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..style = PaintingStyle.stroke;

    final scale = size.width / 24.0;
    Offset p(double x, double y) => Offset(x * scale, y * scale);

    // ========== STATIC PART - HOUSING ==========
    final housingPath = Path()
      ..moveTo(6 * scale, 12 * scale)
      ..lineTo(4 * scale, 12 * scale)
      ..arcToPoint(
        p(2, 10),
        radius: Radius.circular(2 * scale),
        clockwise: true,
      )
      ..lineTo(2 * scale, 5 * scale)
      ..arcToPoint(p(4, 3), radius: Radius.circular(2 * scale), clockwise: true)
      ..lineTo(20 * scale, 3 * scale)
      ..arcToPoint(
        p(22, 5),
        radius: Radius.circular(2 * scale),
        clockwise: true,
      )
      ..lineTo(22 * scale, 10 * scale)
      ..arcToPoint(
        p(20, 12),
        radius: Radius.circular(2 * scale),
        clockwise: true,
      )
      ..lineTo(18 * scale, 12 * scale);
    canvas.drawPath(housingPath, paint);
    canvas.drawLine(p(6, 8), p(18, 8), paint);

    // ========== ANIMATED PART - VENTS ==========

    final leftPath = Path()
      ..moveTo(10 * scale, 12 * scale)
      ..lineTo(10 * scale, 17 * scale)
      ..arcToPoint(
        p(6.6, 15.572),
        radius: Radius.circular(2 * scale),
        largeArc: true,
        clockwise: true,
      );

    final rightPath = Path()
      ..moveTo(14 * scale, 12 * scale)
      ..lineTo(14 * scale, 19.53 * scale)
      ..arcToPoint(
        p(18, 17.5),
        radius: Radius.circular(2.5 * scale),
        largeArc: true,
        clockwise: false,
      );

    // If not animating, draw the complete icon. Otherwise, run animation.
    if (animationValue == 0.0) {
      canvas.drawPath(leftPath, paint);
      canvas.drawPath(rightPath, paint);
    } else {
      // Left Vent Animation
      final leftProgress = (animationValue * 2).clamp(0.0, 1.0);
      for (final metric in leftPath.computeMetrics()) {
        final extract = metric.extractPath(0, metric.length * leftProgress);
        canvas.drawPath(extract, paint);
      }

      // Right Vent Animation
      if (animationValue > 0.5) {
        final rightProgress = ((animationValue - 0.5) * 2).clamp(0.0, 1.0);
        for (final metric in rightPath.computeMetrics()) {
          final extract = metric.extractPath(0, metric.length * rightProgress);
          canvas.drawPath(extract, paint);
        }
      }
    }
  }

  @override
  bool shouldRepaint(AirVentPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue;
  }
}
