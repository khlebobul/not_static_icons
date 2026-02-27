import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Clipboard Check Icon - Checkmark appears
class ClipboardCheckIcon extends AnimatedSVGIcon {
  const ClipboardCheckIcon({
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
  String get animationDescription => "Checkmark appears";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return ClipboardCheckPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

class ClipboardCheckPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  ClipboardCheckPainter({
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

    // Checkmark animation: m9 14 2 2 4-4
    final oscillation = 4 * animationValue * (1 - animationValue);
    final checkScale = 1.0 + oscillation * 0.2;

    canvas.save();
    canvas.translate(12 * scale, 14 * scale);
    canvas.scale(checkScale);
    canvas.translate(-12 * scale, -14 * scale);

    final checkPath = Path();
    checkPath.moveTo(9 * scale, 14 * scale);
    checkPath.lineTo(11 * scale, 16 * scale);
    checkPath.lineTo(15 * scale, 12 * scale);
    canvas.drawPath(checkPath, paint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(ClipboardCheckPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
