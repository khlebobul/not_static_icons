import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Brain Icon - pulsing neural activity animation
class BrainIcon extends AnimatedSVGIcon {
  const BrainIcon({
    super.key,
    super.size = 40.0,
    super.color,
    super.hoverColor,
    super.animationDuration = const Duration(milliseconds: 1500),
    super.strokeWidth = 2.0,
    super.reverseOnExit = false,
    super.enableTouchInteraction = true,
    super.infiniteLoop = false,
    super.resetToStartOnComplete = true,
  });

  @override
  String get animationDescription => 'Brain: progressive drawing animation';

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) =>
      _BrainPainter(
        color: color,
        animationValue: animationValue,
        strokeWidth: strokeWidth,
      );
}

class _BrainPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  _BrainPainter({
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
      _drawProgressiveBrain(canvas, paint, scale);
    }
  }

  void _drawCompleteIcon(Canvas canvas, Paint paint, double scale) {
    // M12 18V5
    canvas.drawLine(
      Offset(12 * scale, 18 * scale),
      Offset(12 * scale, 5 * scale),
      paint,
    );

    // M15 13 a4.17 4.17 0 0 1 -3 -4 a4.17 4.17 0 0 1 -3 4
    final innerArcs = Path()
      ..moveTo(15 * scale, 13 * scale)
      ..arcToPoint(
        Offset(12 * scale, 9 * scale),
        radius: Radius.circular(4.17 * scale),
        clockwise: true,
      )
      ..arcToPoint(
        Offset(9 * scale, 13 * scale),
        radius: Radius.circular(4.17 * scale),
        clockwise: true,
      );
    canvas.drawPath(innerArcs, paint);

    // M17.598 6.5A3 3 0 1 0 12 5a3 3 0 1 0-5.598 1.5
    final topCurves = Path()
      ..moveTo(17.598 * scale, 6.5 * scale)
      ..arcToPoint(
        Offset(12 * scale, 5 * scale),
        radius: Radius.circular(3 * scale),
        largeArc: true,
        clockwise: false,
      )
      ..arcToPoint(
        Offset(6.402 * scale, 6.5 * scale),
        radius: Radius.circular(3 * scale),
        largeArc: true,
        clockwise: false,
      );
    canvas.drawPath(topCurves, paint);

    // M17.997 5.125a4 4 0 0 1 2.526 5.77
    final rightTop = Path()
      ..moveTo(17.997 * scale, 5.125 * scale)
      ..arcToPoint(
        Offset(20.523 * scale, 10.895 * scale),
        radius: Radius.circular(4 * scale),
        clockwise: true,
      );
    canvas.drawPath(rightTop, paint);

    // M18 18a4 4 0 0 0 2-7.464
    final rightMiddle = Path()
      ..moveTo(18 * scale, 18 * scale)
      ..arcToPoint(
        Offset(20 * scale, 10.536 * scale),
        radius: Radius.circular(4 * scale),
        clockwise: false,
      );
    canvas.drawPath(rightMiddle, paint);

    // M19.967 17.483A4 4 0 1 1 12 18a4 4 0 1 1-7.967-.517
    final bottom = Path()
      ..moveTo(19.967 * scale, 17.483 * scale)
      ..arcToPoint(
        Offset(12 * scale, 18 * scale),
        radius: Radius.circular(4 * scale),
        largeArc: true,
        clockwise: true,
      )
      ..arcToPoint(
        Offset(4.033 * scale, 17.483 * scale),
        radius: Radius.circular(4 * scale),
        largeArc: true,
        clockwise: true,
      );
    canvas.drawPath(bottom, paint);

    // M6 18a4 4 0 0 1-2-7.464
    final leftMiddle = Path()
      ..moveTo(6 * scale, 18 * scale)
      ..arcToPoint(
        Offset(4 * scale, 10.536 * scale),
        radius: Radius.circular(4 * scale),
        clockwise: true,
      );
    canvas.drawPath(leftMiddle, paint);

    // M6.003 5.125a4 4 0 0 0-2.526 5.77
    final leftTop = Path()
      ..moveTo(6.003 * scale, 5.125 * scale)
      ..arcToPoint(
        Offset(3.477 * scale, 10.895 * scale),
        radius: Radius.circular(4 * scale),
        clockwise: false,
      );
    canvas.drawPath(leftTop, paint);
  }

  void _drawProgressiveBrain(Canvas canvas, Paint paint, double scale) {
    final t = animationValue;

    // Build all brain paths in order
    final allPaths = <Path>[];

    // 1. Center vertical line: M12 18V5
    allPaths.add(Path()
      ..moveTo(12 * scale, 18 * scale)
      ..lineTo(12 * scale, 5 * scale));

    // 2. Inner arcs: M15 13 a4.17 4.17 0 0 1 -3 -4 a4.17 4.17 0 0 1 -3 4
    allPaths.add(Path()
      ..moveTo(15 * scale, 13 * scale)
      ..arcToPoint(
        Offset(12 * scale, 9 * scale),
        radius: Radius.circular(4.17 * scale),
        clockwise: true,
      )
      ..arcToPoint(
        Offset(9 * scale, 13 * scale),
        radius: Radius.circular(4.17 * scale),
        clockwise: true,
      ));

    // 3. Top curves: M17.598 6.5A3 3 0 1 0 12 5a3 3 0 1 0-5.598 1.5
    allPaths.add(Path()
      ..moveTo(17.598 * scale, 6.5 * scale)
      ..arcToPoint(
        Offset(12 * scale, 5 * scale),
        radius: Radius.circular(3 * scale),
        largeArc: true,
        clockwise: false,
      )
      ..arcToPoint(
        Offset(6.402 * scale, 6.5 * scale),
        radius: Radius.circular(3 * scale),
        largeArc: true,
        clockwise: false,
      ));

    // 4. Right top: M17.997 5.125a4 4 0 0 1 2.526 5.77
    allPaths.add(Path()
      ..moveTo(17.997 * scale, 5.125 * scale)
      ..arcToPoint(
        Offset(20.523 * scale, 10.895 * scale),
        radius: Radius.circular(4 * scale),
        clockwise: true,
      ));

    // 5. Right middle: M18 18a4 4 0 0 0 2-7.464
    allPaths.add(Path()
      ..moveTo(18 * scale, 18 * scale)
      ..arcToPoint(
        Offset(20 * scale, 10.536 * scale),
        radius: Radius.circular(4 * scale),
        clockwise: false,
      ));

    // 6. Bottom: M19.967 17.483A4 4 0 1 1 12 18a4 4 0 1 1-7.967-.517
    allPaths.add(Path()
      ..moveTo(19.967 * scale, 17.483 * scale)
      ..arcToPoint(
        Offset(12 * scale, 18 * scale),
        radius: Radius.circular(4 * scale),
        largeArc: true,
        clockwise: true,
      )
      ..arcToPoint(
        Offset(4.033 * scale, 17.483 * scale),
        radius: Radius.circular(4 * scale),
        largeArc: true,
        clockwise: true,
      ));

    // 7. Left middle: M6 18a4 4 0 0 1-2-7.464
    allPaths.add(Path()
      ..moveTo(6 * scale, 18 * scale)
      ..arcToPoint(
        Offset(4 * scale, 10.536 * scale),
        radius: Radius.circular(4 * scale),
        clockwise: true,
      ));

    // 8. Left top: M6.003 5.125a4 4 0 0 0-2.526 5.77
    allPaths.add(Path()
      ..moveTo(6.003 * scale, 5.125 * scale)
      ..arcToPoint(
        Offset(3.477 * scale, 10.895 * scale),
        radius: Radius.circular(4 * scale),
        clockwise: false,
      ));

    // Calculate total length
    double totalLength = 0;
    final pathLengths = <double>[];
    for (final path in allPaths) {
      double pathLen = 0;
      for (final metric in path.computeMetrics()) {
        pathLen += metric.length;
      }
      pathLengths.add(pathLen);
      totalLength += pathLen;
    }

    // Draw progressively
    final drawLength = totalLength * t;
    double currentLength = 0;

    for (int i = 0; i < allPaths.length; i++) {
      if (currentLength >= drawLength) break;

      final path = allPaths[i];
      final pathLen = pathLengths[i];
      final remaining = drawLength - currentLength;

      if (remaining >= pathLen) {
        // Draw entire path
        canvas.drawPath(path, paint);
        currentLength += pathLen;
      } else {
        // Draw partial path
        for (final metric in path.computeMetrics()) {
          final segmentLen = metric.length;
          final take = (remaining < segmentLen) ? remaining : segmentLen;
          if (take > 0) {
            canvas.drawPath(metric.extractPath(0, take), paint);
          }
        }
        currentLength += remaining;
      }
    }
  }

  @override
  bool shouldRepaint(_BrainPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
