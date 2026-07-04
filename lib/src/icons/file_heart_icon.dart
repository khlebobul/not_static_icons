import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated File Heart Icon - heart beats
class FileHeartIcon extends AnimatedSVGIcon {
  const FileHeartIcon({
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
  String get animationDescription => "heart beats";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return FileHeartPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

class FileHeartPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  FileHeartPainter({
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
    path0.moveTo(13 * scale, 22 * scale);
    path0.lineTo(18 * scale, 22 * scale);
    path0.arcToPoint(Offset(20 * scale, 20 * scale),
        radius: Radius.circular(2 * scale), clockwise: false);
    path0.lineTo(20 * scale, 8 * scale);
    path0.arcToPoint(Offset(19.294 * scale, 6.294 * scale),
        radius: Radius.circular(2.4 * scale), clockwise: false);
    path0.lineTo(15.706 * scale, 2.706 * scale);
    path0.arcToPoint(Offset(14 * scale, 2 * scale),
        radius: Radius.circular(2.4 * scale), clockwise: false);
    path0.lineTo(6 * scale, 2 * scale);
    path0.arcToPoint(Offset(4 * scale, 4 * scale),
        radius: Radius.circular(2 * scale), clockwise: false);
    path0.lineTo(4 * scale, 11 * scale);
    canvas.drawPath(path0, paint);
    final path1 = Path();
    path1.moveTo(14 * scale, 2 * scale);
    path1.lineTo(14 * scale, 7 * scale);
    path1.arcToPoint(Offset(15 * scale, 8 * scale),
        radius: Radius.circular(1 * scale), clockwise: false);
    path1.lineTo(20 * scale, 8 * scale);
    canvas.drawPath(path1, paint);
    final pulse = 4 * animationValue * (1 - animationValue);
    canvas.save();
    final center = Offset(12 * scale, 15 * scale);
    canvas.translate(center.dx, center.dy);
    canvas.scale(1 + pulse * .18);
    canvas.translate(-center.dx, -center.dy);
    final path2 = Path();
    path2.moveTo(3.62 * scale, 18.8 * scale);
    path2.arcToPoint(Offset(7 * scale, 15.836 * scale),
        radius: Radius.circular(2.25 * scale), largeArc: true);
    path2.arcToPoint(Offset(10.38 * scale, 18.802 * scale),
        radius: Radius.circular(2.25 * scale), largeArc: true);
    path2.lineTo(7.754 * scale, 21.658 * scale);
    path2.arcToPoint(Offset(6.247 * scale, 21.658 * scale),
        radius: Radius.circular(1 * scale));
    path2.close();
    canvas.drawPath(path2, paint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(FileHeartPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
