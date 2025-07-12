import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Axis 3D Icon - Graph line draws progressively
class Axis3DIcon extends AnimatedSVGIcon {
  const Axis3DIcon({
    super.key,
    super.size = 40.0,
    super.color,
    super.hoverColor,
    super.animationDuration = const Duration(milliseconds: 700),
    super.strokeWidth = 2.0,
    super.reverseOnExit = false,
    super.enableTouchInteraction = true,
    super.infiniteLoop = false,
  });

  @override
  String get animationDescription =>
      "3D axis starts as original, disappears dashed lines, then progressively redraws them.";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return Axis3DPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

/// Painter for Axis 3D icon
class Axis3DPainter extends CustomPainter {
  final Color color;
  final double animationValue; // 0.0 to 1.0
  final double strokeWidth;

  Axis3DPainter({
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

    // Draw static axes first
    _drawStaticAxes(canvas, paint, scale);

    if (animationValue <= 0.3) {
      // Phase 1 (0-30%): Show original icon with dashed lines
      _drawStaticDashedLines(canvas, paint, scale);
    } else if (animationValue <= 0.5) {
      // Phase 2 (30-50%): No dashed lines (just axes)
      // Don't draw anything - just axes
    } else {
      // Phase 3 (50-100%): Draw animated graph line
      final drawProgress = (animationValue - 0.5) / 0.5; // 0.0 to 1.0
      _drawAnimatedGraphLine(canvas, paint, scale, drawProgress);
    }
  }

  void _drawStaticAxes(Canvas canvas, Paint paint, double scale) {
    // Draw main axis frame: M4 4v15a1 1 0 0 0 1 1h15
    final axisPath = Path();

    // Start point: M4 4
    axisPath.moveTo(4 * scale, 4 * scale);

    // Vertical line: v15 (to point 4, 19)
    axisPath.relativeLineTo(0, 15 * scale);

    // Arc: a1 1 0 0 0 1 1 (to point 5, 20)
    axisPath.relativeArcToPoint(
      Offset(1 * scale, 1 * scale),
      radius: Radius.circular(1 * scale),
      rotation: 0,
      largeArc: false,
      clockwise: false,
    );

    // Horizontal line: h15 (to point 20, 20)
    axisPath.relativeLineTo(15 * scale, 0);

    canvas.drawPath(axisPath, paint);
  }

  void _drawStaticDashedLines(Canvas canvas, Paint paint, double scale) {
    // Draw all dashed line segments as they appear in original SVG

    // Segment 1: M4.293 19.707 L6 18
    canvas.drawLine(
      Offset(4.293 * scale, 19.707 * scale),
      Offset(6 * scale, 18 * scale),
      paint,
    );

    // Segment 2: m9 15 l1.5-1.5 (from 9,15 to 10.5,13.5)
    canvas.drawLine(
      Offset(9 * scale, 15 * scale),
      Offset(10.5 * scale, 13.5 * scale),
      paint,
    );

    // Segment 3: M13.5 10.5 L15 9
    canvas.drawLine(
      Offset(13.5 * scale, 10.5 * scale),
      Offset(15 * scale, 9 * scale),
      paint,
    );
  }

  void _drawAnimatedGraphLine(
      Canvas canvas, Paint paint, double scale, double progress) {
    // Define the segments of the dashed line in order they should be drawn
    final segments = [
      // Segment 1: M4.293 19.707 L6 18
      {
        'start': Offset(4.293 * scale, 19.707 * scale),
        'end': Offset(6 * scale, 18 * scale)
      },
      // Segment 2: m9 15 l1.5-1.5 (from 9,15 to 10.5,13.5)
      {
        'start': Offset(9 * scale, 15 * scale),
        'end': Offset(10.5 * scale, 13.5 * scale)
      },
      // Segment 3: M13.5 10.5 L15 9
      {
        'start': Offset(13.5 * scale, 10.5 * scale),
        'end': Offset(15 * scale, 9 * scale)
      },
    ];

    // Calculate total progress for all segments
    final totalSegments = segments.length;
    final currentSegment =
        (progress * totalSegments).floor().clamp(0, totalSegments - 1);
    final segmentProgress = (progress * totalSegments) - currentSegment;

    // Draw completed segments
    for (int i = 0; i < currentSegment; i++) {
      final segment = segments[i];
      canvas.drawLine(
        segment['start'] as Offset,
        segment['end'] as Offset,
        paint,
      );
    }

    // Draw current segment being animated
    if (currentSegment < totalSegments) {
      final segment = segments[currentSegment];
      final start = segment['start'] as Offset;
      final end = segment['end'] as Offset;

      // Calculate current end point based on progress
      final currentEnd = Offset(
        start.dx + (end.dx - start.dx) * segmentProgress,
        start.dy + (end.dy - start.dy) * segmentProgress,
      );

      canvas.drawLine(start, currentEnd, paint);
    }
  }

  @override
  bool shouldRepaint(Axis3DPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
