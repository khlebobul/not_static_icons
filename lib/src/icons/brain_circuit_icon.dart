import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Brain Circuit Icon - circuit connection animation
class BrainCircuitIcon extends AnimatedSVGIcon {
  const BrainCircuitIcon({
    super.key,
    super.size = 40.0,
    super.color,
    super.hoverColor,
    super.animationDuration = const Duration(milliseconds: 2000),
    super.strokeWidth = 2.0,
    super.reverseOnExit = false,
    super.enableTouchInteraction = true,
    super.infiniteLoop = false,
    super.resetToStartOnComplete = true,
  });

  @override
  String get animationDescription =>
      'BrainCircuit: circuit connection animation';

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) =>
      _BrainCircuitPainter(
        color: color,
        animationValue: animationValue,
        strokeWidth: strokeWidth,
      );
}

class _BrainCircuitPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  _BrainCircuitPainter({
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
      _drawBrainOnly(canvas, paint, scale);
      _drawProgressiveCircuit(canvas, paint, scale);
    }
  }

  void _drawCompleteIcon(Canvas canvas, Paint paint, double scale) {
    // Main brain outline: M12 5a3 3 0 1 0-5.997.125 4 4 0 0 0-2.526 5.77 4 4 0 0 0 .556 6.588A4 4 0 1 0 12 18Z
    final brainPath = Path()
      ..moveTo(12 * scale, 5 * scale)
      ..arcToPoint(
        Offset(6.003 * scale, 5.125 * scale),
        radius: Radius.circular(3 * scale),
        largeArc: true,
        clockwise: false,
      )
      ..arcToPoint(
        Offset(3.477 * scale, 10.895 * scale),
        radius: Radius.circular(4 * scale),
        clockwise: false,
      )
      ..arcToPoint(
        Offset(4.033 * scale, 17.483 * scale),
        radius: Radius.circular(4 * scale),
        clockwise: false,
      )
      ..arcToPoint(
        Offset(12 * scale, 18 * scale),
        radius: Radius.circular(4 * scale),
        clockwise: false,
        largeArc: true,
      )
      ..close();
    canvas.drawPath(brainPath, paint);

    // M9 13a4.5 4.5 0 0 0 3-4
    // M9 13 a4.5 4.5 0 0 0 3 -4
    final innerArc = Path()
      ..moveTo(9 * scale, 13 * scale)
      ..arcToPoint(
        Offset(12 * scale, 9 * scale),
        radius: Radius.circular(4.5 * scale),
        clockwise: false,
      );
    canvas.drawPath(innerArc, paint);

    // M6.003 5.125A3 3 0 0 0 6.401 6.5
    final smallCurve1 = Path()
      ..moveTo(6.003 * scale, 5.125 * scale)
      ..arcToPoint(
        Offset(6.401 * scale, 6.5 * scale),
        radius: Radius.circular(3 * scale),
        clockwise: false,
      );
    canvas.drawPath(smallCurve1, paint);

    // M3.477 10.896a4 4 0 0 1 .585-.396
    final smallCurve2 = Path()
      ..moveTo(3.477 * scale, 10.896 * scale)
      ..arcToPoint(
        Offset(4.062 * scale, 10.5 * scale),
        radius: Radius.circular(4 * scale),
        clockwise: true,
      );
    canvas.drawPath(smallCurve2, paint);

    // M6 18a4 4 0 0 1-1.967-.516
    final smallCurve3 = Path()
      ..moveTo(6 * scale, 18 * scale)
      ..arcToPoint(
        Offset(4.033 * scale, 17.484 * scale),
        radius: Radius.circular(4 * scale),
        clockwise: true,
      );
    canvas.drawPath(smallCurve3, paint);

    // Circuit lines and dots (always visible)
    _drawCircuitLines(canvas, paint, scale);
    _drawCircuitDots(canvas, paint, scale);
  }

  void _drawBrainOnly(Canvas canvas, Paint paint, double scale) {
    // Main brain outline
    final brainPath = Path()
      ..moveTo(12 * scale, 5 * scale)
      ..arcToPoint(
        Offset(6.003 * scale, 5.125 * scale),
        radius: Radius.circular(3 * scale),
        largeArc: true,
        clockwise: false,
      )
      ..arcToPoint(
        Offset(3.477 * scale, 10.895 * scale),
        radius: Radius.circular(4 * scale),
        clockwise: false,
      )
      ..arcToPoint(
        Offset(4.033 * scale, 17.483 * scale),
        radius: Radius.circular(4 * scale),
        clockwise: false,
      )
      ..arcToPoint(
        Offset(12 * scale, 18 * scale),
        radius: Radius.circular(4 * scale),
        clockwise: false,
        largeArc: true,
      )
      ..close();
    canvas.drawPath(brainPath, paint);

    // M9 13 a4.5 4.5 0 0 0 3 -4
    final innerArc = Path()
      ..moveTo(9 * scale, 13 * scale)
      ..arcToPoint(
        Offset(12 * scale, 9 * scale),
        radius: Radius.circular(4.5 * scale),
        clockwise: false,
      );
    canvas.drawPath(innerArc, paint);

    // M6.003 5.125A3 3 0 0 0 6.401 6.5
    final smallCurve1 = Path()
      ..moveTo(6.003 * scale, 5.125 * scale)
      ..arcToPoint(
        Offset(6.401 * scale, 6.5 * scale),
        radius: Radius.circular(3 * scale),
        clockwise: false,
      );
    canvas.drawPath(smallCurve1, paint);

    // M3.477 10.896a4 4 0 0 1 .585-.396
    final smallCurve2 = Path()
      ..moveTo(3.477 * scale, 10.896 * scale)
      ..arcToPoint(
        Offset(4.062 * scale, 10.5 * scale),
        radius: Radius.circular(4 * scale),
        clockwise: true,
      );
    canvas.drawPath(smallCurve2, paint);

    // M6 18a4 4 0 0 1-1.967-.516
    final smallCurve3 = Path()
      ..moveTo(6 * scale, 18 * scale)
      ..arcToPoint(
        Offset(4.033 * scale, 17.484 * scale),
        radius: Radius.circular(4 * scale),
        clockwise: true,
      );
    canvas.drawPath(smallCurve3, paint);
  }

  void _drawCircuitLines(Canvas canvas, Paint paint, double scale) {
    // M12 13h4
    canvas.drawLine(
      Offset(12 * scale, 13 * scale),
      Offset(16 * scale, 13 * scale),
      paint,
    );

    // M12 18h6a2 2 0 0 1 2 2v1
    final line1 = Path()
      ..moveTo(12 * scale, 18 * scale)
      ..lineTo(18 * scale, 18 * scale)
      ..arcToPoint(
        Offset(20 * scale, 20 * scale),
        radius: Radius.circular(2 * scale),
        clockwise: true,
      )
      ..lineTo(20 * scale, 21 * scale);
    canvas.drawPath(line1, paint);

    // M12 8h8
    canvas.drawLine(
      Offset(12 * scale, 8 * scale),
      Offset(20 * scale, 8 * scale),
      paint,
    );

    // M16 8V5a2 2 0 0 1 2-2
    final line2 = Path()
      ..moveTo(16 * scale, 8 * scale)
      ..lineTo(16 * scale, 5 * scale)
      ..arcToPoint(
        Offset(18 * scale, 3 * scale),
        radius: Radius.circular(2 * scale),
        clockwise: true,
      );
    canvas.drawPath(line2, paint);
  }

  void _drawCircuitDots(Canvas canvas, Paint paint, double scale) {
    final dotPaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    // Small dots at circuit nodes
    final dots = [
      Offset(16 * scale, 13 * scale),
      Offset(18 * scale, 3 * scale),
      Offset(20 * scale, 21 * scale),
      Offset(20 * scale, 8 * scale),
    ];

    for (final dot in dots) {
      canvas.drawCircle(dot, 0.5 * scale, dotPaint);
    }
  }

  void _drawProgressiveCircuit(Canvas canvas, Paint paint, double scale) {
    final t = animationValue;

    // Build all circuit paths
    final allPaths = <Path>[];

    // M12 13h4
    allPaths.add(Path()
      ..moveTo(12 * scale, 13 * scale)
      ..lineTo(16 * scale, 13 * scale));

    // M12 18h6a2 2 0 0 1 2 2v1
    allPaths.add(Path()
      ..moveTo(12 * scale, 18 * scale)
      ..lineTo(18 * scale, 18 * scale)
      ..arcToPoint(
        Offset(20 * scale, 20 * scale),
        radius: Radius.circular(2 * scale),
        clockwise: true,
      )
      ..lineTo(20 * scale, 21 * scale));

    // M12 8h8
    allPaths.add(Path()
      ..moveTo(12 * scale, 8 * scale)
      ..lineTo(20 * scale, 8 * scale));

    // M16 8V5a2 2 0 0 1 2-2
    allPaths.add(Path()
      ..moveTo(16 * scale, 8 * scale)
      ..lineTo(16 * scale, 5 * scale)
      ..arcToPoint(
        Offset(18 * scale, 3 * scale),
        radius: Radius.circular(2 * scale),
        clockwise: true,
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

    // Draw dots that have been reached
    final dots = [
      {'pos': Offset(16 * scale, 13 * scale), 'threshold': 0.15},
      {'pos': Offset(20 * scale, 21 * scale), 'threshold': 0.40},
      {'pos': Offset(20 * scale, 8 * scale), 'threshold': 0.65},
      {'pos': Offset(18 * scale, 3 * scale), 'threshold': 0.90},
    ];

    final dotPaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    for (final dot in dots) {
      if (t >= (dot['threshold'] as double)) {
        canvas.drawCircle(dot['pos'] as Offset, 0.5 * scale, dotPaint);
      }
    }
  }

  @override
  bool shouldRepaint(_BrainCircuitPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
