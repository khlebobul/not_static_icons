import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';
import 'dart:math' as math;

/// Animated Bluetooth Icon - simple pulse animation
class BluetoothIcon extends AnimatedSVGIcon {
  const BluetoothIcon({
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
  String get animationDescription => 'Bluetooth: simple pulse animation';

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) =>
      _BluetoothPainter(
        color: color,
        animationValue: animationValue,
        strokeWidth: strokeWidth,
      );
}

class _BluetoothPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  _BluetoothPainter({
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

    // Draw complete bluetooth icon with pulse animation
    _drawBluetoothWithPulse(canvas, paint, scale);
  }

  void _drawBluetoothWithPulse(Canvas canvas, Paint paint, double scale) {
    final progress = animationValue;

    // Pulse effect - subtle scaling
    final pulseScale = 1.0 + math.sin(progress * math.pi * 2) * 0.1;

    canvas.save();
    canvas.scale(pulseScale);

    // Draw main bluetooth symbol: m7 7 10 10-5 5V2l5 5L7 17
    final bluetoothPath = Path();

    // Move to starting point (7, 7)
    bluetoothPath.moveTo(7 * scale / pulseScale, 7 * scale / pulseScale);

    // Line to (17, 17) - "10 10" means move 10 right, 10 down
    bluetoothPath.lineTo(17 * scale / pulseScale, 17 * scale / pulseScale);

    // Line to (12, 22) - "-5 5" means move 5 left, 5 down
    bluetoothPath.lineTo(12 * scale / pulseScale, 22 * scale / pulseScale);

    // Vertical line to (12, 2) - "V2" means vertical to y=2
    bluetoothPath.lineTo(12 * scale / pulseScale, 2 * scale / pulseScale);

    // Line to (17, 7) - "l5 5" means move 5 right, 5 down relative
    bluetoothPath.lineTo(17 * scale / pulseScale, 7 * scale / pulseScale);

    // Line to (7, 17) - "L7 17" means line to absolute position
    bluetoothPath.lineTo(7 * scale / pulseScale, 17 * scale / pulseScale);

    // Apply alpha pulse for additional effect
    final alphaPulse = 0.7 + 0.3 * math.sin(progress * math.pi * 2);
    final pulsePaint = Paint()
      ..color = color.withValues(alpha: alphaPulse)
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..style = PaintingStyle.stroke;

    canvas.drawPath(bluetoothPath, pulsePaint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(_BluetoothPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
