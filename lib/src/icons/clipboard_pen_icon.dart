import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Clipboard Pen Icon - Pen writes
class ClipboardPenIcon extends AnimatedSVGIcon {
  const ClipboardPenIcon({
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
  String get animationDescription => "Pen writes";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return ClipboardPenPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

class ClipboardPenPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  ClipboardPenPainter({
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
    boardPath.moveTo(16 * scale, 4 * scale);
    boardPath.lineTo(18 * scale, 4 * scale);
    boardPath.arcToPoint(Offset(20 * scale, 6 * scale),
        radius: Radius.circular(2 * scale), clockwise: true);
    boardPath.lineTo(20 * scale, 8 * scale);
    canvas.drawPath(boardPath, paint);

    final leftPath = Path();
    leftPath.moveTo(8 * scale, 22 * scale);
    leftPath.lineTo(6 * scale, 22 * scale);
    leftPath.arcToPoint(Offset(4 * scale, 20 * scale),
        radius: Radius.circular(2 * scale), clockwise: true);
    leftPath.lineTo(4 * scale, 6 * scale);
    leftPath.arcToPoint(Offset(6 * scale, 4 * scale),
        radius: Radius.circular(2 * scale), clockwise: true);
    leftPath.lineTo(8 * scale, 4 * scale);
    canvas.drawPath(leftPath, paint);

    // Pen animation - pen tilts
    final oscillation = 4 * animationValue * (1 - animationValue);
    final tiltAngle = oscillation * 0.15;

    canvas.save();
    canvas.translate(17 * scale, 17 * scale);
    canvas.rotate(tiltAngle);
    canvas.translate(-17 * scale, -17 * scale);

    // Pen shape (simplified)
    final penPath = Path();
    penPath.moveTo(21.34 * scale, 15.664 * scale);
    penPath.arcToPoint(Offset(18.336 * scale, 12.66 * scale),
        radius: Radius.circular(1 * scale), clockwise: false, largeArc: true);
    penPath.lineTo(13.326 * scale, 17.672 * scale);
    penPath.cubicTo(13.1 * scale, 17.9 * scale, 12.9 * scale, 18.2 * scale,
        12.82 * scale, 18.526 * scale);
    penPath.lineTo(11.983 * scale, 21.396 * scale);
    penPath.arcToPoint(Offset(12.603 * scale, 22.016 * scale),
        radius: Radius.circular(0.5 * scale), clockwise: true);
    penPath.lineTo(15.473 * scale, 21.179 * scale);
    penPath.cubicTo(15.8 * scale, 21.1 * scale, 16.1 * scale, 20.9 * scale,
        16.327 * scale, 20.673 * scale);
    penPath.close();
    canvas.drawPath(penPath, paint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(ClipboardPenPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
