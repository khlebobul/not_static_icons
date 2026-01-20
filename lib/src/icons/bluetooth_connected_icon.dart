import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';
import 'dart:math' as math;

/// Animated Bluetooth Connected Icon - connection lines animation
class BluetoothConnectedIcon extends AnimatedSVGIcon {
  const BluetoothConnectedIcon({
    super.key,
    super.size = 40.0,
    super.color,
    super.hoverColor,
    super.animationDuration = const Duration(milliseconds: 1800),
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
  String get animationDescription =>
      'Bluetooth Connected: connection lines animation';

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) =>
      _BluetoothConnectedPainter(
        color: color,
        animationValue: animationValue,
        strokeWidth: strokeWidth,
      );
}

class _BluetoothConnectedPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  _BluetoothConnectedPainter({
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

    // Draw complete bluetooth connected icon
    _drawCompleteIcon(canvas, paint, scale);

    // Draw animated connection lines
    _drawConnectionAnimation(canvas, paint, scale);
  }

  void _drawCompleteIcon(Canvas canvas, Paint paint, double scale) {
    // Draw main bluetooth symbol: m7 7 10 10-5 5V2l5 5L7 17
    final bluetoothPath = Path();

    // Move to starting point (7, 7)
    bluetoothPath.moveTo(7 * scale, 7 * scale);

    // Line to (17, 17) - "10 10" means move 10 right, 10 down
    bluetoothPath.lineTo(17 * scale, 17 * scale);

    // Line to (12, 22) - "-5 5" means move 5 left, 5 down
    bluetoothPath.lineTo(12 * scale, 22 * scale);

    // Vertical line to (12, 2) - "V2" means vertical to y=2
    bluetoothPath.lineTo(12 * scale, 2 * scale);

    // Line to (17, 7) - "l5 5" means move 5 right, 5 down relative
    bluetoothPath.lineTo(17 * scale, 7 * scale);

    // Line to (7, 17) - "L7 17" means line to absolute position
    bluetoothPath.lineTo(7 * scale, 17 * scale);

    canvas.drawPath(bluetoothPath, paint);

    // Connection lines will be drawn with animation only
  }

  void _drawConnectionAnimation(Canvas canvas, Paint paint, double scale) {
    final progress = animationValue;

    // Simple blinking effect for connection lines
    final pulse = math.sin(progress * math.pi * 3) * 0.5 + 0.5;
    final alpha = 0.4 + pulse * 0.6;

    final animatedPaint = Paint()
      ..color = color.withValues(alpha: alpha)
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    // Draw animated connection lines with simple blink
    canvas.drawLine(
      Offset(3 * scale, 12 * scale),
      Offset(6 * scale, 12 * scale),
      animatedPaint,
    );

    canvas.drawLine(
      Offset(18 * scale, 12 * scale),
      Offset(21 * scale, 12 * scale),
      animatedPaint,
    );
  }

  @override
  bool shouldRepaint(_BluetoothConnectedPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
