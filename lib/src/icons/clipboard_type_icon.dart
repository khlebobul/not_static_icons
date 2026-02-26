import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Clipboard Type Icon - Text cursor blinks
class ClipboardTypeIcon extends AnimatedSVGIcon {
  const ClipboardTypeIcon({
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
  String get animationDescription => "T letter pulses";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return ClipboardTypePainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

class ClipboardTypePainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  ClipboardTypePainter({
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

    // Draw clipboard base
    final clipRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(8 * scale, 2 * scale, 8 * scale, 4 * scale),
      Radius.circular(1 * scale),
    );
    canvas.drawRRect(clipRect, paint);

    final boardPath = Path();
    boardPath.moveTo(16 * scale, 4 * scale);
    boardPath.lineTo(18 * scale, 4 * scale);
    boardPath.arcToPoint(
      Offset(20 * scale, 6 * scale),
      radius: Radius.circular(2 * scale),
      clockwise: true,
    );
    boardPath.lineTo(20 * scale, 20 * scale);
    boardPath.arcToPoint(
      Offset(18 * scale, 22 * scale),
      radius: Radius.circular(2 * scale),
      clockwise: true,
    );
    boardPath.lineTo(6 * scale, 22 * scale);
    boardPath.arcToPoint(
      Offset(4 * scale, 20 * scale),
      radius: Radius.circular(2 * scale),
      clockwise: true,
    );
    boardPath.lineTo(4 * scale, 6 * scale);
    boardPath.arcToPoint(
      Offset(6 * scale, 4 * scale),
      radius: Radius.circular(2 * scale),
      clockwise: true,
    );
    boardPath.lineTo(8 * scale, 4 * scale);
    canvas.drawPath(boardPath, paint);

    // T shape with animation - T pulses
    final oscillation = 4 * animationValue * (1 - animationValue);
    final tScale = 1.0 + oscillation * 0.15;

    canvas.save();
    canvas.translate(12 * scale, 14 * scale);
    canvas.scale(tScale);
    canvas.translate(-12 * scale, -14 * scale);

    // Top horizontal bar: M9 12v-1h6v1 (creates a bar from y=11 to y=12)
    final topBar = Path();
    topBar.moveTo(9 * scale, 12 * scale);
    topBar.lineTo(9 * scale, 11 * scale);
    topBar.lineTo(15 * scale, 11 * scale);
    topBar.lineTo(15 * scale, 12 * scale);
    canvas.drawPath(topBar, paint);

    // Vertical line: M12 11v6
    canvas.drawLine(Offset(12 * scale, 11 * scale), Offset(12 * scale, 17 * scale), paint);

    // Bottom horizontal line: M11 17h2
    canvas.drawLine(Offset(11 * scale, 17 * scale), Offset(13 * scale, 17 * scale), paint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(ClipboardTypePainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
