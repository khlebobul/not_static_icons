import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Clipboard Copy Icon - Arrow moves
class ClipboardCopyIcon extends AnimatedSVGIcon {
  const ClipboardCopyIcon({
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
  String get animationDescription => "Arrow moves";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return ClipboardCopyPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

class ClipboardCopyPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  ClipboardCopyPainter({
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

    // Top clip
    final clipRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(8 * scale, 2 * scale, 8 * scale, 4 * scale),
      Radius.circular(1 * scale),
    );
    canvas.drawRRect(clipRect, paint);

    // Left board: M8 4H6a2 2 0 0 0-2 2v14a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2v-2
    final leftBoard = Path();
    leftBoard.moveTo(8 * scale, 4 * scale);
    leftBoard.lineTo(6 * scale, 4 * scale);
    leftBoard.arcToPoint(Offset(4 * scale, 6 * scale),
        radius: Radius.circular(2 * scale), clockwise: false);
    leftBoard.lineTo(4 * scale, 20 * scale);
    leftBoard.arcToPoint(Offset(6 * scale, 22 * scale),
        radius: Radius.circular(2 * scale), clockwise: false);
    leftBoard.lineTo(18 * scale, 22 * scale);
    leftBoard.arcToPoint(Offset(20 * scale, 20 * scale),
        radius: Radius.circular(2 * scale), clockwise: false);
    leftBoard.lineTo(20 * scale, 18 * scale);
    canvas.drawPath(leftBoard, paint);

    // Right board top: M16 4h2a2 2 0 0 1 2 2v4
    final rightBoard = Path();
    rightBoard.moveTo(16 * scale, 4 * scale);
    rightBoard.lineTo(18 * scale, 4 * scale);
    rightBoard.arcToPoint(Offset(20 * scale, 6 * scale),
        radius: Radius.circular(2 * scale), clockwise: true);
    rightBoard.lineTo(20 * scale, 10 * scale);
    canvas.drawPath(rightBoard, paint);

    // Arrow with animation
    final oscillation = 4 * animationValue * (1 - animationValue);
    final arrowOffset = oscillation * 2.0;

    canvas.save();
    canvas.translate(-arrowOffset * scale, 0);

    // Arrow line: M21 14H11
    canvas.drawLine(
        Offset(21 * scale, 14 * scale), Offset(11 * scale, 14 * scale), paint);

    // Arrow head: m15 10-4 4 4 4
    final arrowHead = Path();
    arrowHead.moveTo(15 * scale, 10 * scale);
    arrowHead.lineTo(11 * scale, 14 * scale);
    arrowHead.lineTo(15 * scale, 18 * scale);
    canvas.drawPath(arrowHead, paint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(ClipboardCopyPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
