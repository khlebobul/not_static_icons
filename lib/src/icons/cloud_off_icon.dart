import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Cloud Off Icon - Slash appears
class CloudOffIcon extends AnimatedSVGIcon {
  const CloudOffIcon({
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
  String get animationDescription => "Slash appears";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return CloudOffPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

class CloudOffPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  CloudOffPainter({
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

    // Top cloud part: M10.94 5.274A7 7 0 0 1 15.71 10h1.79a4.5 4.5 0 0 1 4.222 6.057
    final topPath = Path();
    topPath.moveTo(10.94 * scale, 5.274 * scale);
    topPath.arcToPoint(
      Offset(15.71 * scale, 10 * scale),
      radius: Radius.circular(7 * scale),
      clockwise: true,
    );
    topPath.lineTo(17.5 * scale, 10 * scale);
    topPath.arcToPoint(
      Offset(21.722 * scale, 16.057 * scale),
      radius: Radius.circular(4.5 * scale),
      clockwise: true,
    );
    canvas.drawPath(topPath, paint);

    // Bottom cloud part: M18.796 18.81A4.5 4.5 0 0 1 17.5 19H9A7 7 0 0 1 5.79 5.78
    final bottomPath = Path();
    bottomPath.moveTo(18.796 * scale, 18.81 * scale);
    bottomPath.arcToPoint(
      Offset(17.5 * scale, 19 * scale),
      radius: Radius.circular(4.5 * scale),
      clockwise: true,
    );
    bottomPath.lineTo(9 * scale, 19 * scale);
    bottomPath.arcToPoint(
      Offset(5.79 * scale, 5.78 * scale),
      radius: Radius.circular(7 * scale),
      clockwise: true,
    );
    canvas.drawPath(bottomPath, paint);

    // Slash with scale animation
    final oscillation = 4 * animationValue * (1 - animationValue);
    final slashScale = 1.0 + oscillation * 0.1;

    canvas.save();
    canvas.translate(12 * scale, 12 * scale);
    canvas.scale(slashScale);
    canvas.translate(-12 * scale, -12 * scale);

    canvas.drawLine(
        Offset(2 * scale, 2 * scale), Offset(22 * scale, 22 * scale), paint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(CloudOffPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
