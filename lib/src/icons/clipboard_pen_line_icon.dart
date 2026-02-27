import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Clipboard Pen Line Icon - Pen writes
class ClipboardPenLineIcon extends AnimatedSVGIcon {
  const ClipboardPenLineIcon({
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
    return ClipboardPenLinePainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

class ClipboardPenLinePainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  ClipboardPenLinePainter({
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
    boardPath.arcToPoint(Offset(4 * scale, 6 * scale),
        radius: Radius.circular(2 * scale), clockwise: false);
    boardPath.lineTo(4 * scale, 20 * scale);
    boardPath.arcToPoint(Offset(6 * scale, 22 * scale),
        radius: Radius.circular(2 * scale), clockwise: false);
    boardPath.lineTo(18 * scale, 22 * scale);
    boardPath.arcToPoint(Offset(20 * scale, 20 * scale),
        radius: Radius.circular(2 * scale), clockwise: false);
    boardPath.lineTo(20 * scale, 19.5 * scale);
    canvas.drawPath(boardPath, paint);

    final topPath = Path();
    topPath.moveTo(16 * scale, 4 * scale);
    topPath.lineTo(18 * scale, 4 * scale);
    topPath.arcToPoint(Offset(19.73 * scale, 5 * scale),
        radius: Radius.circular(2 * scale), clockwise: true);
    canvas.drawPath(topPath, paint);

    canvas.drawLine(
        Offset(8 * scale, 18 * scale), Offset(9 * scale, 18 * scale), paint);

    // Pen animation - pen tilts
    final oscillation = 4 * animationValue * (1 - animationValue);
    final tiltAngle = oscillation * 0.15;

    canvas.save();
    canvas.translate(17 * scale, 14 * scale);
    canvas.rotate(tiltAngle);
    canvas.translate(-17 * scale, -14 * scale);

    // Pen (simplified)
    final penPath = Path();
    penPath.moveTo(21.378 * scale, 12.626 * scale);
    penPath.arcToPoint(Offset(18.374 * scale, 9.622 * scale),
        radius: Radius.circular(1 * scale), clockwise: false, largeArc: true);
    penPath.lineTo(14.364 * scale, 13.634 * scale);
    penPath.cubicTo(14.1 * scale, 13.9 * scale, 13.9 * scale, 14.2 * scale,
        13.858 * scale, 14.488 * scale);
    penPath.lineTo(13.021 * scale, 17.358 * scale);
    penPath.arcToPoint(Offset(13.641 * scale, 17.978 * scale),
        radius: Radius.circular(0.5 * scale), clockwise: true);
    penPath.lineTo(16.511 * scale, 17.141 * scale);
    penPath.cubicTo(16.8 * scale, 17.1 * scale, 17.1 * scale, 16.9 * scale,
        17.365 * scale, 16.635 * scale);
    penPath.close();
    canvas.drawPath(penPath, paint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(ClipboardPenLinePainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
