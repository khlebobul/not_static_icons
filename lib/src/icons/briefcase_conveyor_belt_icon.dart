import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Briefcase Conveyor Belt Icon - Briefcase bounces on belt
class BriefcaseConveyorBeltIcon extends AnimatedSVGIcon {
  const BriefcaseConveyorBeltIcon({
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
  String get animationDescription => "Briefcase bounces on conveyor belt";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    final oscillation = 2 * animationValue * (1 - animationValue);
    return BriefcaseConveyorBeltPainter(
      color: color,
      bounceOffset: oscillation * 2,
      strokeWidth: strokeWidth,
    );
  }
}

class BriefcaseConveyorBeltPainter extends CustomPainter {
  final Color color;
  final double bounceOffset;
  final double strokeWidth;

  BriefcaseConveyorBeltPainter({
    required this.color,
    required this.bounceOffset,
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

    // Briefcase (Body + Handle) - Bouncing
    // Handle: M8 16V4a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2v12

    final handlePath = Path();
    handlePath.moveTo(8 * scale, (16 - bounceOffset) * scale);
    handlePath.lineTo(8 * scale, (4 - bounceOffset) * scale);
    handlePath.arcToPoint(
      Offset(10 * scale, (2 - bounceOffset) * scale),
      radius: Radius.circular(2 * scale),
      clockwise: true, // sweep 1
    );
    handlePath.lineTo(14 * scale, (2 - bounceOffset) * scale);
    handlePath.arcToPoint(
      Offset(16 * scale, (4 - bounceOffset) * scale),
      radius: Radius.circular(2 * scale),
      clockwise: true, // sweep 1
    );
    handlePath.lineTo(16 * scale, (16 - bounceOffset) * scale);
    canvas.drawPath(handlePath, paint);

    // Body: rect x="4" y="6" width="16" height="10" rx="2"
    final rect = RRect.fromRectAndRadius(
      Rect.fromLTWH(
          4 * scale, (6 - bounceOffset) * scale, 16 * scale, 10 * scale),
      Radius.circular(2 * scale),
    );
    canvas.drawRRect(rect, paint);

    // Conveyor Belt - Static
    // M10 20v2
    canvas.drawLine(
        Offset(10 * scale, 20 * scale), Offset(10 * scale, 22 * scale), paint);
    // M14 20v2
    canvas.drawLine(
        Offset(14 * scale, 20 * scale), Offset(14 * scale, 22 * scale), paint);
    // M18 20v2
    canvas.drawLine(
        Offset(18 * scale, 20 * scale), Offset(18 * scale, 22 * scale), paint);
    // M21 20H3 -> Line from 21,20 to 3,20
    canvas.drawLine(
        Offset(21 * scale, 20 * scale), Offset(3 * scale, 20 * scale), paint);
    // M6 20v2
    canvas.drawLine(
        Offset(6 * scale, 20 * scale), Offset(6 * scale, 22 * scale), paint);
  }

  @override
  bool shouldRepaint(BriefcaseConveyorBeltPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.bounceOffset != bounceOffset ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
