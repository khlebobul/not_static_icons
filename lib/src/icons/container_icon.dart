import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Container Icon - Container wobbles
class ContainerIcon extends AnimatedSVGIcon {
  const ContainerIcon({
    super.key,
    super.size = 40.0,
    super.color,
    super.hoverColor,
    super.animationDuration = const Duration(milliseconds: 700),
    super.strokeWidth = 2.0,
    super.reverseOnExit = false,
    super.enableTouchInteraction = true,
    super.infiniteLoop = false,
    super.onTap,
    super.interactive,
    super.controller,
  });

  @override
  String get animationDescription => "Container wobbles";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return ContainerPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

class ContainerPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  ContainerPainter({
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

    final s = size.width / 24.0;
    final center = Offset(12 * s, 12 * s);

    final oscillation = 4 * animationValue * (1 - animationValue);
    final rotation = math.sin(oscillation * math.pi) * 0.08;

    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(rotation);
    canvas.translate(-center.dx, -center.dy);

    // SVG path traced segment by segment:
    // M22 7.7 c0,-.6,-.4,-1.2,-.8,-1.5 l-6.3,-3.9
    // a1.72,1.72,0,0,0,-1.7,0 l-10.3,6
    // c-.5,.2,-.9,.8,-.9,1.4 v6.6
    // c0,.5,.4,1.2,.8,1.5 l6.3,3.9
    // a1.72,1.72,0,0,0,1.7,0 l10.3,-6
    // c.5,-.3,.9,-1,.9,-1.5 Z
    final p = Path();

    // Start at right-middle
    p.moveTo(22 * s, 7.7 * s);

    // Right-top corner curve -> (21.2, 6.2)
    p.cubicTo(
      22 * s,
      7.1 * s,
      21.6 * s,
      6.5 * s,
      21.2 * s,
      6.2 * s,
    );

    // Diagonal to top -> (14.9, 2.3)
    p.lineTo(14.9 * s, 2.3 * s);

    // Top arc -> (13.2, 2.3)
    p.arcToPoint(
      Offset(13.2 * s, 2.3 * s),
      radius: Radius.circular(1.72 * s),
      clockwise: false,
    );

    // Diagonal to left -> (2.9, 8.3)
    p.lineTo(2.9 * s, 8.3 * s);

    // Left-top corner curve -> (2.0, 9.7)
    p.cubicTo(
      2.4 * s,
      8.5 * s,
      2.0 * s,
      9.1 * s,
      2.0 * s,
      9.7 * s,
    );

    // Left side down -> (2.0, 16.3)
    p.lineTo(2.0 * s, 16.3 * s);

    // Left-bottom corner curve -> (2.8, 17.8)
    p.cubicTo(
      2.0 * s,
      16.8 * s,
      2.4 * s,
      17.5 * s,
      2.8 * s,
      17.8 * s,
    );

    // Diagonal to bottom -> (9.1, 21.7)
    p.lineTo(9.1 * s, 21.7 * s);

    // Bottom arc -> (10.8, 21.7)
    p.arcToPoint(
      Offset(10.8 * s, 21.7 * s),
      radius: Radius.circular(1.72 * s),
      clockwise: false,
    );

    // Diagonal to right -> (21.1, 15.7)
    p.lineTo(21.1 * s, 15.7 * s);

    // Right-bottom corner curve -> (22.0, 14.2)
    p.cubicTo(
      21.6 * s,
      15.4 * s,
      22.0 * s,
      14.7 * s,
      22.0 * s,
      14.2 * s,
    );

    // Right side up (close -> back to 22, 7.7)
    p.lineTo(22.0 * s, 7.7 * s);

    canvas.drawPath(p, paint);

    // Floor plane: from center-bottom to left, then right
    // M10 21.9V14
    canvas.drawLine(
      Offset(10 * s, 21.9 * s),
      Offset(10 * s, 14 * s),
      paint,
    );
    // L2.1 9.1
    canvas.drawLine(
      Offset(10 * s, 14 * s),
      Offset(2.1 * s, 9.1 * s),
      paint,
    );
    // m10 14 11.9-6.9
    canvas.drawLine(
      Offset(10 * s, 14 * s),
      Offset(21.9 * s, 7.1 * s),
      paint,
    );

    // Vertical stripes on right face
    // M14 19.8v-8.1
    canvas.drawLine(
      Offset(14 * s, 19.8 * s),
      Offset(14 * s, 11.7 * s),
      paint,
    );
    // M18 17.5V9.4
    canvas.drawLine(
      Offset(18 * s, 17.5 * s),
      Offset(18 * s, 9.4 * s),
      paint,
    );

    canvas.restore();
  }

  @override
  bool shouldRepaint(ContainerPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
