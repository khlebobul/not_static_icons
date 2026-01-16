import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Repeat Icon - Arrows rotate around
class RepeatIcon extends AnimatedSVGIcon {
  const RepeatIcon({
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
  String get animationDescription => "Repeat arrows rotate";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return RepeatPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

/// Painter for Repeat icon
class RepeatPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  RepeatPainter({
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

    // Animation - rotate entire icon
    final oscillation = 4 * animationValue * (1 - animationValue);
    final rotation = oscillation * 0.3;

    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(rotation);
    canvas.translate(-center.dx, -center.dy);

    // Top arrow head: m17 2 4 4-4 4
    final topArrowPath = Path();
    topArrowPath.moveTo(17 * scale, 2 * scale);
    topArrowPath.lineTo(21 * scale, 6 * scale);
    topArrowPath.lineTo(17 * scale, 10 * scale);
    canvas.drawPath(topArrowPath, paint);

    // Top path: M3 11v-1a4 4 0 0 1 4-4h14
    final topPath = Path();
    topPath.moveTo(3 * scale, 11 * scale);
    topPath.lineTo(3 * scale, 10 * scale);
    topPath.arcToPoint(
      Offset(7 * scale, 6 * scale),
      radius: Radius.circular(4 * scale),
      clockwise: true,
    );
    topPath.lineTo(21 * scale, 6 * scale);
    canvas.drawPath(topPath, paint);

    // Bottom arrow head: m7 22-4-4 4-4
    final bottomArrowPath = Path();
    bottomArrowPath.moveTo(7 * scale, 22 * scale);
    bottomArrowPath.lineTo(3 * scale, 18 * scale);
    bottomArrowPath.lineTo(7 * scale, 14 * scale);
    canvas.drawPath(bottomArrowPath, paint);

    // Bottom path: M21 13v1a4 4 0 0 1-4 4H3
    final bottomPath = Path();
    bottomPath.moveTo(21 * scale, 13 * scale);
    bottomPath.lineTo(21 * scale, 14 * scale);
    bottomPath.arcToPoint(
      Offset(17 * scale, 18 * scale),
      radius: Radius.circular(4 * scale),
      clockwise: true,
    );
    bottomPath.lineTo(3 * scale, 18 * scale);
    canvas.drawPath(bottomPath, paint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(RepeatPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
