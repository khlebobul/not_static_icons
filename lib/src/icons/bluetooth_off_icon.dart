import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';
import 'dart:math' as math;

/// Animated Bluetooth Off Icon - strike-through animation
class BluetoothOffIcon extends AnimatedSVGIcon {
  const BluetoothOffIcon({
    super.key,
    super.size = 40.0,
    super.color,
    super.hoverColor,
    super.animationDuration = const Duration(milliseconds: 1600),
    super.strokeWidth = 2.0,
    super.reverseOnExit = false,
    super.enableTouchInteraction = true,
    super.infiniteLoop = false,
    super.resetToStartOnComplete = true,
  });

  @override
  String get animationDescription => 'Bluetooth Off: strike-through animation';

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) =>
      _BluetoothOffPainter(
        color: color,
        animationValue: animationValue,
        strokeWidth: strokeWidth,
      );
}

class _BluetoothOffPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  _BluetoothOffPainter({
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

    // Draw complete bluetooth off icon
    _drawCompleteIcon(canvas, paint, scale);

    // Draw animated strike-through
    _drawStrikeThroughAnimation(canvas, paint, scale);
  }

  void _drawCompleteIcon(Canvas canvas, Paint paint, double scale) {
    // Draw partial bluetooth symbol: m17 17-5 5V12l-5 5
    final path1 = Path();
    path1.moveTo(17 * scale, 17 * scale);
    path1.lineTo(12 * scale, 22 * scale); // -5 5
    path1.lineTo(12 * scale, 12 * scale); // V12
    path1.lineTo(7 * scale, 17 * scale); // l-5 5
    canvas.drawPath(path1, paint);

    // Draw second path: M14.5 9.5 17 7l-5-5v4.5
    final path2 = Path();
    path2.moveTo(14.5 * scale, 9.5 * scale);
    path2.lineTo(17 * scale, 7 * scale);
    path2.lineTo(12 * scale, 2 * scale); // l-5-5
    path2.lineTo(12 * scale, 6.5 * scale); // v4.5
    canvas.drawPath(path2, paint);

    // Diagonal line will be drawn with animation only
  }

  void _drawStrikeThroughAnimation(Canvas canvas, Paint paint, double scale) {
    final progress = animationValue;

    // Simple blinking effect for the strike-through line
    final pulse = math.sin(progress * math.pi * 4) * 0.5 + 0.5;
    final alpha = 0.3 + pulse * 0.7;

    final animatedPaint = Paint()
        ..color = color.withValues(alpha: alpha)
      ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.round
        ..style = PaintingStyle.stroke;

    // Draw blinking diagonal line
      canvas.drawLine(
        Offset(2 * scale, 2 * scale),
        Offset(22 * scale, 22 * scale),
      animatedPaint,
      );
  }

  @override
  bool shouldRepaint(_BluetoothOffPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
