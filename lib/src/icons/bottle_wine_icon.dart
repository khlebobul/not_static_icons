import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Bottle Wine Icon - liquid filling animation
class BottleWineIcon extends AnimatedSVGIcon {
  const BottleWineIcon({
    super.key,
    super.size = 40.0,
    super.color,
    super.hoverColor,
    super.animationDuration = const Duration(milliseconds: 1600),
    super.strokeWidth = 2.0,
    super.reverseOnExit = false,
    super.enableTouchInteraction = true,
    super.infiniteLoop = false,
    super.resetToStartOnComplete = true,
  });

  @override
  String get animationDescription => 'BottleWine: label drawing animation';

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) =>
      _BottleWinePainter(
        color: color,
        animationValue: animationValue,
        strokeWidth: strokeWidth,
      );
}

class _BottleWinePainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  _BottleWinePainter({
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
      _drawBottleOutline(canvas, paint, scale);
      _drawAnimatedLabel(canvas, paint, scale);
    }
  }

  void _drawCompleteIcon(Canvas canvas, Paint paint, double scale) {
    _drawBottleOutline(canvas, paint, scale);
    _drawLabel(canvas, paint, scale);
  }

  void _drawBottleOutline(Canvas canvas, Paint paint, double scale) {
    // M10 3a1 1 0 0 1 1-1h2a1 1 0 0 1 1 1v2a6 6 0 0 0 1.2 3.6l.6.8A6 6 0 0 1 17 13v8a1 1 0 0 1-1 1H8a1 1 0 0 1-1-1v-8a6 6 0 0 1 1.2-3.6l.6-.8A6 6 0 0 0 10 5z
    final bottle = Path()
      ..moveTo(10 * scale, 3 * scale)
      ..arcToPoint(
        Offset(11 * scale, 2 * scale),
        radius: Radius.circular(1 * scale),
        clockwise: true,
      )
      ..lineTo(13 * scale, 2 * scale)
      ..arcToPoint(
        Offset(14 * scale, 3 * scale),
        radius: Radius.circular(1 * scale),
        clockwise: true,
      )
      ..lineTo(14 * scale, 5 * scale)
      ..arcToPoint(
        Offset(15.2 * scale, 8.6 * scale),
        radius: Radius.circular(6 * scale),
        clockwise: false,
      )
      ..relativeLineTo(0.6 * scale, 0.8 * scale)
      ..arcToPoint(
        Offset(17 * scale, 13 * scale),
        radius: Radius.circular(6 * scale),
        clockwise: true,
      )
      ..lineTo(17 * scale, 21 * scale)
      ..arcToPoint(
        Offset(16 * scale, 22 * scale),
        radius: Radius.circular(1 * scale),
        clockwise: true,
      )
      ..lineTo(8 * scale, 22 * scale)
      ..arcToPoint(
        Offset(7 * scale, 21 * scale),
        radius: Radius.circular(1 * scale),
        clockwise: true,
      )
      ..lineTo(7 * scale, 13 * scale)
      ..arcToPoint(
        Offset(8.2 * scale, 9.4 * scale),
        radius: Radius.circular(6 * scale),
        clockwise: true,
      )
      ..relativeLineTo(0.6 * scale, -0.8 * scale)
      ..arcToPoint(
        Offset(10 * scale, 5 * scale),
        radius: Radius.circular(6 * scale),
        clockwise: false,
      )
      ..close();
    canvas.drawPath(bottle, paint);
  }

  void _drawAnimatedLabel(Canvas canvas, Paint paint, double scale) {
    final t = animationValue;

    // Progressive drawing of label
    final labelPath = _buildLabelPath(scale);
    final pathMetrics = labelPath.computeMetrics().toList();

    if (pathMetrics.isNotEmpty) {
      for (var pathMetric in pathMetrics) {
        final extractedPath = pathMetric.extractPath(
          0.0,
          pathMetric.length * t,
        );
        canvas.drawPath(extractedPath, paint);
      }
    }
  }

  void _drawLabel(Canvas canvas, Paint paint, double scale) {
    canvas.drawPath(_buildLabelPath(scale), paint);
  }

  Path _buildLabelPath(double scale) {
    // M17 13h-4a1 1 0 0 0-1 1v3a1 1 0 0 0 1 1h4
    return Path()
      ..moveTo(17 * scale, 13 * scale)
      ..lineTo(13 * scale, 13 * scale)
      ..arcToPoint(
        Offset(12 * scale, 14 * scale),
        radius: Radius.circular(1 * scale),
        clockwise: false,
      )
      ..lineTo(12 * scale, 17 * scale)
      ..arcToPoint(
        Offset(13 * scale, 18 * scale),
        radius: Radius.circular(1 * scale),
        clockwise: false,
      )
      ..lineTo(17 * scale, 18 * scale);
  }

  @override
  bool shouldRepaint(_BottleWinePainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
