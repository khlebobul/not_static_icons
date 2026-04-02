import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Contact Round Icon - Card bounces
class ContactRoundIcon extends AnimatedSVGIcon {
  const ContactRoundIcon({
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
  String get animationDescription => "Card bounces";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return ContactRoundPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

class ContactRoundPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  ContactRoundPainter({
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

    final oscillation = 4 * animationValue * (1 - animationValue);
    final bounce = oscillation * 1.5;

    // Card frame: x="3" y="4" width="18" height="18" rx="2"
    final cardRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(3 * scale, 4 * scale, 18 * scale, 18 * scale),
      Radius.circular(2 * scale),
    );
    canvas.drawRRect(cardRect, paint);

    // Tabs (animated)
    // M16 2v2
    canvas.drawLine(
      Offset(16 * scale, (2 - bounce) * scale),
      Offset(16 * scale, (4 - bounce) * scale),
      paint,
    );
    // M8 2v2
    canvas.drawLine(
      Offset(8 * scale, (2 - bounce) * scale),
      Offset(8 * scale, (4 - bounce) * scale),
      paint,
    );

    // Avatar circle: cx="12" cy="12" r="4"
    canvas.drawCircle(
      Offset(12 * scale, 12 * scale),
      4 * scale,
      paint,
    );

    // Name area arc: M17.915 22a6 6 0 0 0-12 0
    final namePath = Path();
    namePath.moveTo(17.915 * scale, 22 * scale);
    namePath.arcToPoint(
      Offset(5.915 * scale, 22 * scale),
      radius: Radius.circular(6 * scale),
      clockwise: false,
    );
    canvas.drawPath(namePath, paint);
  }

  @override
  bool shouldRepaint(ContactRoundPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
