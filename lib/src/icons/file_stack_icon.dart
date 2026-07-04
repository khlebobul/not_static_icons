import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated File Stack Icon - stack lifts
class FileStackIcon extends AnimatedSVGIcon {
  const FileStackIcon({
    super.key,
    super.size = 40.0,
    super.color,
    super.hoverColor,
    super.animationDuration = const Duration(milliseconds: 650),
    super.strokeWidth = 2.0,
    super.reverseOnExit = false,
    super.enableTouchInteraction = true,
    super.infiniteLoop = false,
    super.onTap,
    super.interactive,
    super.controller,
  });

  @override
  String get animationDescription => "stack lifts";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return FileStackPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

class FileStackPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  FileStackPainter({
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
    final path0 = Path();
    path0.moveTo(11 * scale, 21 * scale);
    path0.arcToPoint(Offset(10 * scale, 22 * scale),
        radius: Radius.circular(1 * scale));
    path0.lineTo(4 * scale, 22 * scale);
    path0.arcToPoint(Offset(3 * scale, 21 * scale),
        radius: Radius.circular(1 * scale));
    path0.lineTo(3 * scale, 13 * scale);
    path0.arcToPoint(Offset(4 * scale, 12 * scale),
        radius: Radius.circular(1 * scale));
    canvas.drawPath(path0, paint);
    final path1 = Path();
    path1.moveTo(16 * scale, 16 * scale);
    path1.arcToPoint(Offset(15 * scale, 17 * scale),
        radius: Radius.circular(1 * scale));
    path1.lineTo(9 * scale, 17 * scale);
    path1.arcToPoint(Offset(8 * scale, 16 * scale),
        radius: Radius.circular(1 * scale));
    path1.lineTo(8 * scale, 8 * scale);
    path1.arcToPoint(Offset(9 * scale, 7 * scale),
        radius: Radius.circular(1 * scale));
    canvas.drawPath(path1, paint);
    final pulse = 4 * animationValue * (1 - animationValue);
    canvas.save();
    canvas.translate(0, -pulse * 1.0 * scale);
    final path2 = Path();
    path2.moveTo(21 * scale, 6 * scale);
    path2.arcToPoint(Offset(20.414 * scale, 4.586 * scale),
        radius: Radius.circular(2 * scale), clockwise: false);
    path2.lineTo(18.414 * scale, 2.586 * scale);
    path2.arcToPoint(Offset(17 * scale, 2 * scale),
        radius: Radius.circular(2 * scale), clockwise: false);
    path2.lineTo(14 * scale, 2 * scale);
    path2.arcToPoint(Offset(13 * scale, 3 * scale),
        radius: Radius.circular(1 * scale), clockwise: false);
    path2.lineTo(13 * scale, 11 * scale);
    path2.arcToPoint(Offset(14 * scale, 12 * scale),
        radius: Radius.circular(1 * scale), clockwise: false);
    path2.lineTo(20 * scale, 12 * scale);
    path2.arcToPoint(Offset(21 * scale, 11 * scale),
        radius: Radius.circular(1 * scale), clockwise: false);
    path2.close();
    canvas.drawPath(path2, paint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(FileStackPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
