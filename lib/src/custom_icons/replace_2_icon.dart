import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Replace 2 Icon - Arrow moves down (filled rectangle variant)
class Replace2Icon extends AnimatedSVGIcon {
  const Replace2Icon({
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
  String get animationDescription => "Replace 2 arrow animates";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return Replace2Painter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

/// Painter for Replace 2 icon
class Replace2Painter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  Replace2Painter({
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

    final fillPaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final scale = size.width / 24.0;

    // Animation - arrow bounces down
    final oscillation = 4 * animationValue * (1 - animationValue);
    final arrowOffset = oscillation * 2.0;

    // Top-right dashed rectangle corners
    // M14 4a1 1 0 0 1 1-1
    final corner1 = Path();
    corner1.moveTo(14 * scale, 4 * scale);
    corner1.arcToPoint(
      Offset(15 * scale, 3 * scale),
      radius: Radius.circular(1 * scale),
      clockwise: true,
    );
    canvas.drawPath(corner1, paint);

    // M15 10a1 1 0 0 1-1-1
    final corner2 = Path();
    corner2.moveTo(15 * scale, 10 * scale);
    corner2.arcToPoint(
      Offset(14 * scale, 9 * scale),
      radius: Radius.circular(1 * scale),
      clockwise: true,
    );
    canvas.drawPath(corner2, paint);

    // M21 4a1 1 0 0 0-1-1
    final corner3 = Path();
    corner3.moveTo(21 * scale, 4 * scale);
    corner3.arcToPoint(
      Offset(20 * scale, 3 * scale),
      radius: Radius.circular(1 * scale),
      clockwise: false,
    );
    canvas.drawPath(corner3, paint);

    // M21 9a1 1 0 0 1-1 1
    final corner4 = Path();
    corner4.moveTo(21 * scale, 9 * scale);
    corner4.arcToPoint(
      Offset(20 * scale, 10 * scale),
      radius: Radius.circular(1 * scale),
      clockwise: true,
    );
    canvas.drawPath(corner4, paint);

    // Arrow head: m3 7 3 3 3-3 (animated)
    final arrowHeadPath = Path();
    arrowHeadPath.moveTo(3 * scale, (7 + arrowOffset) * scale);
    arrowHeadPath.lineTo(6 * scale, (10 + arrowOffset) * scale);
    arrowHeadPath.lineTo(9 * scale, (7 + arrowOffset) * scale);
    canvas.drawPath(arrowHeadPath, paint);

    // Arrow stem: M6 10V5a2 2 0 0 1 2-2h2 (animated)
    final arrowStemPath = Path();
    arrowStemPath.moveTo(6 * scale, (10 + arrowOffset) * scale);
    arrowStemPath.lineTo(6 * scale, 5 * scale);
    arrowStemPath.arcToPoint(
      Offset(8 * scale, 3 * scale),
      radius: Radius.circular(2 * scale),
      clockwise: true,
    );
    arrowStemPath.lineTo(10 * scale, 3 * scale);
    canvas.drawPath(arrowStemPath, paint);

    // Bottom-left FILLED rectangle: rect x="3" y="14" width="7" height="7" rx="1"
    final rectPath = Path();
    rectPath.moveTo(4 * scale, 14 * scale);
    rectPath.lineTo(9 * scale, 14 * scale);
    rectPath.arcToPoint(
      Offset(10 * scale, 15 * scale),
      radius: Radius.circular(1 * scale),
      clockwise: true,
    );
    rectPath.lineTo(10 * scale, 20 * scale);
    rectPath.arcToPoint(
      Offset(9 * scale, 21 * scale),
      radius: Radius.circular(1 * scale),
      clockwise: true,
    );
    rectPath.lineTo(4 * scale, 21 * scale);
    rectPath.arcToPoint(
      Offset(3 * scale, 20 * scale),
      radius: Radius.circular(1 * scale),
      clockwise: true,
    );
    rectPath.lineTo(3 * scale, 15 * scale);
    rectPath.arcToPoint(
      Offset(4 * scale, 14 * scale),
      radius: Radius.circular(1 * scale),
      clockwise: true,
    );
    canvas.drawPath(rectPath, fillPaint);
    canvas.drawPath(rectPath, paint);
  }

  @override
  bool shouldRepaint(Replace2Painter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
