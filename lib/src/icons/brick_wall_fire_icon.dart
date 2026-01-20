import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';
import 'dart:math' as math;

/// Animated Brick Wall Fire Icon - swaying fire animation
class BrickWallFireIcon extends AnimatedSVGIcon {
  const BrickWallFireIcon({
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
    super.onTap,
    super.interactive,
    super.controller,
  });

  @override
  String get animationDescription => 'Brick Wall Fire: swaying fire animation';

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) =>
      _BrickWallFirePainter(
        color: color,
        animationValue: animationValue,
        strokeWidth: strokeWidth,
      );
}

class _BrickWallFirePainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  _BrickWallFirePainter({
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

    _drawWall(canvas, paint, scale);

    if (animationValue == 0) {
      _drawFire(canvas, paint, scale);
    } else {
      _drawSwayingFire(canvas, paint, scale);
    }
  }

  void _drawWall(Canvas canvas, Paint paint, double scale) {
    // Wall outline: M21 8.274V5a2 2 0 0 0-2-2H5a2 2 0 0 0-2 2v14a2 2 0 0 0 2 2h3.938
    final wallPath = Path()
      ..moveTo(21 * scale, 8.274 * scale)
      ..lineTo(21 * scale, 5 * scale)
      ..arcToPoint(
        Offset(19 * scale, 3 * scale),
        radius: Radius.circular(2 * scale),
        clockwise: false,
      )
      ..lineTo(5 * scale, 3 * scale)
      ..arcToPoint(
        Offset(3 * scale, 5 * scale),
        radius: Radius.circular(2 * scale),
        clockwise: false,
      )
      ..lineTo(3 * scale, 19 * scale)
      ..arcToPoint(
        Offset(5 * scale, 21 * scale),
        radius: Radius.circular(2 * scale),
        clockwise: false,
      )
      ..lineTo(8.938 * scale, 21 * scale);
    canvas.drawPath(wallPath, paint);

    // M16 3v2.107
    canvas.drawLine(
      Offset(16 * scale, 3 * scale),
      Offset(16 * scale, 5.107 * scale),
      paint,
    );

    // M3 15h5.253
    canvas.drawLine(
      Offset(3 * scale, 15 * scale),
      Offset(8.253 * scale, 15 * scale),
      paint,
    );

    // M3 9h8.228
    canvas.drawLine(
      Offset(3 * scale, 9 * scale),
      Offset(11.228 * scale, 9 * scale),
      paint,
    );

    // M8 15v6
    canvas.drawLine(
      Offset(8 * scale, 15 * scale),
      Offset(8 * scale, 21 * scale),
      paint,
    );

    // M8 3v6
    canvas.drawLine(
      Offset(8 * scale, 3 * scale),
      Offset(8 * scale, 9 * scale),
      paint,
    );
  }

  void _drawFire(Canvas canvas, Paint paint, double scale) {
    // Fire: M17 9c1 3 2.5 3.5 3.5 4.5A5 5 0 0 1 22 17a5 5 0 0 1-10 0c0-.3 0-.6.1-.9a2 2 0 1 0 3.3-2C13 11.5 16 9 17 9
    final firePath = Path()
      ..moveTo(17 * scale, 9 * scale)
      ..cubicTo(
        18 * scale,
        12 * scale,
        19.5 * scale,
        12.5 * scale,
        20.5 * scale,
        13.5 * scale,
      )
      ..arcToPoint(
        Offset(22 * scale, 17 * scale),
        radius: Radius.circular(5 * scale),
        clockwise: true,
      )
      ..arcToPoint(
        Offset(12 * scale, 17 * scale),
        radius: Radius.circular(5 * scale),
        largeArc: true,
        clockwise: true,
      )
      ..cubicTo(
        12 * scale,
        16.7 * scale,
        12 * scale,
        16.4 * scale,
        12.1 * scale,
        16.1 * scale,
      )
      ..arcToPoint(
        Offset(15.4 * scale, 14.1 * scale),
        radius: Radius.circular(2 * scale),
        largeArc: true,
        clockwise: false,
      )
      ..cubicTo(
        13 * scale,
        11.5 * scale,
        16 * scale,
        9 * scale,
        17 * scale,
        9 * scale,
      );
    canvas.drawPath(firePath, paint);
  }

  void _drawSwayingFire(Canvas canvas, Paint paint, double scale) {
    final t = animationValue;
    final sway = math.sin(t * math.pi * 2) * 1.0 * scale;

    canvas.save();
    canvas.translate(sway, 0);
    _drawFire(canvas, paint, scale);
    canvas.restore();
  }

  @override
  bool shouldRepaint(_BrickWallFirePainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
