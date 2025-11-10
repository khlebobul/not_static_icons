import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';
import 'dart:math' as math;

/// Animated Brick Wall Shield Icon - shield pulsing protection animation
class BrickWallShieldIcon extends AnimatedSVGIcon {
  const BrickWallShieldIcon({
    super.key,
    super.size = 40.0,
    super.color,
    super.hoverColor,
    super.animationDuration = const Duration(milliseconds: 1400),
    super.strokeWidth = 2.0,
    super.reverseOnExit = false,
    super.enableTouchInteraction = true,
    super.infiniteLoop = false,
    super.resetToStartOnComplete = true,
  });

  @override
  String get animationDescription => 'Brick Wall Shield: shield pulsing size animation';

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) => _BrickWallShieldPainter(
        color: color,
        animationValue: animationValue,
        strokeWidth: strokeWidth,
      );
}

class _BrickWallShieldPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  _BrickWallShieldPainter({
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
      _drawShield(canvas, paint, scale);
    } else {
      _drawAnimatedShield(canvas, paint, scale);
    }
  }

  void _drawWall(Canvas canvas, Paint paint, double scale) {
    // Wall outline: M21 9.118V5a2 2 0 0 0-2-2H5a2 2 0 0 0-2 2v14a2 2 0 0 0 2 2h5.75
    final wallPath = Path()
      ..moveTo(21 * scale, 9.118 * scale)
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
      ..lineTo(10.75 * scale, 21 * scale);
    canvas.drawPath(wallPath, paint);

    // M12 9v1.258
    canvas.drawLine(
      Offset(12 * scale, 9 * scale),
      Offset(12 * scale, 10.258 * scale),
      paint,
    );

    // M16 3v5.46
    canvas.drawLine(
      Offset(16 * scale, 3 * scale),
      Offset(16 * scale, 8.46 * scale),
      paint,
    );

    // M3 15h7
    canvas.drawLine(
      Offset(3 * scale, 15 * scale),
      Offset(10 * scale, 15 * scale),
      paint,
    );

    // M3 9h12.142
    canvas.drawLine(
      Offset(3 * scale, 9 * scale),
      Offset(15.142 * scale, 9 * scale),
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

  void _drawShield(Canvas canvas, Paint paint, double scale) {
    // Shield: M22 17.5c0 2.499-1.75 3.749-3.83 4.474a.5.5 0 0 1-.335-.005c-2.085-.72-3.835-1.97-3.835-4.47V14a.5.5 0 0 1 .5-.499c1 0 2.25-.6 3.12-1.36a.6.6 0 0 1 .76-.001c.875.765 2.12 1.36 3.12 1.36a.5.5 0 0 1 .5.5z
    final shieldPath = Path()
      ..moveTo(22 * scale, 17.5 * scale)
      ..cubicTo(
        22 * scale, 20 * scale,
        20.25 * scale, 21.25 * scale,
        18.17 * scale, 21.974 * scale,
      )
      ..arcToPoint(
        Offset(17.835 * scale, 21.969 * scale),
        radius: Radius.circular(0.5 * scale),
        clockwise: true,
      )
      ..cubicTo(
        15.75 * scale, 21.249 * scale,
        14 * scale, 19.999 * scale,
        14 * scale, 17.5 * scale,
      )
      ..lineTo(14 * scale, 14 * scale)
      ..arcToPoint(
        Offset(14.5 * scale, 13.501 * scale),
        radius: Radius.circular(0.5 * scale),
        clockwise: true,
      )
      ..cubicTo(
        15.5 * scale, 13.501 * scale,
        16.75 * scale, 12.901 * scale,
        17.62 * scale, 12.141 * scale,
      )
      ..arcToPoint(
        Offset(18.38 * scale, 12.14 * scale),
        radius: Radius.circular(0.6 * scale),
        clockwise: true,
      )
      ..cubicTo(
        19.255 * scale, 12.905 * scale,
        20.5 * scale, 13.5 * scale,
        21.5 * scale, 13.5 * scale,
      )
      ..arcToPoint(
        Offset(22 * scale, 14 * scale),
        radius: Radius.circular(0.5 * scale),
        clockwise: true,
      )
      ..close();
    canvas.drawPath(shieldPath, paint);
  }

  void _drawAnimatedShield(Canvas canvas, Paint paint, double scale) {
    final t = animationValue;
    final pulse = math.sin(t * math.pi);
    final scaleFactor = 1.0 + pulse * 0.08;

    final shieldCenter = Offset(18 * scale, 17.7 * scale);

    canvas.save();
    canvas.translate(shieldCenter.dx, shieldCenter.dy);
    canvas.scale(scaleFactor);
    canvas.translate(-shieldCenter.dx, -shieldCenter.dy);
    _drawShield(canvas, paint, scale);
    canvas.restore();
  }

  @override
  bool shouldRepaint(_BrickWallShieldPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}

