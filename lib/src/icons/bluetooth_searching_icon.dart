import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';
import 'dart:math' as math;

/// Animated Bluetooth Searching Icon - pulse waves animation
class BluetoothSearchingIcon extends AnimatedSVGIcon {
  const BluetoothSearchingIcon({
    super.key,
    super.size = 40.0,
    super.color,
    super.hoverColor,
    super.animationDuration = const Duration(milliseconds: 2000),
    super.strokeWidth = 2.0,
    super.reverseOnExit = false,
    super.enableTouchInteraction = true,
    super.infiniteLoop = false,
    super.resetToStartOnComplete = true,
  });

  @override
  String get animationDescription =>
      'Bluetooth Searching: pulse waves animation';

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) =>
      _BluetoothSearchingPainter(
        color: color,
        animationValue: animationValue,
        strokeWidth: strokeWidth,
      );
}

class _BluetoothSearchingPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  _BluetoothSearchingPainter({
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

    // Draw complete bluetooth searching icon
    _drawCompleteIcon(canvas, paint, scale);

    // Draw animated search waves
    _drawSearchWaves(canvas, paint, scale);
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

    // Search wave and point will be drawn with animation only
  }

  void _drawSearchWaves(Canvas canvas, Paint paint, double scale) {
    final progress = animationValue;

    // Simple blinking effect for the search arc
    final pulse = math.sin(progress * math.pi * 3) * 0.5 + 0.5;
    final alpha = 0.3 + pulse * 0.7;

    final animatedPaint = Paint()
      ..color = color.withValues(alpha: alpha)
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    // Draw animated search wave arc
    final animatedWavePath = Path();
    animatedWavePath.moveTo(20.83 * scale, 14.83 * scale);
    animatedWavePath.arcToPoint(
      Offset(20.83 * scale, 9.17 * scale),
      radius: Radius.circular(4 * scale),
      clockwise: false,
    );
    canvas.drawPath(animatedWavePath, animatedPaint);

    // Simple blinking search point
    canvas.drawCircle(
      Offset(18 * scale, 12 * scale),
      0.5 * scale,
      Paint()
        ..color = color.withValues(alpha: alpha)
        ..style = PaintingStyle.fill,
    );
  }

  @override
  bool shouldRepaint(_BluetoothSearchingPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
