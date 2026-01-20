import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Book Dashed Icon - dashes appearing sequentially
class BookDashedIcon extends AnimatedSVGIcon {
  const BookDashedIcon({
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
    super.onTap,
    super.interactive,
    super.controller,
  });

  @override
  String get animationDescription =>
      'BookDashed: dashes appearing sequentially';

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) =>
      _BookDashedPainter(
        color: color,
        animationValue: animationValue,
        strokeWidth: strokeWidth,
      );
}

class _BookDashedPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  _BookDashedPainter({
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
      // Draw all dashes with progressive alpha
      _drawAnimatedDashes(canvas, paint, scale);
    }
  }

  void _drawCompleteIcon(Canvas canvas, Paint paint, double scale) {
    // Draw all dashes at full opacity
    final dashes = [
      // Top section
      {
        'start': const Offset(12, 2),
        'end': const Offset(13.5, 2),
        'isArc': false
      },
      {
        'start': const Offset(17.5, 2),
        'end': const Offset(19, 2),
        'isArc': false
      },
      {
        'start': const Offset(19, 2),
        'end': const Offset(20, 3),
        'isArc': true,
        'clockwise': true
      },
      {
        'start': const Offset(20, 3),
        'end': const Offset(20, 4.5),
        'isArc': false
      },
      {
        'start': const Offset(20, 8.5),
        'end': const Offset(20, 10),
        'isArc': false
      },
      {
        'start': const Offset(20, 14),
        'end': const Offset(20, 17),
        'isArc': false
      },

      // Right side
      {
        'start': const Offset(20, 17),
        'end': const Offset(17.5, 17),
        'isArc': false
      },
      {
        'start': const Offset(17.5, 22),
        'end': const Offset(19, 22),
        'isArc': false
      },
      {
        'start': const Offset(19, 22),
        'end': const Offset(20, 21),
        'isArc': true,
        'clockwise': false
      },
      {
        'start': const Offset(12, 22),
        'end': const Offset(13.5, 22),
        'isArc': false
      },
      {
        'start': const Offset(12, 17),
        'end': const Offset(13.5, 17),
        'isArc': false
      },

      // Left side
      {
        'start': const Offset(8, 22),
        'end': const Offset(6.5, 22),
        'isArc': false
      },
      {
        'start': const Offset(6.5, 22),
        'end': const Offset(6.5, 17),
        'isArc': true,
        'clockwise': true
      },
      {
        'start': const Offset(6.5, 17),
        'end': const Offset(8, 17),
        'isArc': false
      },
      {
        'start': const Offset(4, 19.5),
        'end': const Offset(4, 14),
        'isArc': false
      },
      {
        'start': const Offset(4, 10),
        'end': const Offset(4, 8.5),
        'isArc': false
      },
      {
        'start': const Offset(4, 4.5),
        'end': const Offset(6.5, 2),
        'isArc': true,
        'clockwise': true,
        'radius': 2.5
      },
      {
        'start': const Offset(6.5, 2),
        'end': const Offset(8, 2),
        'isArc': false
      },
    ];

    for (var dash in dashes) {
      final start = dash['start'] as Offset;
      final end = dash['end'] as Offset;
      final isArc = dash['isArc'] as bool;
      final clockwise = dash['clockwise'] as bool? ?? true;
      final radius = (dash['radius'] as double? ?? 1.0) * scale;

      if (isArc) {
        final arcPath = Path();
        arcPath.moveTo(start.dx * scale, start.dy * scale);
        arcPath.arcToPoint(
          Offset(end.dx * scale, end.dy * scale),
          radius: Radius.circular(radius),
          clockwise: clockwise,
        );
        canvas.drawPath(arcPath, paint);
      } else {
        canvas.drawLine(
          Offset(start.dx * scale, start.dy * scale),
          Offset(end.dx * scale, end.dy * scale),
          paint,
        );
      }
    }
  }

  void _drawAnimatedDashes(Canvas canvas, Paint paint, double scale) {
    final progress = animationValue;

    // Define all dashes with their appearance times
    final dashes = [
      // Top section
      {'start': const Offset(12, 2), 'end': const Offset(13.5, 2), 'time': 0.0},
      {
        'start': const Offset(17.5, 2),
        'end': const Offset(19, 2),
        'time': 0.05
      },
      {
        'start': const Offset(19, 2),
        'end': const Offset(20, 3),
        'time': 0.1,
        'isArc': true,
        'clockwise': true
      },
      {
        'start': const Offset(20, 3),
        'end': const Offset(20, 4.5),
        'time': 0.15
      }, // Added missing part
      {
        'start': const Offset(20, 8.5),
        'end': const Offset(20, 10),
        'time': 0.2
      },
      {
        'start': const Offset(20, 14),
        'end': const Offset(20, 17),
        'time': 0.25
      },

      // Right side
      {
        'start': const Offset(20, 17),
        'end': const Offset(17.5, 17),
        'time': 0.3
      },
      {
        'start': const Offset(17.5, 22),
        'end': const Offset(19, 22),
        'time': 0.35
      },
      {
        'start': const Offset(19, 22),
        'end': const Offset(20, 21),
        'time': 0.4,
        'isArc': true,
        'clockwise': false
      },
      {
        'start': const Offset(12, 22),
        'end': const Offset(13.5, 22),
        'time': 0.45
      },
      {
        'start': const Offset(12, 17),
        'end': const Offset(13.5, 17),
        'time': 0.5
      },

      // Left side
      {
        'start': const Offset(8, 22),
        'end': const Offset(6.5, 22),
        'time': 0.55
      },
      {
        'start': const Offset(6.5, 22),
        'end': const Offset(6.5, 17),
        'time': 0.6,
        'isArc': true,
        'clockwise': true
      },
      {
        'start': const Offset(6.5, 17),
        'end': const Offset(8, 17),
        'time': 0.65
      }, // Added missing part
      {'start': const Offset(4, 19.5), 'end': const Offset(4, 14), 'time': 0.7},
      {'start': const Offset(4, 10), 'end': const Offset(4, 8.5), 'time': 0.75},
      {
        'start': const Offset(4, 4.5),
        'end': const Offset(6.5, 2),
        'time': 0.8,
        'isArc': true,
        'clockwise': true,
        'radius': 2.5
      },
      {'start': const Offset(6.5, 2), 'end': const Offset(8, 2), 'time': 0.85},
    ];

    for (var dash in dashes) {
      final dashTime = dash['time'] as double;
      final fadeStart = dashTime;
      final fadeEnd = dashTime + 0.15;

      if (progress >= fadeStart) {
        final alpha = progress >= fadeEnd
            ? 1.0
            : (progress - fadeStart) / (fadeEnd - fadeStart);

        final dashPaint = Paint()
          ..color = color.withValues(alpha: alpha)
          ..strokeWidth = strokeWidth
          ..strokeCap = StrokeCap.round
          ..strokeJoin = StrokeJoin.round
          ..style = PaintingStyle.stroke;

        final start = dash['start'] as Offset;
        final end = dash['end'] as Offset;
        final isArc = dash['isArc'] as bool? ?? false;
        final clockwise = dash['clockwise'] as bool? ?? true;
        final radius = (dash['radius'] as double? ?? 1.0) * scale;

        if (isArc) {
          // Draw as a small arc path
          final arcPath = Path();
          arcPath.moveTo(start.dx * scale, start.dy * scale);
          arcPath.arcToPoint(
            Offset(end.dx * scale, end.dy * scale),
            radius: Radius.circular(radius),
            clockwise: clockwise,
          );
          canvas.drawPath(arcPath, dashPaint);
        } else {
          // Draw as a line
          canvas.drawLine(
            Offset(start.dx * scale, start.dy * scale),
            Offset(end.dx * scale, end.dy * scale),
            dashPaint,
          );
        }
      }
    }
  }

  @override
  bool shouldRepaint(_BookDashedPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
