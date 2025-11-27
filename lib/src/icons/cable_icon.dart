import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../core/animated_svg_icon_base.dart';

/// Animated Cable Icon - Cable wiggles
class CableIcon extends AnimatedSVGIcon {
  const CableIcon({
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
  String get animationDescription => "Cable wiggles";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    // Wiggle: sin wave
    final wiggle = math.sin(animationValue * math.pi * 2) * 1.0;
    
    return CablePainter(
      color: color,
      wiggle: wiggle,
      strokeWidth: strokeWidth,
    );
  }
}

class CablePainter extends CustomPainter {
  final Color color;
  final double wiggle;
  final double strokeWidth;

  CablePainter({
    required this.color,
    required this.wiggle,
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

    // Right Plug (Static)
    // M17 19a1 1 0 0 1-1-1v-2a2 2 0 0 1 2-2h2a2 2 0 0 1 2 2v2a1 1 0 0 1-1 1z
    final rightPlug = Path();
    rightPlug.moveTo(17 * scale, 19 * scale);
    rightPlug.arcToPoint(Offset(16 * scale, 18 * scale), radius: Radius.circular(1 * scale), clockwise: true);
    rightPlug.lineTo(16 * scale, 16 * scale);
    rightPlug.arcToPoint(Offset(18 * scale, 14 * scale), radius: Radius.circular(2 * scale), clockwise: true);
    rightPlug.lineTo(20 * scale, 14 * scale);
    rightPlug.arcToPoint(Offset(22 * scale, 16 * scale), radius: Radius.circular(2 * scale), clockwise: true);
    rightPlug.lineTo(22 * scale, 18 * scale);
    rightPlug.arcToPoint(Offset(21 * scale, 19 * scale), radius: Radius.circular(1 * scale), clockwise: true);
    rightPlug.close();
    canvas.drawPath(rightPlug, paint);
    
    // M17 21v-2
    canvas.drawLine(Offset(17 * scale, 21 * scale), Offset(17 * scale, 19 * scale), paint);
    // M21 21v-2
    canvas.drawLine(Offset(21 * scale, 21 * scale), Offset(21 * scale, 19 * scale), paint);

    // Left Plug (Static)
    // M4 10a2 2 0 0 1-2-2V6a1 1 0 0 1 1-1h4a1 1 0 0 1 1 1v2a2 2 0 0 1-2 2z
    final leftPlug = Path();
    leftPlug.moveTo(4 * scale, 10 * scale);
    leftPlug.arcToPoint(Offset(2 * scale, 8 * scale), radius: Radius.circular(2 * scale), clockwise: true);
    leftPlug.lineTo(2 * scale, 6 * scale);
    leftPlug.arcToPoint(Offset(3 * scale, 5 * scale), radius: Radius.circular(1 * scale), clockwise: true);
    leftPlug.lineTo(7 * scale, 5 * scale);
    leftPlug.arcToPoint(Offset(8 * scale, 6 * scale), radius: Radius.circular(1 * scale), clockwise: true);
    leftPlug.lineTo(8 * scale, 8 * scale);
    leftPlug.arcToPoint(Offset(6 * scale, 10 * scale), radius: Radius.circular(2 * scale), clockwise: true);
    leftPlug.close();
    canvas.drawPath(leftPlug, paint);

    // M3 5V3
    canvas.drawLine(Offset(3 * scale, 5 * scale), Offset(3 * scale, 3 * scale), paint);
    // M7 5V3
    canvas.drawLine(Offset(7 * scale, 5 * scale), Offset(7 * scale, 3 * scale), paint);

    // Cable (Animated)
    // M19 14V6.5a1 1 0 0 0-7 0v11a1 1 0 0 1-7 0V10
    // We can animate the control points or just shift parts of it.
    // The cable has loops.
    // Let's shift the middle vertical part horizontally?
    
    final cablePath = Path();
    cablePath.moveTo(19 * scale, 14 * scale);
    cablePath.lineTo(19 * scale, 6.5 * scale);
    
    // a1 1 0 0 0-7 0
    // This is a 180 turn.
    // Start (19, 6.5). End (12, 6.5).
    // Radius 3.5? No, SVG says a1 1 0 0 0 -7 0.
    // Wait, radius 1? But distance is 7? That's an elliptical arc or something weird if radius is small.
    // Ah, SVG arc parameters: rx ry x-axis-rotation large-arc-flag sweep-flag x y
    // a 1 1 0 0 0 -7 0
    // If rx=1, ry=1, and distance is 7, the arc cannot connect them unless it scales?
    // Or maybe it's a typo in my reading or SVG allows this (it scales radius up).
    // Let's assume it's a big loop.
    // Actually, looking at the icon, it's likely a big loop.
    // Let's just draw a cubic bezier that looks like it.
    // Or use arcToPoint with large radius?
    
    // Let's animate the middle section (x=12) swaying left/right.
    final sway = wiggle * scale;
    
    // First loop top
    // From 19, 6.5 to 12+sway, 6.5
    // Control points high up.
    cablePath.cubicTo(
      19 * scale, 2 * scale, 
      (12 + sway) * scale, 2 * scale, 
      (12 + sway) * scale, 6.5 * scale
    );
    
    // Vertical middle
    // v11 -> to 12+sway, 17.5
    cablePath.lineTo((12 + sway) * scale, 17.5 * scale);
    
    // Second loop bottom
    // a1 1 0 0 1-7 0 -> to 5, 17.5
    // From 12+sway, 17.5 to 5, 17.5
    // Control points low down.
    cablePath.cubicTo(
      (12 + sway) * scale, 22 * scale, 
      5 * scale, 22 * scale, 
      5 * scale, 17.5 * scale
    );
    
    // V10
    cablePath.lineTo(5 * scale, 10 * scale);
    
    canvas.drawPath(cablePath, paint);
  }

  @override
  bool shouldRepaint(CablePainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.wiggle != wiggle ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
