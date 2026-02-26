import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Clipboard Icon - Clipboard bounces
class ClipboardIcon extends AnimatedSVGIcon {
  const ClipboardIcon({
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
  String get animationDescription => "Clipboard bounces";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return ClipboardPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

class ClipboardPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  ClipboardPainter({
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

    // Animation - clipboard bounces
    final oscillation = 4 * animationValue * (1 - animationValue);
    final bounceOffset = oscillation * 1.5;

    canvas.save();
    canvas.translate(0, -bounceOffset * scale);

    // Top clip: width="8" height="4" x="8" y="2" rx="1" ry="1"
    final clipRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(8 * scale, 2 * scale, 8 * scale, 4 * scale),
      Radius.circular(1 * scale),
    );
    canvas.drawRRect(clipRect, paint);

    // Board: M16 4h2a2 2 0 0 1 2 2v14a2 2 0 0 1-2 2H6a2 2 0 0 1-2-2V6a2 2 0 0 1 2-2h2
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

    canvas.restore();
  }

  @override
  bool shouldRepaint(ClipboardPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
