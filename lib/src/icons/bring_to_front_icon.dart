import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Bring To Front Icon - Center element pulses forward
class BringToFrontIcon extends AnimatedSVGIcon {
  const BringToFrontIcon({
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
  String get animationDescription => "Center element pulses forward";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    final oscillation = 2 * animationValue * (1 - animationValue);
    return BringToFrontPainter(
      color: color,
      scaleValue: oscillation * 0.2, // Scale up by 20%
      strokeWidth: strokeWidth,
    );
  }
}

class BringToFrontPainter extends CustomPainter {
  final Color color;
  final double scaleValue;
  final double strokeWidth;

  BringToFrontPainter({
    required this.color,
    required this.scaleValue,
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

    // Background elements (Top-Left)
    // M4 10a2 2 0 0 1-2-2V4a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2
    final pathTL = Path();
    pathTL.moveTo(4 * scale, 10 * scale);
    pathTL.arcToPoint(
      Offset(2 * scale, 8 * scale),
      radius: Radius.circular(2 * scale),
      clockwise: true, // sweep 1
    );
    pathTL.lineTo(2 * scale, 4 * scale);
    pathTL.arcToPoint(
      Offset(4 * scale, 2 * scale),
      radius: Radius.circular(2 * scale),
      clockwise: true, // sweep 1
    );
    pathTL.lineTo(8 * scale, 2 * scale);
    pathTL.arcToPoint(
      Offset(10 * scale, 4 * scale),
      radius: Radius.circular(2 * scale),
      clockwise: true, // sweep 1
    );
    canvas.drawPath(pathTL, paint);

    // Background elements (Bottom-Right)
    // M14 20a2 2 0 0 0 2 2h4a2 2 0 0 0 2-2v-4a2 2 0 0 0-2-2
    final pathBR = Path();
    pathBR.moveTo(14 * scale, 20 * scale);
    pathBR.arcToPoint(
      Offset(16 * scale, 22 * scale),
      radius: Radius.circular(2 * scale),
      clockwise: false, // sweep 0
    );
    pathBR.lineTo(20 * scale, 22 * scale);
    pathBR.arcToPoint(
      Offset(22 * scale, 20 * scale),
      radius: Radius.circular(2 * scale),
      clockwise: false, // sweep 0
    );
    pathBR.lineTo(22 * scale, 16 * scale);
    pathBR.arcToPoint(
      Offset(20 * scale, 14 * scale),
      radius: Radius.circular(2 * scale),
      clockwise: false, // sweep 0
    );
    canvas.drawPath(pathBR, paint);

    // Center Element (Animated)
    // rect x="8" y="8" width="8" height="8" rx="2"
    // Center of rect is 12, 12
    canvas.save();
    canvas.translate(12 * scale, 12 * scale);
    canvas.scale(1.0 + scaleValue);
    canvas.translate(-12 * scale, -12 * scale);

    final rect = RRect.fromRectAndRadius(
      Rect.fromLTWH(8 * scale, 8 * scale, 8 * scale, 8 * scale),
      Radius.circular(2 * scale),
    );

    canvas.drawRRect(rect, paint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(BringToFrontPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.scaleValue != scaleValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
