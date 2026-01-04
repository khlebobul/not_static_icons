import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Spade Icon - Pulses/scales
class SpadeIcon extends AnimatedSVGIcon {
  const SpadeIcon({
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
  String get animationDescription => "Spade pulses";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return SpadePainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

/// Painter for Spade icon
class SpadePainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  SpadePainter({
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

    // Spade shape (inverted heart with stem)
    // SVG: M2 14.499a5.5 5.5 0 0 0 9.591 3.675.6.6 0 0 1 .818.001A5.5 5.5 0 0 0 22 14.5c0-2.29-1.5-4-3-5.5l-5.492-5.312a2 2 0 0 0-3-.02L5 8.999c-1.5 1.5-3 3.2-3 5.5
    final spadePath = Path();
    spadePath.moveTo(2 * scale, 14.499 * scale);
    // Left arc going up
    spadePath.arcToPoint(
      Offset(11.591 * scale, 18.174 * scale),
      radius: Radius.circular(5.5 * scale),
      clockwise: false,
    );
    // Small arc at bottom center
    spadePath.arcToPoint(
      Offset(12.409 * scale, 18.175 * scale),
      radius: Radius.circular(0.6 * scale),
      clockwise: true,
    );
    // Right arc
    spadePath.arcToPoint(
      Offset(22 * scale, 14.5 * scale),
      radius: Radius.circular(5.5 * scale),
      clockwise: false,
    );
    // Right side up
    spadePath.cubicTo(
      22 * scale,
      12.21 * scale,
      20.5 * scale,
      10.5 * scale,
      19 * scale,
      9 * scale,
    );
    // Top right to point
    spadePath.lineTo(13.508 * scale, 3.688 * scale);
    // Top arc
    spadePath.arcToPoint(
      Offset(10.508 * scale, 3.668 * scale),
      radius: Radius.circular(2 * scale),
      clockwise: false,
    );
    // Top left
    spadePath.lineTo(5 * scale, 8.999 * scale);
    // Left side down
    spadePath.cubicTo(
      3.5 * scale,
      10.5 * scale,
      2 * scale,
      12.2 * scale,
      2 * scale,
      14.499 * scale,
    );
    canvas.drawPath(spadePath, paint);

    canvas.restore();

    // Stem: M12 18v4
    canvas.drawLine(
      Offset(12 * scale, 18 * scale),
      Offset(12 * scale, 22 * scale),
      paint,
    );
  }

  @override
  bool shouldRepaint(SpadePainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
