import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Contact Icon - Card bounces
class ContactIcon extends AnimatedSVGIcon {
  const ContactIcon({
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
    return ContactPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

class ContactPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  ContactPainter({
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

    // Avatar circle: cx="12" cy="11" r="3"
    canvas.drawCircle(
      Offset(12 * scale, 11 * scale),
      3 * scale,
      paint,
    );

    // Name area: M7 22v-2a2 2 0 0 1 2-2h6a2 2 0 0 1 2 2v2
    final namePath = Path();
    namePath.moveTo(7 * scale, 22 * scale);
    namePath.lineTo(7 * scale, 20 * scale);
    namePath.arcToPoint(
      Offset(9 * scale, 18 * scale),
      radius: Radius.circular(2 * scale),
      clockwise: true,
    );
    namePath.lineTo(15 * scale, 18 * scale);
    namePath.arcToPoint(
      Offset(17 * scale, 20 * scale),
      radius: Radius.circular(2 * scale),
      clockwise: true,
    );
    namePath.lineTo(17 * scale, 22 * scale);
    canvas.drawPath(namePath, paint);
  }

  @override
  bool shouldRepaint(ContactPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
