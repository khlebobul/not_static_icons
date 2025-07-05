import 'dart:math';
import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Archive X Icon - Blinking X and opening lid
class ArchiveXIcon extends AnimatedSVGIcon {
  const ArchiveXIcon({
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
  String get animationDescription =>
      "Lid opening and X blinking for archive deletion";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return ArchiveXPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

/// Painter for Archive X icon
class ArchiveXPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  ArchiveXPainter({
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
    final openAngle = -sin(animationValue * pi) *
        0.08; // 0 to -4.6 degrees opening (upward only)

    // Calculate X blinking opacity - simple disappear and reappear
    final xOpacity = animationValue == 0
        ? 1.0 // Full opacity at rest
        : animationValue < 0.3
            ? 1.0 // Visible at start
            : animationValue < 0.7
                ? 0.0 // Hidden in middle
                : 1.0; // Visible again at end

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

    // Draw blinking X with opacity
    final xPaint = Paint()
      ..color = color.withValues(alpha: xOpacity)
      ..strokeWidth = strokeWidth // Same thickness as other elements
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..style = PaintingStyle.stroke;

    // Draw first line of X: m9.5 17 5-5
    final xLine1Path = Path();
    xLine1Path.moveTo(9.5 * scale, 17 * scale);
    xLine1Path.lineTo(14.5 * scale, 12 * scale);
    canvas.drawPath(xLine1Path, xPaint);

    // Draw second line of X: m9.5 12 5 5
    final xLine2Path = Path();
    xLine2Path.moveTo(9.5 * scale, 12 * scale);
    xLine2Path.lineTo(14.5 * scale, 17 * scale);
    canvas.drawPath(xLine2Path, xPaint);
  }

  @override
  bool shouldRepaint(ArchiveXPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
