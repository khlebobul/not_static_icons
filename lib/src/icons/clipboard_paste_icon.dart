import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Clipboard Paste Icon - Arrow moves
class ClipboardPasteIcon extends AnimatedSVGIcon {
  const ClipboardPasteIcon({
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
    return ClipboardPastePainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

class ClipboardPastePainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  ClipboardPastePainter({
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

    final clipRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(8 * scale, 2 * scale, 8 * scale, 4 * scale),
      Radius.circular(1 * scale),
    );
    canvas.drawRRect(clipRect, paint);

    final boardPath = Path();
    boardPath.moveTo(8 * scale, 4 * scale);
    boardPath.lineTo(6 * scale, 4 * scale);
    boardPath.arcToPoint(Offset(4 * scale, 6 * scale), radius: Radius.circular(2 * scale), clockwise: false);
    boardPath.lineTo(4 * scale, 20 * scale);
    boardPath.arcToPoint(Offset(6 * scale, 22 * scale), radius: Radius.circular(2 * scale), clockwise: false);
    boardPath.lineTo(18 * scale, 22 * scale);
    boardPath.arcToPoint(Offset(19.793 * scale, 20.887 * scale), radius: Radius.circular(2 * scale), clockwise: false);
    canvas.drawPath(boardPath, paint);

    final topPath = Path();
    topPath.moveTo(16 * scale, 4 * scale);
    topPath.lineTo(18 * scale, 4 * scale);
    topPath.arcToPoint(Offset(20 * scale, 6 * scale), radius: Radius.circular(2 * scale), clockwise: true);
    topPath.lineTo(20 * scale, 7.344 * scale);
    canvas.drawPath(topPath, paint);

    final oscillation = 4 * animationValue * (1 - animationValue);
    final arrowOffset = oscillation * 2.0;

    canvas.save();
    canvas.translate(arrowOffset * scale, 0);

    canvas.drawLine(Offset(11 * scale, 14 * scale), Offset(21 * scale, 14 * scale), paint);

    final arrowHead = Path();
    arrowHead.moveTo(17 * scale, 18 * scale);
    arrowHead.lineTo(21 * scale, 14 * scale);
    arrowHead.lineTo(17 * scale, 10 * scale);
    canvas.drawPath(arrowHead, paint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(ClipboardPastePainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
