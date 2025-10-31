import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';
import 'dart:math' as math;

/// Animated Box Icon - opening lid animation
class BoxIcon extends AnimatedSVGIcon {
  const BoxIcon({
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
  String get animationDescription => 'Box: lifting up animation';

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) => _BoxPainter(
        color: color,
        animationValue: animationValue,
        strokeWidth: strokeWidth,
      );
}

class _BoxPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  _BoxPainter({
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

  void _drawCompleteIcon(Canvas canvas, Paint paint, double scale) {
    _drawBox(canvas, paint, scale, 0);
  }

  void _drawAnimated(Canvas canvas, Paint paint, double scale) {
    final t = animationValue;
    
    // Entire box lifts up
    final lift = math.sin(t * math.pi) * -2 * scale;
    _drawBox(canvas, paint, scale, lift);
  }

  void _drawBox(Canvas canvas, Paint paint, double scale, double yOffset) {
    canvas.save();
    canvas.translate(0, yOffset);
    
    // M21 8a2 2 0 0 0-1-1.73l-7-4a2 2 0 0 0-2 0l-7 4A2 2 0 0 0 3 8v8a2 2 0 0 0 1 1.73l7 4a2 2 0 0 0 2 0l7-4A2 2 0 0 0 21 16Z
    final box = Path()
      ..moveTo(21 * scale, 8 * scale)
      ..arcToPoint(
        Offset(20 * scale, 6.27 * scale),
        radius: Radius.circular(2 * scale),
        clockwise: false,
      )
      ..relativeLineTo(-7 * scale, -4 * scale)
      ..arcToPoint(
        Offset(11 * scale, 2.27 * scale),
        radius: Radius.circular(2 * scale),
        clockwise: false,
      )
      ..relativeLineTo(-7 * scale, 4 * scale)
      ..arcToPoint(
        Offset(3 * scale, 8 * scale),
        radius: Radius.circular(2 * scale),
        clockwise: false,
      )
      ..lineTo(3 * scale, 16 * scale)
      ..arcToPoint(
        Offset(4 * scale, 17.73 * scale),
        radius: Radius.circular(2 * scale),
        clockwise: false,
      )
      ..relativeLineTo(7 * scale, 4 * scale)
      ..arcToPoint(
        Offset(13 * scale, 21.73 * scale),
        radius: Radius.circular(2 * scale),
        clockwise: false,
      )
      ..relativeLineTo(7 * scale, -4 * scale)
      ..arcToPoint(
        Offset(21 * scale, 16 * scale),
        radius: Radius.circular(2 * scale),
        clockwise: false,
      )
      ..close();
    canvas.drawPath(box, paint);
    
    // m3.3 7 8.7 5 8.7-5
    final topLine = Path()
      ..moveTo(3.3 * scale, 7 * scale)
      ..relativeLineTo(8.7 * scale, 5 * scale)
      ..relativeLineTo(8.7 * scale, -5 * scale);
    canvas.drawPath(topLine, paint);
    
    // M12 22V12
    canvas.drawLine(
      Offset(12 * scale, 22 * scale),
      Offset(12 * scale, 12 * scale),
      paint,
    );
    
    canvas.restore();
  }

  @override
  bool shouldRepaint(_BoxPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
