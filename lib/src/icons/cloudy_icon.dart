import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Cloudy Icon - Clouds float
class CloudyIcon extends AnimatedSVGIcon {
  const CloudyIcon({
    super.key,
    super.size = 40.0,
    super.color,
    super.hoverColor,
    super.animationDuration = const Duration(milliseconds: 1500),
    super.strokeWidth = 2.0,
    super.reverseOnExit = false,
    super.enableTouchInteraction = true,
    super.infiniteLoop = false,
    super.onTap,
    super.interactive,
    super.controller,
  });

  @override
  String get animationDescription => "Clouds float";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return CloudyPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

class CloudyPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  CloudyPainter({
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

    // Clouds floating horizontally in opposite directions (no overlap)
    final oscillation = 4 * animationValue * (1 - animationValue);
    final hOffset1 = oscillation * 1.2;
    final hOffset2 = -oscillation * 1.0;

    // Main cloud: M17.5 12a1 1 0 1 1 0 9H9.006a7 7 0 1 1 6.702-9z
    canvas.save();
    canvas.translate(hOffset1 * scale, 0);

    final mainCloud = Path();
    mainCloud.moveTo(17.5 * scale, 12 * scale);
    mainCloud.arcToPoint(
      Offset(17.5 * scale, 21 * scale),
      radius: Radius.circular(4.5 * scale),
      clockwise: true,
      largeArc: true,
    );
    mainCloud.lineTo(9.006 * scale, 21 * scale);
    mainCloud.arcToPoint(
      Offset(15.708 * scale, 12 * scale),
      radius: Radius.circular(7 * scale),
      clockwise: true,
      largeArc: true,
    );
    mainCloud.close();
    canvas.drawPath(mainCloud, paint);

    canvas.restore();

    // Top cloud: M21.832 9A3 3 0 0 0 19 7h-2.207a5.5 5.5 0 0 0-10.72.61
    canvas.save();
    canvas.translate(hOffset2 * scale, 0);

    final topCloud = Path();
    topCloud.moveTo(21.832 * scale, 9 * scale);
    topCloud.arcToPoint(
      Offset(19 * scale, 7 * scale),
      radius: Radius.circular(3 * scale),
      clockwise: false,
    );
    topCloud.lineTo(16.793 * scale, 7 * scale);
    topCloud.arcToPoint(
      Offset(6.073 * scale, 7.61 * scale),
      radius: Radius.circular(5.5 * scale),
      clockwise: false,
    );
    canvas.drawPath(topCloud, paint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(CloudyPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
