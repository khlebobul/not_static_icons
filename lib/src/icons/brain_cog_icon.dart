import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';
import 'dart:math' as math;

/// Animated Brain Cog Icon - rotating gear animation
class BrainCogIcon extends AnimatedSVGIcon {
  const BrainCogIcon({
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
  String get animationDescription => 'BrainCog: rotating gear animation';

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) =>
      _BrainCogPainter(
        color: color,
        animationValue: animationValue,
        strokeWidth: strokeWidth,
      );
}

class _BrainCogPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  _BrainCogPainter({
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
      _drawBrainOutline(canvas, paint, scale);
      _drawRotatingCog(canvas, paint, scale);
    }
  }

  void _drawCompleteIcon(Canvas canvas, Paint paint, double scale) {
    _drawBrainOutline(canvas, paint, scale);
    _drawCogGear(canvas, paint, scale, 0);
  }

  void _drawBrainOutline(Canvas canvas, Paint paint, double scale) {
    // Left brain outline: M17.598 6.5A3 3 0 1 0 12 5a3 3 0 0 0-5.63-1.446 3 3 0 0 0-.368 1.571 4 4 0 0 0-2.525 5.771
    final leftBrain1 = Path()
      ..moveTo(17.598 * scale, 6.5 * scale)
      ..arcToPoint(
        Offset(12 * scale, 5 * scale),
        radius: Radius.circular(3 * scale),
        clockwise: false,
        largeArc: true,
      )
      ..arcToPoint(
        Offset(6.37 * scale, 3.554 * scale),
        radius: Radius.circular(3 * scale),
        clockwise: false,
      )
      ..arcToPoint(
        Offset(6.002 * scale, 5.125 * scale),
        radius: Radius.circular(3 * scale),
        clockwise: false,
      )
      ..arcToPoint(
        Offset(3.477 * scale, 10.896 * scale),
        radius: Radius.circular(4 * scale),
        clockwise: false,
      );
    canvas.drawPath(leftBrain1, paint);

    // M17.998 5.125a4 4 0 0 1 2.525 5.771
    final rightBrain1 = Path()
      ..moveTo(17.998 * scale, 5.125 * scale)
      ..arcToPoint(
        Offset(20.523 * scale, 10.896 * scale),
        radius: Radius.circular(4 * scale),
        clockwise: true,
      );
    canvas.drawPath(rightBrain1, paint);

    // M19.505 10.294a4 4 0 0 1-1.5 7.706
    final rightBrain2 = Path()
      ..moveTo(19.505 * scale, 10.294 * scale)
      ..arcToPoint(
        Offset(18.005 * scale, 18 * scale),
        radius: Radius.circular(4 * scale),
        clockwise: true,
      );
    canvas.drawPath(rightBrain2, paint);

    // M4.032 17.483A4 4 0 0 0 11.464 20c.18-.311.892-.311 1.072 0a4 4 0 0 0 7.432-2.516
    final bottomBrain = Path()
      ..moveTo(4.032 * scale, 17.483 * scale)
      ..arcToPoint(
        Offset(11.464 * scale, 20 * scale),
        radius: Radius.circular(4 * scale),
        clockwise: false,
      )
      ..cubicTo(
        11.644 * scale,
        19.689 * scale,
        12.356 * scale,
        19.689 * scale,
        12.536 * scale,
        20 * scale,
      )
      ..arcToPoint(
        Offset(19.968 * scale, 17.484 * scale),
        radius: Radius.circular(4 * scale),
        clockwise: false,
      );
    canvas.drawPath(bottomBrain, paint);

    // M4.5 10.291A4 4 0 0 0 6 18
    final leftBrain2 = Path()
      ..moveTo(4.5 * scale, 10.291 * scale)
      ..arcToPoint(
        Offset(6 * scale, 18 * scale),
        radius: Radius.circular(4 * scale),
        clockwise: false,
      );
    canvas.drawPath(leftBrain2, paint);

    // M6.002 5.125a3 3 0 0 0 .4 1.375
    final smallCurve = Path()
      ..moveTo(6.002 * scale, 5.125 * scale)
      ..arcToPoint(
        Offset(6.402 * scale, 6.5 * scale),
        radius: Radius.circular(3 * scale),
        clockwise: false,
      );
    canvas.drawPath(smallCurve, paint);
  }

  void _drawRotatingCog(Canvas canvas, Paint paint, double scale) {
    final t = animationValue;
    final rotation = t * 2 * math.pi;

    canvas.save();
    canvas.translate(12 * scale, 12 * scale);
    canvas.rotate(rotation);
    canvas.translate(-12 * scale, -12 * scale);

    _drawCogGear(canvas, paint, scale, rotation);

    canvas.restore();
  }

  void _drawCogGear(Canvas canvas, Paint paint, double scale, double rotation) {
    // Draw gear teeth (8 lines radiating from center)
    final cogLines = [
      {
        'start': 'm10.852 14.772-.383.923',
        'p1': const Offset(10.852, 14.772),
        'p2': const Offset(10.469, 15.695)
      },
      {
        'start': 'm10.852 9.228-.383-.923',
        'p1': const Offset(10.852, 9.228),
        'p2': const Offset(10.469, 8.305)
      },
      {
        'start': 'm13.148 14.772.382.924',
        'p1': const Offset(13.148, 14.772),
        'p2': const Offset(13.53, 15.696)
      },
      {
        'start': 'm13.531 8.305-.383.923',
        'p1': const Offset(13.531, 8.305),
        'p2': const Offset(13.148, 9.228)
      },
      {
        'start': 'm14.772 10.852.923-.383',
        'p1': const Offset(14.772, 10.852),
        'p2': const Offset(15.695, 10.469)
      },
      {
        'start': 'm14.772 13.148.923.383',
        'p1': const Offset(14.772, 13.148),
        'p2': const Offset(15.695, 13.531)
      },
      {
        'start': 'm9.228 10.852-.923-.383',
        'p1': const Offset(9.228, 10.852),
        'p2': const Offset(8.305, 10.469)
      },
      {
        'start': 'm9.228 13.148-.923.383',
        'p1': const Offset(9.228, 13.148),
        'p2': const Offset(8.305, 13.531)
      },
    ];

    for (final line in cogLines) {
      final p1 = line['p1'] as Offset;
      final p2 = line['p2'] as Offset;
      canvas.drawLine(
        Offset(p1.dx * scale, p1.dy * scale),
        Offset(p2.dx * scale, p2.dy * scale),
        paint,
      );
    }

    // Center circle: circle cx="12" cy="12" r="3"
    canvas.drawCircle(
      Offset(12 * scale, 12 * scale),
      3 * scale,
      paint,
    );
  }

  @override
  bool shouldRepaint(_BrainCogPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
