import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Church Icon - Church bounces up
class ChurchIcon extends AnimatedSVGIcon {
  const ChurchIcon({
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
    super.interactive = true,
    super.controller,
  });

  @override
  String get animationDescription => "Church bounces";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return ChurchPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

class ChurchPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  ChurchPainter({
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

    // Animation - bounce up
    final oscillation = 4 * animationValue * (1 - animationValue);
    final bounceOffset = oscillation * -2.0;

    // Cross horizontal: M10 9h4
    canvas.drawLine(
      Offset(10 * scale, (9 + bounceOffset) * scale),
      Offset(14 * scale, (9 + bounceOffset) * scale),
      paint,
    );

    // Cross vertical: M12 7v5
    canvas.drawLine(
      Offset(12 * scale, (7 + bounceOffset) * scale),
      Offset(12 * scale, (12 + bounceOffset) * scale),
      paint,
    );

    // Door: M14 21v-3a2 2 0 0 0-4 0v3
    final doorPath = Path();
    doorPath.moveTo(14 * scale, 21 * scale);
    doorPath.lineTo(14 * scale, (18 + bounceOffset) * scale);
    doorPath.arcToPoint(
      Offset(10 * scale, (18 + bounceOffset) * scale),
      radius: Radius.circular(2 * scale),
      clockwise: false,
    );
    doorPath.lineTo(10 * scale, 21 * scale);
    canvas.drawPath(doorPath, paint);

    // Left extension: m18 9 3.52 2.147a1 1 0 0 1 .48.854V19a2 2 0 0 1-2 2H4a2 2 0 0 1-2-2v-6.999a1 1 0 0 1 .48-.854L6 9
    final extensionPath = Path();
    extensionPath.moveTo(18 * scale, (9 + bounceOffset) * scale);
    extensionPath.lineTo(21.52 * scale, (11.147 + bounceOffset) * scale);
    extensionPath.lineTo(22 * scale, (12.001 + bounceOffset) * scale);
    extensionPath.lineTo(22 * scale, 19 * scale);
    extensionPath.arcToPoint(
      Offset(20 * scale, 21 * scale),
      radius: Radius.circular(2 * scale),
      clockwise: true,
    );
    extensionPath.lineTo(4 * scale, 21 * scale);
    extensionPath.arcToPoint(
      Offset(2 * scale, 19 * scale),
      radius: Radius.circular(2 * scale),
      clockwise: true,
    );
    extensionPath.lineTo(2 * scale, (12.001 + bounceOffset) * scale);
    extensionPath.lineTo(2.48 * scale, (11.147 + bounceOffset) * scale);
    extensionPath.lineTo(6 * scale, (9 + bounceOffset) * scale);
    canvas.drawPath(extensionPath, paint);

    // Main building: M6 21V7a1 1 0 0 1 .376-.782l5-3.999a1 1 0 0 1 1.249.001l5 4A1 1 0 0 1 18 7v14
    final buildingPath = Path();
    buildingPath.moveTo(6 * scale, 21 * scale);
    buildingPath.lineTo(6 * scale, (7 + bounceOffset) * scale);
    buildingPath.lineTo(6.376 * scale, (6.218 + bounceOffset) * scale);
    buildingPath.lineTo(11.376 * scale, (2.219 + bounceOffset) * scale);
    buildingPath.lineTo(12 * scale, (2 + bounceOffset) * scale);
    buildingPath.lineTo(12.625 * scale, (2.22 + bounceOffset) * scale);
    buildingPath.lineTo(17.625 * scale, (6.22 + bounceOffset) * scale);
    buildingPath.lineTo(18 * scale, (7 + bounceOffset) * scale);
    buildingPath.lineTo(18 * scale, 21 * scale);
    canvas.drawPath(buildingPath, paint);
  }

  @override
  bool shouldRepaint(ChurchPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
