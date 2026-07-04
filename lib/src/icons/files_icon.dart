import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Files Icon - front file slides over stack
class FilesIcon extends AnimatedSVGIcon {
  const FilesIcon({
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
  String get animationDescription => "Files fan apart";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return FilesPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

class FilesPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  FilesPainter({
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
    path0.moveTo(15 * scale, 2 * scale);
    path0.lineTo(11 * scale, 2 * scale);
    path0.arcToPoint(Offset(9 * scale, 4 * scale),
        radius: Radius.circular(2 * scale), clockwise: false);
    path0.lineTo(9 * scale, 15 * scale);
    path0.arcToPoint(Offset(11 * scale, 17 * scale),
        radius: Radius.circular(2 * scale), clockwise: false);
    path0.lineTo(19 * scale, 17 * scale);
    path0.arcToPoint(Offset(21 * scale, 15 * scale),
        radius: Radius.circular(2 * scale), clockwise: false);
    path0.lineTo(21 * scale, 8 * scale);
    canvas.drawPath(path0, paint);
    final path1 = Path();
    path1.moveTo(16.706 * scale, 2.706 * scale);
    path1.arcToPoint(Offset(15 * scale, 2 * scale),
        radius: Radius.circular(2.4 * scale), clockwise: false);
    path1.lineTo(15 * scale, 7 * scale);
    path1.arcToPoint(Offset(16 * scale, 8 * scale),
        radius: Radius.circular(1 * scale), clockwise: false);
    path1.lineTo(21 * scale, 8 * scale);
    path1.arcToPoint(Offset(20.294 * scale, 6.294 * scale),
        radius: Radius.circular(2.4 * scale), clockwise: false);
    path1.close();
    canvas.drawPath(path1, paint);
    final pulse = 4 * animationValue * (1 - animationValue);
    canvas.save();
    canvas.translate(-pulse * .8 * scale, pulse * .6 * scale);
    final path2 = Path();
    path2.moveTo(5 * scale, 7 * scale);
    path2.arcToPoint(Offset(3 * scale, 9 * scale),
        radius: Radius.circular(2 * scale), clockwise: false);
    path2.lineTo(3 * scale, 20 * scale);
    path2.arcToPoint(Offset(5 * scale, 22 * scale),
        radius: Radius.circular(2 * scale), clockwise: false);
    path2.lineTo(13 * scale, 22 * scale);
    path2.arcToPoint(Offset(14.732 * scale, 21 * scale),
        radius: Radius.circular(2 * scale), clockwise: false);
    canvas.drawPath(path2, paint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(FilesPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
