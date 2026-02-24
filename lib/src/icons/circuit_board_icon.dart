import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Circuit Board Icon - Circuit pulses
class CircuitBoardIcon extends AnimatedSVGIcon {
  const CircuitBoardIcon({
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
  String get animationDescription => "Circuit pulses";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return CircuitBoardPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

class CircuitBoardPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  CircuitBoardPainter({
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

    // Animation - circuits pulse
    final oscillation = 4 * animationValue * (1 - animationValue);
    final pulseScale = 1.0 + oscillation * 0.15;

    // Board rectangle: width="18" height="18" x="3" y="3" rx="2"
    final boardRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(3 * scale, 3 * scale, 18 * scale, 18 * scale),
      Radius.circular(2 * scale),
    );
    canvas.drawRRect(boardRect, paint);

    // Top circuit path: M11 9h4a2 2 0 0 0 2-2V3
    final topCircuit = Path();
    topCircuit.moveTo(11 * scale, 9 * scale);
    topCircuit.lineTo(15 * scale, 9 * scale);
    topCircuit.arcToPoint(
      Offset(17 * scale, 7 * scale),
      radius: Radius.circular(2 * scale),
      clockwise: false,
    );
    topCircuit.lineTo(17 * scale, 3 * scale);
    canvas.drawPath(topCircuit, paint);

    // Top left circle with pulse: cx="9" cy="9" r="2"
    canvas.save();
    canvas.translate(9 * scale, 9 * scale);
    canvas.scale(pulseScale);
    canvas.translate(-9 * scale, -9 * scale);
    canvas.drawCircle(Offset(9 * scale, 9 * scale), 2 * scale, paint);
    canvas.restore();

    // Bottom circuit path: M7 21v-4a2 2 0 0 1 2-2h4
    final bottomCircuit = Path();
    bottomCircuit.moveTo(7 * scale, 21 * scale);
    bottomCircuit.lineTo(7 * scale, 17 * scale);
    bottomCircuit.arcToPoint(
      Offset(9 * scale, 15 * scale),
      radius: Radius.circular(2 * scale),
      clockwise: true,
    );
    bottomCircuit.lineTo(13 * scale, 15 * scale);
    canvas.drawPath(bottomCircuit, paint);

    // Bottom right circle with pulse: cx="15" cy="15" r="2"
    canvas.save();
    canvas.translate(15 * scale, 15 * scale);
    canvas.scale(pulseScale);
    canvas.translate(-15 * scale, -15 * scale);
    canvas.drawCircle(Offset(15 * scale, 15 * scale), 2 * scale, paint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(CircuitBoardPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
