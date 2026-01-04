import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Trash Icon - Lid opens
class TrashIcon extends AnimatedSVGIcon {
  const TrashIcon({
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
  String get animationDescription => "Trash lid opens";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return TrashPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

/// Painter for Trash icon
class TrashPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  TrashPainter({
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

    // Animation - lid lifts up and tilts
    final oscillation = 4 * animationValue * (1 - animationValue);
    final lidLift = oscillation * 2.0;
    final lidTilt = oscillation * 0.2;

    // Trash body: M19 6v14a2 2 0 0 1-2 2H7a2 2 0 0 1-2-2V6
    final bodyPath = Path();
    bodyPath.moveTo(19 * scale, 6 * scale);
    bodyPath.lineTo(19 * scale, 20 * scale);
    bodyPath.arcToPoint(
      Offset(17 * scale, 22 * scale),
      radius: Radius.circular(2 * scale),
      clockwise: true,
    );
    bodyPath.lineTo(7 * scale, 22 * scale);
    bodyPath.arcToPoint(
      Offset(5 * scale, 20 * scale),
      radius: Radius.circular(2 * scale),
      clockwise: true,
    );
    bodyPath.lineTo(5 * scale, 6 * scale);
    canvas.drawPath(bodyPath, paint);

    // Lid and handle together (animated)
    // Pivot point at left edge of lid
    canvas.save();
    canvas.translate(3 * scale, 6 * scale);
    canvas.rotate(-lidTilt);
    canvas.translate(0, -lidLift);

    // Lid: M3 6h18 (now relative to pivot)
    canvas.drawLine(
      Offset.zero,
      Offset(18 * scale, 0),
      paint,
    );

    // Handle: M8 6V4a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2v2 (relative to lid)
    final handlePath = Path();
    handlePath.moveTo(5 * scale, 0); // 8-3=5
    handlePath.lineTo(5 * scale, -2 * scale);
    handlePath.arcToPoint(
      Offset(7 * scale, -4 * scale),
      radius: Radius.circular(2 * scale),
      clockwise: true,
    );
    handlePath.lineTo(11 * scale, -4 * scale);
    handlePath.arcToPoint(
      Offset(13 * scale, -2 * scale),
      radius: Radius.circular(2 * scale),
      clockwise: true,
    );
    handlePath.lineTo(13 * scale, 0);
    canvas.drawPath(handlePath, paint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(TrashPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
