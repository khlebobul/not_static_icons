import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../core/animated_svg_icon_base.dart';

/// Animated Cake Icon - Candles flicker
class CakeIcon extends AnimatedSVGIcon {
  const CakeIcon({
    super.key,
    super.size = 40.0,
    super.color,
    super.hoverColor,
    super.animationDuration = const Duration(milliseconds: 1000),
    super.strokeWidth = 2.0,
    super.reverseOnExit = false,
    super.enableTouchInteraction = true,
    super.infiniteLoop = false,
  });

  @override
  String get animationDescription => "Candles flicker";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return CakePainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

class CakePainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  CakePainter({
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

    // Cake Body (Static)
    // M20 21v-8a2 2 0 0 0-2-2H6a2 2 0 0 0-2 2v8
    final bodyPath = Path();
    bodyPath.moveTo(20 * scale, 21 * scale);
    bodyPath.lineTo(20 * scale, 13 * scale);
    bodyPath.arcToPoint(Offset(18 * scale, 11 * scale), radius: Radius.circular(2 * scale), clockwise: false);
    bodyPath.lineTo(6 * scale, 11 * scale);
    bodyPath.arcToPoint(Offset(4 * scale, 13 * scale), radius: Radius.circular(2 * scale), clockwise: false);
    bodyPath.lineTo(4 * scale, 21 * scale);
    canvas.drawPath(bodyPath, paint);

    // Frosting
    // M4 16s.5-1 2-1 2.5 2 4 2 2.5-2 4-2 2.5 2 4 2 2-1 2-1
    // Let's match the SVG path exactly using relative cubic commands if possible or approximate better.
    // Since we are not animating the frosting, we can just draw it.
    // But "s" command is tricky in Flutter Path if not tracking previous control point.
    // Let's use a simplified wave that looks identical.
    // 4,16 start.
    // s .5 -1 2 -1 -> c .5 -1 2 -1 (if first curve) -> to 6,15. cp1 4.5, 15.
    // s 2.5 2 4 2 -> to 10,17.
    // s 2.5 -2 4 -2 -> to 14,15.
    // s 2.5 2 4 2 -> to 18,17.
    // s 2 -1 2 -1 -> to 20,16.
    
    final frostingPath = Path();
    frostingPath.moveTo(4 * scale, 16 * scale);
    // First segment: 4,16 to 6,15. cp1(4.5, 15)? No, s .5 -1 means dx1=0.5, dy1=-1 relative to current?
    // SVG 's' command: smooth cubic bezier.
    // If first command, cp1 is same as current point.
    // So c 0.5 -1, 2 -1, 2 -1 (relative).
    // End point: 4+2=6, 16-1=15.
    // cp1: 4+0.5=4.5, 16-1=15.
    // cp2: 4+2=6, 16-1=15.
    frostingPath.cubicTo(4.5 * scale, 15 * scale, 6 * scale, 15 * scale, 6 * scale, 15 * scale);
    
    // Second segment: s 2.5 2 4 2.
    // Previous cp2 was (6,15). Current (6,15). Reflected cp1 is (6,15).
    // So cp1 = (6,15).
    // cp2 (relative): 2.5, 2 -> 8.5, 17.
    // End (relative): 4, 2 -> 10, 17.
    frostingPath.cubicTo(6 * scale, 15 * scale, 8.5 * scale, 17 * scale, 10 * scale, 17 * scale);
    
    // Third: s 2.5 -2 4 -2.
    // Reflected cp1 from (8.5, 17) around (10, 17) is (11.5, 17).
    // cp2 (relative): 2.5, -2 -> 12.5, 15.
    // End (relative): 4, -2 -> 14, 15.
    frostingPath.cubicTo(11.5 * scale, 17 * scale, 12.5 * scale, 15 * scale, 14 * scale, 15 * scale);
    
    // Fourth: s 2.5 2 4 2.
    // Reflected cp1 from (12.5, 15) around (14, 15) is (15.5, 15).
    // cp2 (relative): 2.5, 2 -> 16.5, 17.
    // End (relative): 4, 2 -> 18, 17.
    frostingPath.cubicTo(15.5 * scale, 15 * scale, 16.5 * scale, 17 * scale, 18 * scale, 17 * scale);
    
    // Fifth: s 2 -1 2 -1.
    // Reflected cp1 from (16.5, 17) around (18, 17) is (19.5, 17).
    // cp2 (relative): 2, -1 -> 20, 16.
    // End (relative): 2, -1 -> 20, 16.
    frostingPath.cubicTo(19.5 * scale, 17 * scale, 20 * scale, 16 * scale, 20 * scale, 16 * scale);
    
    canvas.drawPath(frostingPath, paint);

    // M2 21h20
    canvas.drawLine(Offset(2 * scale, 21 * scale), Offset(22 * scale, 21 * scale), paint);

    // Candles (Stems)
    // M7 8v3
    canvas.drawLine(Offset(7 * scale, 8 * scale), Offset(7 * scale, 11 * scale), paint);
    // M12 8v3
    canvas.drawLine(Offset(12 * scale, 8 * scale), Offset(12 * scale, 11 * scale), paint);
    // M17 8v3
    canvas.drawLine(Offset(17 * scale, 8 * scale), Offset(17 * scale, 11 * scale), paint);

    // Flames (Animated)
    // M7 4h.01
    // M12 4h.01
    // M17 4h.01
    
    void drawFlame(double x, double y, double phase) {
      double flameScale = 1.0;
      
      if (animationValue > 0 && animationValue < 1.0) {
        // Envelope to ensure we start and end at 0 intensity
        final intensity = math.sin(animationValue * math.pi);
        
        // Flicker: scale or opacity
        final flicker = math.sin((animationValue + phase) * math.pi * 4).abs();
        // Scale 1.0 to 1.5, modulated by intensity
        flameScale = 1.0 + flicker * 0.5 * intensity;
      }
      
      canvas.save();
      canvas.translate(x * scale, y * scale);
      canvas.scale(flameScale);
      
      // Draw flame as a small circle/dot
      // Stroke width makes it a dot.
      // h.01 is basically a dot.
      canvas.drawLine(Offset(0, 0), Offset(0.01 * scale, 0), paint);
      
      canvas.restore();
    }
    
    drawFlame(7, 4, 0.0);
    drawFlame(12, 4, 0.33);
    drawFlame(17, 4, 0.66);
  }

  @override
  bool shouldRepaint(CakePainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
