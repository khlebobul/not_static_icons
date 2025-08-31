import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Biohazard Icon - exact geometry; progressive drawing of curved lines
class BiohazardIcon extends AnimatedSVGIcon {
  const BiohazardIcon({
    super.key,
    super.size = 40.0,
    super.color,
    super.hoverColor,
    super.animationDuration = const Duration(milliseconds: 1200),
    super.strokeWidth = 2.0,
    super.reverseOnExit = false,
    super.enableTouchInteraction = true,
    super.infiniteLoop = false,
    super.resetToStartOnComplete = true,
  });

  @override
  String get animationDescription =>
      'Biohazard: static icon, then progressive redrawing';

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) =>
      _BiohazardPainter(
        color: color,
        animationValue: animationValue,
        strokeWidth: strokeWidth,
      );
}

class _BiohazardPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  _BiohazardPainter({
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

    // If animation is at 0, draw complete static icon
    if (animationValue == 0.0) {
      _drawCompleteIcon(canvas, paint, scale);
      return;
    }

    // Progressive redrawing animation
    final redrawProgress = animationValue;

    // Center circle: cx="12" cy="11.9" r="2"
    final centerCircle = Path()
      ..addOval(Rect.fromCircle(
          center: Offset(12 * scale, 11.9 * scale), radius: 2 * scale));
    canvas.drawPath(centerCircle, paint);

    // Top left curved line: M6.7 3.4c-.9 2.5 0 5.2 2.2 6.7C6.5 9 3.7 9.6 2 11.6
    _drawCurvedLineAnimated(
        canvas,
        paint,
        [
          Offset(6.7 * scale, 3.4 * scale),
          Offset(5.8 * scale, 5.9 * scale),
          Offset(5.8 * scale, 8.6 * scale),
          Offset(8.0 * scale, 10.1 * scale),
          Offset(6.5 * scale, 9.0 * scale),
          Offset(3.7 * scale, 9.6 * scale),
          Offset(2.0 * scale, 11.6 * scale),
        ],
        redrawProgress * 0.8);

    // Top right curved line: M17.3 3.4c.9 2.5 0 5.2-2.2 6.7 2.4-1.2 5.2-.6 6.9 1.5
    _drawCurvedLineAnimated(
        canvas,
        paint,
        [
          Offset(17.3 * scale, 3.4 * scale),
          Offset(18.2 * scale, 5.9 * scale),
          Offset(18.2 * scale, 8.6 * scale),
          Offset(16.0 * scale, 10.1 * scale),
          Offset(18.4 * scale, 8.9 * scale),
          Offset(21.2 * scale, 9.3 * scale),
          Offset(22.9 * scale, 11.3 * scale),
        ],
        redrawProgress * 0.8);

    // Bottom curved line: M16.7 20.8c-2.6-.4-4.6-2.6-4.7-5.3-.2 2.6-2.1 4.8-4.7 5.2
    _drawCurvedLineAnimated(
        canvas,
        paint,
        [
          Offset(16.7 * scale, 20.8 * scale),
          Offset(14.1 * scale, 20.4 * scale),
          Offset(11.5 * scale, 18.2 * scale),
          Offset(11.4 * scale, 15.5 * scale),
          Offset(11.2 * scale, 18.1 * scale),
          Offset(9.1 * scale, 20.3 * scale),
          Offset(6.5 * scale, 20.7 * scale),
        ],
        redrawProgress * 0.8);

    // Small connecting lines (appear later)
    if (redrawProgress > 0.6) {
      final smallLinesProgress = (redrawProgress - 0.6) / 0.4;

      // m8.9 10.1 1.4.8
      _drawLineAnimated(canvas, paint,
          start: Offset(8.9 * scale, 10.1 * scale),
          end: Offset(10.3 * scale, 10.9 * scale),
          progress: smallLinesProgress);

      // m15.1 10.1-1.4.8
      _drawLineAnimated(canvas, paint,
          start: Offset(15.1 * scale, 10.1 * scale),
          end: Offset(13.7 * scale, 10.9 * scale),
          progress: smallLinesProgress);

      // M12 13.9v1.6
      _drawLineAnimated(canvas, paint,
          start: Offset(12 * scale, 13.9 * scale),
          end: Offset(12 * scale, 15.5 * scale),
          progress: smallLinesProgress);

      // M13.5 5.4c-1-.2-2-.2-3 0
      _drawCurvedLineAnimated(
          canvas,
          paint,
          [
            Offset(13.5 * scale, 5.4 * scale),
            Offset(12.5 * scale, 5.2 * scale),
            Offset(11.5 * scale, 5.2 * scale),
            Offset(10.5 * scale, 5.4 * scale),
          ],
          smallLinesProgress);

      // M17 16.4c.7-.7 1.2-1.6 1.5-2.5
      _drawCurvedLineAnimated(
          canvas,
          paint,
          [
            Offset(17 * scale, 16.4 * scale),
            Offset(17.7 * scale, 15.7 * scale),
            Offset(18.2 * scale, 14.8 * scale),
            Offset(18.5 * scale, 13.9 * scale),
          ],
          smallLinesProgress);

      // M5.5 13.9c.3.9.8 1.8 1.5 2.5
      _drawCurvedLineAnimated(
          canvas,
          paint,
          [
            Offset(5.5 * scale, 13.9 * scale),
            Offset(5.8 * scale, 14.8 * scale),
            Offset(6.3 * scale, 15.7 * scale),
            Offset(7.0 * scale, 16.4 * scale),
          ],
          smallLinesProgress);
    }
  }

  void _drawCurvedLineAnimated(
      Canvas canvas, Paint paint, List<Offset> points, double progress) {
    if (progress == 0.0) return;

    final path = Path();
    path.moveTo(points[0].dx, points[0].dy);

    for (int i = 1; i < points.length; i++) {
      final t = (progress * points.length - i + 1).clamp(0.0, 1.0);
      if (t > 0) {
        final currentPoint = Offset.lerp(points[i - 1], points[i], t)!;
        path.lineTo(currentPoint.dx, currentPoint.dy);
      }
    }

    canvas.drawPath(path, paint);
  }

  void _drawCompleteIcon(Canvas canvas, Paint paint, double scale) {
    // Center circle: cx="12" cy="11.9" r="2"
    final centerCircle = Path()
      ..addOval(Rect.fromCircle(
          center: Offset(12 * scale, 11.9 * scale), radius: 2 * scale));
    canvas.drawPath(centerCircle, paint);

    // Top left curved line: M6.7 3.4c-.9 2.5 0 5.2 2.2 6.7C6.5 9 3.7 9.6 2 11.6
    final topLeftPath = Path()
      ..moveTo(6.7 * scale, 3.4 * scale)
      ..relativeCubicTo(
          -0.9 * scale, 2.5 * scale, 0, 5.2 * scale, 2.2 * scale, 6.7 * scale)
      ..relativeCubicTo(-1.5 * scale, -1.7 * scale, -4.3 * scale, -1.1 * scale,
          -6.0 * scale, 0.9 * scale);
    canvas.drawPath(topLeftPath, paint);

    // Top right curved line: M17.3 3.4c.9 2.5 0 5.2-2.2 6.7 2.4-1.2 5.2-.6 6.9 1.5
    final topRightPath = Path()
      ..moveTo(17.3 * scale, 3.4 * scale)
      ..relativeCubicTo(
          0.9 * scale, 2.5 * scale, 0, 5.2 * scale, -2.2 * scale, 6.7 * scale)
      ..relativeCubicTo(2.4 * scale, -1.2 * scale, 5.2 * scale, -0.6 * scale,
          6.9 * scale, 1.5 * scale);
    canvas.drawPath(topRightPath, paint);

    // Bottom curved line: M16.7 20.8c-2.6-.4-4.6-2.6-4.7-5.3-.2 2.6-2.1 4.8-4.7 5.2
    final bottomPath = Path()
      ..moveTo(16.7 * scale, 20.8 * scale)
      ..relativeCubicTo(-2.6 * scale, -0.4 * scale, -4.6 * scale, -2.6 * scale,
          -4.7 * scale, -5.3 * scale)
      ..relativeCubicTo(-0.2 * scale, 2.6 * scale, -2.1 * scale, 4.8 * scale,
          -4.7 * scale, 5.2 * scale);
    canvas.drawPath(bottomPath, paint);

    // Small connecting lines
    // m8.9 10.1 1.4.8
    canvas.drawLine(Offset(8.9 * scale, 10.1 * scale),
        Offset(10.3 * scale, 10.9 * scale), paint);

    // m15.1 10.1-1.4.8
    canvas.drawLine(Offset(15.1 * scale, 10.1 * scale),
        Offset(13.7 * scale, 10.9 * scale), paint);

    // M12 13.9v1.6
    canvas.drawLine(Offset(12 * scale, 13.9 * scale),
        Offset(12 * scale, 15.5 * scale), paint);

    // M13.5 5.4c-1-.2-2-.2-3 0
    final topCurve = Path()
      ..moveTo(13.5 * scale, 5.4 * scale)
      ..relativeCubicTo(
          -1 * scale, -0.2 * scale, -2 * scale, -0.2 * scale, -3 * scale, 0);
    canvas.drawPath(topCurve, paint);

    // M17 16.4c.7-.7 1.2-1.6 1.5-2.5
    final rightCurve = Path()
      ..moveTo(17 * scale, 16.4 * scale)
      ..relativeCubicTo(0.7 * scale, -0.7 * scale, 1.2 * scale, -1.6 * scale,
          1.5 * scale, -2.5 * scale);
    canvas.drawPath(rightCurve, paint);

    // M5.5 13.9c.3.9.8 1.8 1.5 2.5
    final leftCurve = Path()
      ..moveTo(5.5 * scale, 13.9 * scale)
      ..relativeCubicTo(0.3 * scale, 0.9 * scale, 0.8 * scale, 1.8 * scale,
          1.5 * scale, 2.5 * scale);
    canvas.drawPath(leftCurve, paint);
  }

  void _drawLineAnimated(Canvas canvas, Paint paint,
      {required Offset start, required Offset end, required double progress}) {
    if (progress == 0.0) return;
    final current = Offset.lerp(start, end, progress)!;
    canvas.drawLine(start, current, paint);
  }

  @override
  bool shouldRepaint(_BiohazardPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
