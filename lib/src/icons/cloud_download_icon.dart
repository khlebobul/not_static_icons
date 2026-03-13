import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Cloud Download Icon - Arrow moves down
class CloudDownloadIcon extends AnimatedSVGIcon {
  const CloudDownloadIcon({
    super.key,
    super.size = 40.0,
    super.color,
    super.hoverColor,
    super.animationDuration = const Duration(milliseconds: 1000),
    super.strokeWidth = 2.0,
    super.reverseOnExit = false,
    super.enableTouchInteraction = true,
    super.infiniteLoop = false,
    super.onTap,
    super.interactive,
    super.controller,
  });

  @override
  String get animationDescription => "Arrow moves down";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return CloudDownloadPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

class CloudDownloadPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  CloudDownloadPainter({
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

    // Cloud: M4.393 15.269A7 7 0 1 1 15.71 8h1.79a4.5 4.5 0 0 1 2.436 8.284
    final cloudPath = Path();
    cloudPath.moveTo(4.393 * scale, 15.269 * scale);
    cloudPath.arcToPoint(
      Offset(15.71 * scale, 8 * scale),
      radius: Radius.circular(7 * scale),
      clockwise: true,
      largeArc: true,
    );
    cloudPath.lineTo(17.5 * scale, 8 * scale);
    cloudPath.arcToPoint(
      Offset(19.936 * scale, 16.284 * scale),
      radius: Radius.circular(4.5 * scale),
      clockwise: true,
      largeArc: false,
    );
    canvas.drawPath(cloudPath, paint);

    // Arrow with down movement
    final oscillation = 4 * animationValue * (1 - animationValue);
    final arrowOffset = oscillation * 2.0;

    canvas.save();
    canvas.translate(0, arrowOffset * scale);

    // Arrow line: M12 13v8
    canvas.drawLine(
        Offset(12 * scale, 13 * scale), Offset(12 * scale, 21 * scale), paint);

    // Arrow head: m-4 -4 and m12 21 4-4
    final arrowHead = Path();
    arrowHead.moveTo(8 * scale, 17 * scale);
    arrowHead.lineTo(12 * scale, 21 * scale);
    arrowHead.lineTo(16 * scale, 17 * scale);
    canvas.drawPath(arrowHead, paint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(CloudDownloadPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
