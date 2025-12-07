import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';
import 'dart:math' as math;

/// Animated CCTV Icon - tilting camera animation (up/down only)
class CctvIcon extends AnimatedSVGIcon {
  const CctvIcon({
    super.key,
    super.size = 40.0,
    super.color,
    super.hoverColor,
    super.animationDuration = const Duration(milliseconds: 3000),
    super.strokeWidth = 2.0,
    super.reverseOnExit = false,
    super.enableTouchInteraction = true,
    super.infiniteLoop = false,
    super.resetToStartOnComplete = true,
  });

  @override
  String get animationDescription => 'CCTV: tilting camera animation';

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) =>
      _CctvPainter(
        color: color,
        animationValue: animationValue,
        strokeWidth: strokeWidth,
      );
}

class _CctvPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  _CctvPainter({
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
      _drawAnimated(canvas, paint, scale);
    }
  }

  // ----------------------
  // FULL STATIC ICON DRAWING
  // ----------------------
  void _drawCompleteIcon(Canvas canvas, Paint paint, double scale) {
    // Camera arm
    final armPath = Path()
      ..moveTo(16.75 * scale, 12 * scale)
      ..lineTo(20.382 * scale, 12 * scale)
      ..arcToPoint(
        Offset(21.276 * scale, 13.447 * scale),
        radius: Radius.circular(1 * scale),
        clockwise: true,
      )
      ..lineTo(19.242 * scale, 17.516 * scale)
      ..arcToPoint(
        Offset(17.534 * scale, 17.65 * scale),
        radius: Radius.circular(1 * scale),
        clockwise: true,
      )
      ..lineTo(15.41 * scale, 14.68 * scale);
    canvas.drawPath(armPath, paint);

    // Camera body
    final bodyPath = Path()
      ..moveTo(17.106 * scale, 9.053 * scale)
      ..arcToPoint(
        Offset(17.553 * scale, 10.394 * scale),
        radius: Radius.circular(1 * scale),
        clockwise: true,
      )
      ..lineTo(14.447 * scale, 16.605 * scale)
      ..arcToPoint(
        Offset(13.105 * scale, 17.052 * scale),
        radius: Radius.circular(1 * scale),
        clockwise: true,
      )
      ..lineTo(3.61 * scale, 12.3 * scale)
      ..arcToPoint(
        Offset(2.31 * scale, 8.39 * scale),
        radius: Radius.circular(2.92 * scale),
        clockwise: true,
      )
      ..lineTo(3.69 * scale, 5.6 * scale)
      ..arcToPoint(
        Offset(7.61 * scale, 4.3 * scale),
        radius: Radius.circular(2.92 * scale),
        clockwise: true,
      )
      ..close();
    canvas.drawPath(bodyPath, paint);

    // Stand
    canvas.drawLine(
      Offset(2 * scale, 19 * scale),
      Offset(5.76 * scale, 19 * scale),
      paint,
    );
    canvas.drawLine(
      Offset(5.76 * scale, 19 * scale),
      Offset(9 * scale, 15 * scale),
      paint,
    );

    // Stand base
    canvas.drawLine(
      Offset(2 * scale, 21 * scale),
      Offset(2 * scale, 17 * scale),
      paint,
    );

    // Indicator
    canvas.drawLine(
      Offset(7 * scale, 9 * scale),
      Offset(7.01 * scale, 9 * scale),
      paint,
    );
  }

  // ----------------------
  // ANIMATED VERSION (UP/DOWN TILT)
  // ----------------------
  void _drawAnimated(Canvas canvas, Paint paint, double scale) {
    final t = animationValue;

    // angle for up/down movement (tilt)
    final maxTilt = 25 * math.pi / 180; // +25° / -25°
    final rotationAngle = math.sin(t * math.pi * 2) * maxTilt;

    // rotation pivot point (camera joint)
    final rotationCenter = Offset(9 * scale, 15 * scale);

    canvas.save();
    canvas.translate(rotationCenter.dx, rotationCenter.dy);
    canvas.rotate(rotationAngle);
    canvas.translate(-rotationCenter.dx, -rotationCenter.dy);

    // Camera arm
    final armPath = Path()
      ..moveTo(16.75 * scale, 12 * scale)
      ..lineTo(20.382 * scale, 12 * scale)
      ..arcToPoint(
        Offset(21.276 * scale, 13.447 * scale),
        radius: Radius.circular(1 * scale),
        clockwise: true,
      )
      ..lineTo(19.242 * scale, 17.516 * scale)
      ..arcToPoint(
        Offset(17.534 * scale, 17.65 * scale),
        radius: Radius.circular(1 * scale),
        clockwise: true,
      )
      ..lineTo(15.41 * scale, 14.68 * scale);
    canvas.drawPath(armPath, paint);

    // Camera body
    final bodyPath = Path()
      ..moveTo(17.106 * scale, 9.053 * scale)
      ..arcToPoint(
        Offset(17.553 * scale, 10.394 * scale),
        radius: Radius.circular(1 * scale),
        clockwise: true,
      )
      ..lineTo(14.447 * scale, 16.605 * scale)
      ..arcToPoint(
        Offset(13.105 * scale, 17.052 * scale),
        radius: Radius.circular(1 * scale),
        clockwise: true,
      )
      ..lineTo(3.61 * scale, 12.3 * scale)
      ..arcToPoint(
        Offset(2.31 * scale, 8.39 * scale),
        radius: Radius.circular(2.92 * scale),
        clockwise: true,
      )
      ..lineTo(3.69 * scale, 5.6 * scale)
      ..arcToPoint(
        Offset(7.61 * scale, 4.3 * scale),
        radius: Radius.circular(2.92 * scale),
        clockwise: true,
      )
      ..close();
    canvas.drawPath(bodyPath, paint);

    // Pulsing indicator
    final pulse = math.sin(t * math.pi * 4) * 0.5 + 0.5;
    final indicatorPaint = Paint()
      ..color = color.withValues(alpha: 0.3 + pulse * 0.7)
      ..style = PaintingStyle.fill;

    canvas.drawCircle(
      Offset(7 * scale, 9 * scale),
      1 * scale * pulse,
      indicatorPaint,
    );

    canvas.restore();

    // Stand (static)
    canvas.drawLine(
      Offset(2 * scale, 19 * scale),
      Offset(5.76 * scale, 19 * scale),
      paint,
    );
    canvas.drawLine(
      Offset(5.76 * scale, 19 * scale),
      Offset(9 * scale, 15 * scale),
      paint,
    );
    canvas.drawLine(
      Offset(2 * scale, 21 * scale),
      Offset(2 * scale, 17 * scale),
      paint,
    );
  }

  @override
  bool shouldRepaint(_CctvPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
