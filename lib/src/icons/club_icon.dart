import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Club Icon - Pulses/scales
class ClubIcon extends AnimatedSVGIcon {
  const ClubIcon({
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
  String get animationDescription => "Club pulses";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return ClubPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

/// Painter for Club icon
class ClubPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  ClubPainter({
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
    final center = Offset(12 * scale, 11 * scale);

    // Animation - pulse scale
    final oscillation = 4 * animationValue * (1 - animationValue);
    final scaleAnim = 1.0 + oscillation * 0.1;

    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.scale(scaleAnim);
    canvas.translate(-center.dx, -center.dy);

    // Club shape - three circles forming clover
    // SVG: M17.28 9.05a5.5 5.5 0 1 0-10.56 0A5.5 5.5 0 1 0 12 17.66a5.5 5.5 0 1 0 5.28-8.6Z
    final clubPath = Path();
    clubPath.moveTo(17.28 * scale, 9.05 * scale);
    // First circle (right)
    clubPath.arcToPoint(
      Offset(6.72 * scale, 9.05 * scale),
      radius: Radius.circular(5.5 * scale),
      largeArc: true,
      clockwise: false,
    );
    // Second circle (left-bottom)
    clubPath.arcToPoint(
      Offset(12 * scale, 17.66 * scale),
      radius: Radius.circular(5.5 * scale),
      largeArc: true,
      clockwise: false,
    );
    // Third circle (right-bottom)
    clubPath.arcToPoint(
      Offset(17.28 * scale, 9.05 * scale),
      radius: Radius.circular(5.5 * scale),
      largeArc: true,
      clockwise: false,
    );
    canvas.drawPath(clubPath, paint);

    // Stem: M12 17.66L12 22
    canvas.drawLine(
      Offset(12 * scale, 17.66 * scale),
      Offset(12 * scale, 22 * scale),
      paint,
    );

    canvas.restore();
  }

  @override
  bool shouldRepaint(ClubPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
