import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Cannabis Off Icon - Leaves sway slightly
class CannabisOffIcon extends AnimatedSVGIcon {
  const CannabisOffIcon({
    super.key,
    super.size = 40.0,
    super.color,
    super.hoverColor,
    super.animationDuration = const Duration(milliseconds: 600),
    super.strokeWidth = 2.0,
    super.reverseOnExit = false,
    super.enableTouchInteraction = true,
    super.infiniteLoop = false,
  });

  @override
  String get animationDescription => "Cannabis leaves sway slightly";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return CannabisOffPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

/// Painter for Cannabis Off icon
class CannabisOffPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  CannabisOffPainter({
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

    // Animation - slight sway
    final oscillation = 4 * animationValue * (1 - animationValue);
    final sway = oscillation * 0.8;

    // ========== DIAGONAL STRIKE LINE ==========
    // m2 2 20 20
    canvas.drawLine(
      Offset(2 * scale, 2 * scale),
      Offset(22 * scale, 22 * scale),
      paint,
    );

    // ========== STEM ==========
    // M12 22v-4c1.5 1.5 3.5 3 6 3 0-1.5-.5-3.5-2-5
    final stemPath = Path();
    stemPath.moveTo(12 * scale, 22 * scale);
    stemPath.lineTo(12 * scale, 18 * scale);
    canvas.drawPath(stemPath, paint);

    // Right bottom curve
    final rightBottomPath = Path();
    rightBottomPath.moveTo(12 * scale, 18 * scale);
    rightBottomPath.cubicTo(
      (13.5 + sway) * scale, 19.5 * scale,
      (15.5 + sway) * scale, 21 * scale,
      (18 + sway) * scale, 21 * scale,
    );
    rightBottomPath.cubicTo(
      (18 + sway) * scale, 19.5 * scale,
      (17.5 + sway) * scale, 17.5 * scale,
      (16 + sway) * scale, 16 * scale,
    );
    canvas.drawPath(rightBottomPath, paint);

    // ========== TOP LEAF ==========
    // M13.988 8.327C13.902 6.054 13.365 3.82 12 2a9.3 9.3 0 0 0-1.445 2.9
    final topPath = Path();
    topPath.moveTo((13.988 + sway * 0.3) * scale, 8.327 * scale);
    topPath.cubicTo(
      (13.902 + sway * 0.2) * scale, 6.054 * scale,
      (13.365 + sway * 0.1) * scale, 3.82 * scale,
      12 * scale, 2 * scale,
    );
    canvas.drawPath(topPath, paint);

    final topPath2 = Path();
    topPath2.moveTo(12 * scale, 2 * scale);
    topPath2.cubicTo(
      (11.5 - sway * 0.1) * scale, 3 * scale,
      (10.8 - sway * 0.2) * scale, 4 * scale,
      (10.555 - sway * 0.3) * scale, 4.9 * scale,
    );
    canvas.drawPath(topPath2, paint);

    // ========== RIGHT LEAF ==========
    // M17.375 11.725C18.882 10.53 21 7.841 21 6c-2.324 0-5.08 1.296-6.662 2.684
    final rightPath = Path();
    rightPath.moveTo((17.375 + sway) * scale, 11.725 * scale);
    rightPath.cubicTo(
      (18.882 + sway) * scale, 10.53 * scale,
      (21 + sway) * scale, 7.841 * scale,
      (21 + sway) * scale, 6 * scale,
    );
    rightPath.cubicTo(
      (18.676 + sway) * scale, 6 * scale,
      (15.92 + sway * 0.5) * scale, 7.296 * scale,
      (14.338 + sway * 0.3) * scale, 8.684 * scale,
    );
    canvas.drawPath(rightPath, paint);

    // ========== TOP RIGHT SMALL ==========
    // M21.024 15.378A15 15 0 0 0 22 15c-.426-1.279-2.67-2.557-4.25-2.907
    final topRightPath = Path();
    topRightPath.moveTo((21.024 + sway) * scale, 15.378 * scale);
    topRightPath.lineTo((22 + sway) * scale, 15 * scale);
    topRightPath.cubicTo(
      (21.574 + sway) * scale, 13.721 * scale,
      (19.33 + sway) * scale, 12.443 * scale,
      (17.75 + sway) * scale, 12.093 * scale,
    );
    canvas.drawPath(topRightPath, paint);

    // ========== LEFT SIDE ==========
    // M6.995 6.992C5.714 6.4 4.29 6 3 6c0 2 2.5 5 4 6-1.5 0-4.5 1.5-5 3 3.5 1.5 6 1 6 1-1.5 1.5-2 3.5-2 5 2.5 0 4.5-1.5 6-3
    final leftPath = Path();
    leftPath.moveTo((6.995 - sway) * scale, 6.992 * scale);
    leftPath.cubicTo(
      (5.714 - sway) * scale, 6.4 * scale,
      (4.29 - sway) * scale, 6 * scale,
      (3 - sway) * scale, 6 * scale,
    );
    leftPath.cubicTo(
      (3 - sway) * scale, 8 * scale,
      (5.5 - sway * 0.5) * scale, 11 * scale,
      (7 - sway * 0.3) * scale, 12 * scale,
    );
    canvas.drawPath(leftPath, paint);

    final leftPath2 = Path();
    leftPath2.moveTo((7 - sway * 0.3) * scale, 12 * scale);
    leftPath2.cubicTo(
      (5.5 - sway) * scale, 12 * scale,
      (2.5 - sway) * scale, 13.5 * scale,
      (2 - sway) * scale, 15 * scale,
    );
    leftPath2.cubicTo(
      (5.5 - sway * 0.5) * scale, 16.5 * scale,
      (8 - sway * 0.3) * scale, 16 * scale,
      (8 - sway * 0.3) * scale, 16 * scale,
    );
    canvas.drawPath(leftPath2, paint);

    final leftPath3 = Path();
    leftPath3.moveTo((8 - sway * 0.3) * scale, 16 * scale);
    leftPath3.cubicTo(
      (6.5 - sway * 0.3) * scale, 17.5 * scale,
      (6 - sway * 0.3) * scale, 19.5 * scale,
      (6 - sway * 0.3) * scale, 21 * scale,
    );
    leftPath3.cubicTo(
      (8.5 - sway * 0.2) * scale, 21 * scale,
      (10.5 - sway * 0.1) * scale, 19.5 * scale,
      12 * scale, 18 * scale,
    );
    canvas.drawPath(leftPath3, paint);
  }

  @override
  bool shouldRepaint(CannabisOffPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
