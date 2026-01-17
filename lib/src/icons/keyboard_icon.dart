import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Keyboard Icon - Keyboard tilts like typing
class KeyboardIcon extends AnimatedSVGIcon {
  const KeyboardIcon({
    super.key,
    super.size = 40.0,
    super.color,
    super.hoverColor,
    super.animationDuration = const Duration(milliseconds: 600),
    super.strokeWidth = 2.0,
    super.reverseOnExit = false,
    super.enableTouchInteraction = true,
    super.infiniteLoop = false,
    super.onTap,
    super.interactive,
    super.controller,
  });

  @override
  String get animationDescription => "Keyboard tilts";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return KeyboardPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

/// Painter for Keyboard icon
class KeyboardPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  KeyboardPainter({
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
    final center = Offset(12 * scale, 12 * scale);

    // Animation - slight tilt left-right like typing
    final oscillation = 4 * animationValue * (1 - animationValue);
    final tilt = oscillation * 0.08 * (animationValue < 0.5 ? 1 : -1);

    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(tilt);
    canvas.translate(-center.dx, -center.dy);

    // Keyboard frame: rect width="20" height="16" x="2" y="4" rx="2"
    final framePath = Path();
    framePath.moveTo(4 * scale, 4 * scale);
    framePath.lineTo(20 * scale, 4 * scale);
    framePath.arcToPoint(
      Offset(22 * scale, 6 * scale),
      radius: Radius.circular(2 * scale),
      clockwise: true,
    );
    framePath.lineTo(22 * scale, 18 * scale);
    framePath.arcToPoint(
      Offset(20 * scale, 20 * scale),
      radius: Radius.circular(2 * scale),
      clockwise: true,
    );
    framePath.lineTo(4 * scale, 20 * scale);
    framePath.arcToPoint(
      Offset(2 * scale, 18 * scale),
      radius: Radius.circular(2 * scale),
      clockwise: true,
    );
    framePath.lineTo(2 * scale, 6 * scale);
    framePath.arcToPoint(
      Offset(4 * scale, 4 * scale),
      radius: Radius.circular(2 * scale),
      clockwise: true,
    );
    canvas.drawPath(framePath, paint);

    // Top row keys (y=8): 6, 10, 14, 18
    canvas.drawLine(
      Offset(6 * scale, 8 * scale),
      Offset(6.01 * scale, 8 * scale),
      paint,
    );
    canvas.drawLine(
      Offset(10 * scale, 8 * scale),
      Offset(10.01 * scale, 8 * scale),
      paint,
    );
    canvas.drawLine(
      Offset(14 * scale, 8 * scale),
      Offset(14.01 * scale, 8 * scale),
      paint,
    );
    canvas.drawLine(
      Offset(18 * scale, 8 * scale),
      Offset(18.01 * scale, 8 * scale),
      paint,
    );

    // Middle row keys (y=12): 8, 12, 16
    canvas.drawLine(
      Offset(8 * scale, 12 * scale),
      Offset(8.01 * scale, 12 * scale),
      paint,
    );
    canvas.drawLine(
      Offset(12 * scale, 12 * scale),
      Offset(12.01 * scale, 12 * scale),
      paint,
    );
    canvas.drawLine(
      Offset(16 * scale, 12 * scale),
      Offset(16.01 * scale, 12 * scale),
      paint,
    );

    // Space bar (y=16): M7 16h10
    canvas.drawLine(
      Offset(7 * scale, 16 * scale),
      Offset(17 * scale, 16 * scale),
      paint,
    );

    canvas.restore();
  }

  @override
  bool shouldRepaint(KeyboardPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
