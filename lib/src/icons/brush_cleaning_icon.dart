import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Brush Cleaning Icon - Scrubbing motion
class BrushCleaningIcon extends AnimatedSVGIcon {
  const BrushCleaningIcon({
    super.key,
    super.size = 40.0,
    super.color,
    super.hoverColor,
    super.animationDuration = const Duration(milliseconds: 600),
    super.strokeWidth = 2.0,
    super.reverseOnExit = false,
    super.enableTouchInteraction = true,
    super.infiniteLoop = false,
  });

  @override
  String get animationDescription => "Brush scrubs back and forth";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    // Scrubbing motion: 0 -> -offset -> +offset -> 0
    // Use sine wave for smooth back and forth
    // animationValue 0..1
    // We want: 0 -> -1 -> 1 -> 0 roughly

    // Let's do a simple oscillation: 0 -> max -> 0
    // Or better: center -> left -> right -> center

    double offsetX = 0;
    if (animationValue < 0.25) {
      // 0 to -3
      offsetX = -3 * (animationValue / 0.25);
    } else if (animationValue < 0.75) {
      // -3 to 3
      offsetX = -3 + 6 * ((animationValue - 0.25) / 0.5);
    } else {
      // 3 to 0
      offsetX = 3 - 3 * ((animationValue - 0.75) / 0.25);
    }

    return BrushCleaningPainter(
      color: color,
      offsetX: offsetX,
      strokeWidth: strokeWidth,
    );
  }
}

class BrushCleaningPainter extends CustomPainter {
  final Color color;
  final double offsetX;
  final double strokeWidth;

  BrushCleaningPainter({
    required this.color,
    required this.offsetX,
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

    canvas.save();
    canvas.translate(offsetX * scale, 0);

    // Handle
    // M19 13.99a1 1 0 0 0 1-1V12a2 2 0 0 0-2-2h-3a1 1 0 0 1-1-1V4a2 2 0 0 0-4 0v5a1 1 0 0 1-1 1H6a2 2 0 0 0-2 2v.99a1 1 0 0 0 1 1
    final handlePath = Path();
    handlePath.moveTo(19 * scale, 13.99 * scale);
    handlePath.arcToPoint(
      Offset(20 * scale, 12.99 * scale),
      radius: Radius.circular(1 * scale),
      clockwise: false, // sweep 0
    );
    handlePath.lineTo(20 * scale, 12 * scale);
    handlePath.arcToPoint(
      Offset(18 * scale, 10 * scale),
      radius: Radius.circular(2 * scale),
      clockwise: false, // sweep 0
    );
    handlePath.lineTo(15 * scale, 10 * scale);
    handlePath.arcToPoint(
      Offset(14 * scale, 9 * scale),
      radius: Radius.circular(1 * scale),
      clockwise: true, // sweep 1
    );
    handlePath.lineTo(14 * scale, 4 * scale);
    handlePath.arcToPoint(
      Offset(10 * scale, 4 * scale),
      radius: Radius.circular(2 * scale),
      clockwise: false, // sweep 0
    );
    handlePath.lineTo(10 * scale, 9 * scale);
    handlePath.arcToPoint(
      Offset(9 * scale, 10 * scale),
      radius: Radius.circular(1 * scale),
      clockwise: true, // sweep 1
    );
    handlePath.lineTo(6 * scale, 10 * scale);
    handlePath.arcToPoint(
      Offset(4 * scale, 12 * scale),
      radius: Radius.circular(2 * scale),
      clockwise: false, // sweep 0
    );
    handlePath.lineTo(4 * scale, 12.99 * scale);
    handlePath.arcToPoint(
      Offset(5 * scale, 13.99 * scale),
      radius: Radius.circular(1 * scale),
      clockwise: false, // sweep 0
    );
    canvas.drawPath(handlePath, paint);

    // Base
    // M5 14h14l1.973 6.767A1 1 0 0 1 20 22H4a1 1 0 0 1-.973-1.233z
    final basePath = Path();
    basePath.moveTo(5 * scale, 14 * scale);
    basePath.lineTo(19 * scale, 14 * scale);
    basePath.lineTo(20.973 * scale, 20.767 * scale);
    basePath.arcToPoint(
      Offset(20 * scale, 22 * scale),
      radius: Radius.circular(1 * scale),
      clockwise: true, // sweep 1
    );
    basePath.lineTo(4 * scale, 22 * scale);
    basePath.arcToPoint(
      Offset(3.027 * scale, 20.767 * scale),
      radius: Radius.circular(1 * scale),
      clockwise: true, // sweep 1
    );
    basePath.close();
    canvas.drawPath(basePath, paint);

    // Bristles
    // m16 22-1-4
    canvas.drawLine(
        Offset(16 * scale, 22 * scale), Offset(15 * scale, 18 * scale), paint);
    // m8 22 1-4
    canvas.drawLine(
        Offset(8 * scale, 22 * scale), Offset(9 * scale, 18 * scale), paint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(BrushCleaningPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.offsetX != offsetX ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
