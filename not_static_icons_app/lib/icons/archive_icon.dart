import 'dart:math';
import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Archive Icon - Opening and closing lid
class ArchiveIcon extends AnimatedSVGIcon {
  const ArchiveIcon({
    super.key,
    super.size = 40.0,
    super.color,
    super.hoverColor,
    super.animationDuration = const Duration(milliseconds: 1500),
    super.strokeWidth = 2.0,
    super.reverseOnExit = false,
    super.enableTouchInteraction = true,
    super.infiniteLoop = false,
  });

  @override
  String get animationDescription => "Opening and closing archive lid";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return ArchivePainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

/// Painter for Archive icon
class ArchivePainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  ArchivePainter({
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

    // Calculate lid opening angle - only upward opening, then closing
    final openAngle =
        -sin(animationValue * pi) *
        0.08; // 0 to -4.6 degrees opening (upward only)

    // Draw the archive box body: M4 8v11a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8
    final bodyPath = Path();
    bodyPath.moveTo(4 * scale, 8 * scale);
    bodyPath.lineTo(4 * scale, 19 * scale);
    bodyPath.cubicTo(
      4 * scale,
      20.1 * scale,
      4.9 * scale,
      21 * scale,
      6 * scale,
      21 * scale,
    );
    bodyPath.lineTo(18 * scale, 21 * scale);
    bodyPath.cubicTo(
      19.1 * scale,
      21 * scale,
      20 * scale,
      20.1 * scale,
      20 * scale,
      19 * scale,
    );
    bodyPath.lineTo(20 * scale, 8 * scale);

    canvas.drawPath(bodyPath, paint);

    // Draw the handle inside the box: M10 12h4
    final handlePath = Path();
    handlePath.moveTo(10 * scale, 12 * scale);
    handlePath.lineTo(14 * scale, 12 * scale);
    canvas.drawPath(handlePath, paint);

    // Draw the animated lid with opening effect
    canvas.save();

    // Pivot point at the back edge of the lid for opening effect
    final lidPivot = Offset(2 * scale, 3 * scale);
    canvas.translate(lidPivot.dx, lidPivot.dy);
    canvas.rotate(openAngle);
    canvas.translate(-lidPivot.dx, -lidPivot.dy);

    // Draw the lid: rect width="20" height="5" x="2" y="3" rx="1"
    final lidRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(2 * scale, 3 * scale, 20 * scale, 5 * scale),
      Radius.circular(1 * scale),
    );
    canvas.drawRRect(lidRect, paint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(ArchivePainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
