import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Shark Icon - Shark swims
class SharkIcon extends AnimatedSVGIcon {
  const SharkIcon({
    super.key,
    super.size = 40.0,
    super.color,
    super.hoverColor,
    super.animationDuration = const Duration(milliseconds: 800),
    super.strokeWidth = 2.0,
    super.reverseOnExit = false,
    super.enableTouchInteraction = true,
    super.infiniteLoop = false,
    super.onTap,
    super.interactive,
    super.controller,
  });

  @override
  String get animationDescription => "Shark swims";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return SharkPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

class SharkPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  SharkPainter({
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

    // Animation - swimming motion with tail wag
    final tailWag = math.sin(animationValue * math.pi * 2) * 1.5 * scale;
    final bodyWave = math.sin(animationValue * math.pi * 2) * 0.5 * scale;
    final verticalBob = math.sin(animationValue * math.pi * 4) * 0.3 * scale;

    canvas.save();
    canvas.translate(0, verticalBob);

    // Main body path: M3.6 15a9.07 9.07 0 0 0 11.7 5.3S19 22 22 22c0 0-1-3-3-4.5 1.1-1.5 1.9-3.3 2-5.3l-8 4.6a1.94 1.94 0 1 1-2-3.4l6-3.5s5-2.8 5-6.8c0-.6-.4-1-1-1h-9c-1.8 0-3.4.5-4.8 1.5C5.7 2.5 3.9 2 2 2c0 0 1.4 2.1 2.3 4.5A10.63 10.63 0 0 0 3.1 13
    final bodyPath = Path();

    // M3.6 15 - Head with subtle wave motion
    bodyPath.moveTo(3.6 * scale + bodyWave * 0.3, 15 * scale);

    // a9.07 9.07 0 0 0 11.7 5.3 - relative arc to (15.3, 20.3)
    bodyPath.arcToPoint(
      Offset(15.3 * scale, 20.3 * scale),
      radius: Radius.circular(9.07 * scale),
      clockwise: false, // sweep=0
      largeArc: false,  // large-arc=0
    );

    // S19 22 22 22 - smooth cubic to (22,22) with cp2=(19,22) - TAIL with animation
    bodyPath.cubicTo(
      15.3 * scale, 20.3 * scale,       // cp1
      19 * scale, 22 * scale + tailWag, // cp2 with tail wag
      22 * scale, 22 * scale + tailWag, // end with tail wag
    );

    // c0 0-1-3-3-4.5 - relative cubic from (22,22) to (19, 17.5)
    bodyPath.cubicTo(
      22 * scale, 22 * scale + tailWag,           // cp1 with tail wag
      21 * scale, 19 * scale + tailWag * 0.5,     // cp2 with reduced wag
      19 * scale, 17.5 * scale,                    // end (back to body)
    );

    // Continuation: 1.1-1.5 1.9-3.3 2-5.3 - relative cubic from (19, 17.5) to (21, 12.2)
    bodyPath.cubicTo(
      20.1 * scale, 16 * scale,   // cp1
      20.9 * scale, 14.2 * scale, // cp2
      21 * scale, 12.2 * scale,   // end
    );

    // l-8 4.6 - relative line to (13, 16.8)
    bodyPath.lineTo(13 * scale, 16.8 * scale);

    // a1.94 1.94 0 1 1-2-3.4 - relative arc to (11, 13.4)
    bodyPath.arcToPoint(
      Offset(11 * scale, 13.4 * scale),
      radius: Radius.circular(1.94 * scale),
      clockwise: true, // sweep=1
      largeArc: true,  // large-arc=1
    );

    // l6-3.5 - relative line to (17, 9.9)
    bodyPath.lineTo(17 * scale, 9.9 * scale);

    // s5-2.8 5-6.8 - relative smooth cubic to (22, 3.1)
    bodyPath.cubicTo(
      17 * scale, 9.9 * scale,    // cp1 (reflection after line)
      22 * scale, 7.1 * scale,    // cp2 = (17+5, 9.9-2.8)
      22 * scale, 3.1 * scale,    // end = (17+5, 9.9-6.8)
    );

    // c0-.6-.4-1-1-1 - relative cubic to (21, 2.1)
    bodyPath.cubicTo(
      22 * scale, 2.5 * scale,    // cp1
      21.6 * scale, 2.1 * scale,  // cp2
      21 * scale, 2.1 * scale,    // end
    );

    // h-9 - horizontal line to (12, 2.1)
    bodyPath.lineTo(12 * scale, 2.1 * scale);

    // c-1.8 0-3.4.5-4.8 1.5 - relative cubic to (7.2, 3.6)
    bodyPath.cubicTo(
      10.2 * scale, 2.1 * scale,  // cp1
      8.6 * scale, 2.6 * scale,   // cp2
      7.2 * scale, 3.6 * scale,   // end
    );

    // C5.7 2.5 3.9 2 2 2 - absolute cubic to (2, 2)
    bodyPath.cubicTo(
      5.7 * scale, 2.5 * scale,   // cp1
      3.9 * scale, 2 * scale,     // cp2
      2 * scale, 2 * scale,       // end
    );

    // c0 0 1.4 2.1 2.3 4.5 - relative cubic to (4.3, 6.5)
    bodyPath.cubicTo(
      2 * scale, 2 * scale,       // cp1
      3.4 * scale, 4.1 * scale,   // cp2
      4.3 * scale, 6.5 * scale,   // end
    );

    // A10.63 10.63 0 0 0 3.1 13 - absolute arc to (3.1, 13)
    bodyPath.arcToPoint(
      Offset(3.1 * scale, 13 * scale),
      radius: Radius.circular(10.63 * scale),
      clockwise: false, // sweep=0
      largeArc: false,  // large-arc=0
    );

    canvas.drawPath(bodyPath, paint);

    // Eye: M13.8 7 L13 6 (implied L after M with multiple coordinates)
    canvas.drawLine(
      Offset(13.8 * scale, 7 * scale),
      Offset(13 * scale, 6 * scale),
      paint,
    );

    // Bottom detail (fin): M21.12 6h-3.5c-1.1 0-2.8.5-3.82 1L9 9.8C3 11 2 15 2 15h4
    // Slight rotation animation for the dorsal fin
    canvas.save();
    final finPivotX = 12 * scale;
    final finPivotY = 10 * scale;
    canvas.translate(finPivotX, finPivotY);
    canvas.rotate(math.sin(animationValue * math.pi * 2) * 0.03);
    canvas.translate(-finPivotX, -finPivotY);

    final bottomPath = Path();

    // M21.12 6
    bottomPath.moveTo(21.12 * scale, 6 * scale);

    // h-3.5 - horizontal line to (17.62, 6)
    bottomPath.lineTo(17.62 * scale, 6 * scale);

    // c-1.1 0-2.8.5-3.82 1 - relative cubic to (13.8, 7)
    bottomPath.cubicTo(
      16.52 * scale, 6 * scale,   // cp1
      14.82 * scale, 6.5 * scale, // cp2
      13.8 * scale, 7 * scale,    // end
    );

    // L9 9.8 - absolute line to (9, 9.8)
    bottomPath.lineTo(9 * scale, 9.8 * scale);

    // C3 11 2 15 2 15 - absolute cubic to (2, 15)
    bottomPath.cubicTo(
      3 * scale, 11 * scale,      // cp1
      2 * scale, 15 * scale,      // cp2
      2 * scale, 15 * scale,      // end
    );

    // h4 - horizontal line to (6, 15)
    bottomPath.lineTo(6 * scale, 15 * scale);

    canvas.drawPath(bottomPath, paint);
    canvas.restore(); // Restore fin rotation

    canvas.restore(); // Restore main body transform
  }

  @override
  bool shouldRepaint(SharkPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
