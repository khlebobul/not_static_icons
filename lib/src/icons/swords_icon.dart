import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Swords Icon - Swords clash together
class SwordsIcon extends AnimatedSVGIcon {
  const SwordsIcon({
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
  String get animationDescription => "Swords clash together";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return SwordsPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

/// Painter for Swords icon
class SwordsPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  SwordsPainter({
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

    // Animation - swords move toward each other (clash)
    final oscillation = 4 * animationValue * (1 - animationValue);
    final clashOffset = oscillation * 1.5;

    // ========== LEFT SWORD (moves right-down) ==========
    // Main blade: polyline points="14.5 17.5 3 6 3 3 6 3 17.5 14.5"
    final leftSwordPath = Path();
    leftSwordPath.moveTo(
        (14.5 + clashOffset) * scale, (17.5 + clashOffset) * scale);
    leftSwordPath.lineTo((3 + clashOffset) * scale, (6 + clashOffset) * scale);
    leftSwordPath.lineTo((3 + clashOffset) * scale, (3 + clashOffset) * scale);
    leftSwordPath.lineTo((6 + clashOffset) * scale, (3 + clashOffset) * scale);
    leftSwordPath.lineTo(
        (17.5 + clashOffset) * scale, (14.5 + clashOffset) * scale);
    canvas.drawPath(leftSwordPath, paint);

    // Left sword guard: line x1="13" x2="19" y1="19" y2="13"
    canvas.drawLine(
      Offset((13 + clashOffset) * scale, (19 + clashOffset) * scale),
      Offset((19 + clashOffset) * scale, (13 + clashOffset) * scale),
      paint,
    );

    // Left sword handle lines
    canvas.drawLine(
      Offset((16 + clashOffset) * scale, (16 + clashOffset) * scale),
      Offset((20 + clashOffset) * scale, (20 + clashOffset) * scale),
      paint,
    );
    canvas.drawLine(
      Offset((19 + clashOffset) * scale, (21 + clashOffset) * scale),
      Offset((21 + clashOffset) * scale, (19 + clashOffset) * scale),
      paint,
    );

    // ========== RIGHT SWORD (moves left-down) ==========
    // Main blade: polyline points="14.5 6.5 18 3 21 3 21 6 17.5 9.5"
    final rightSwordPath = Path();
    rightSwordPath.moveTo(
        (14.5 - clashOffset) * scale, (6.5 + clashOffset) * scale);
    rightSwordPath.lineTo(
        (18 - clashOffset) * scale, (3 + clashOffset) * scale);
    rightSwordPath.lineTo(
        (21 - clashOffset) * scale, (3 + clashOffset) * scale);
    rightSwordPath.lineTo(
        (21 - clashOffset) * scale, (6 + clashOffset) * scale);
    rightSwordPath.lineTo(
        (17.5 - clashOffset) * scale, (9.5 + clashOffset) * scale);
    canvas.drawPath(rightSwordPath, paint);

    // Right sword guard: line x1="5" x2="9" y1="14" y2="18"
    canvas.drawLine(
      Offset((5 - clashOffset) * scale, (14 + clashOffset) * scale),
      Offset((9 - clashOffset) * scale, (18 + clashOffset) * scale),
      paint,
    );

    // Right sword handle lines
    canvas.drawLine(
      Offset((7 - clashOffset) * scale, (17 + clashOffset) * scale),
      Offset((4 - clashOffset) * scale, (20 + clashOffset) * scale),
      paint,
    );
    canvas.drawLine(
      Offset((3 - clashOffset) * scale, (19 + clashOffset) * scale),
      Offset((5 - clashOffset) * scale, (21 + clashOffset) * scale),
      paint,
    );
  }

  @override
  bool shouldRepaint(SwordsPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
