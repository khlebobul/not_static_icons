import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../core/animated_svg_icon_base.dart';

/// Animated Case Lower Icon - Letters bounce
class CaseLowerIcon extends AnimatedSVGIcon {
  const CaseLowerIcon({
    super.key,
    super.size = 40.0,
    super.color,
    super.hoverColor,
    super.animationDuration = const Duration(milliseconds: 800),
    super.strokeWidth = 2.0,
    super.reverseOnExit = false,
    super.enableTouchInteraction = true,
    super.infiniteLoop = false,
  });

  @override
  String get animationDescription => "Letters bounce";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    // Bounce sequentially
    // 0.0 - 0.5: First letter
    // 0.5 - 1.0: Second letter
    
    double bounce1 = 0.0;
    double bounce2 = 0.0;
    
    if (animationValue < 0.5) {
      final t = animationValue * 2;
      bounce1 = math.sin(t * math.pi) * 2.0;
    } else {
      final t = (animationValue - 0.5) * 2;
      bounce2 = math.sin(t * math.pi) * 2.0;
    }
    
    return CaseLowerPainter(
      color: color,
      bounce1: bounce1,
      bounce2: bounce2,
      strokeWidth: strokeWidth,
    );
  }
}

class CaseLowerPainter extends CustomPainter {
  final Color color;
  final double bounce1;
  final double bounce2;
  final double strokeWidth;

  CaseLowerPainter({
    required this.color,
    required this.bounce1,
    required this.bounce2,
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

    // Letter 1: 'a'
    // M10 9v7
    // circle cx="6.5" cy="12.5" r="3.5"
    canvas.save();
    canvas.translate(0, -bounce1 * scale);
    
    canvas.drawLine(Offset(10 * scale, 9 * scale), Offset(10 * scale, 16 * scale), paint);
    canvas.drawCircle(Offset(6.5 * scale, 12.5 * scale), 3.5 * scale, paint);
    
    canvas.restore();

    // Letter 2: 'b'
    // M14 6v10
    // circle cx="17.5" cy="12.5" r="3.5"
    canvas.save();
    canvas.translate(0, -bounce2 * scale);
    
    canvas.drawLine(Offset(14 * scale, 6 * scale), Offset(14 * scale, 16 * scale), paint);
    canvas.drawCircle(Offset(17.5 * scale, 12.5 * scale), 3.5 * scale, paint);
    
    canvas.restore();
  }

  @override
  bool shouldRepaint(CaseLowerPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.bounce1 != bounce1 ||
        oldDelegate.bounce2 != bounce2 ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
