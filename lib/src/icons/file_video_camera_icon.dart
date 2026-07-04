import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated File Video Camera Icon - camera records
class FileVideoCameraIcon extends AnimatedSVGIcon {
  const FileVideoCameraIcon({
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
  String get animationDescription => "camera records";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return FileVideoCameraPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

class FileVideoCameraPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  FileVideoCameraPainter({
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
    path0.moveTo(4 * scale, 12 * scale);
    path0.lineTo(4 * scale, 4 * scale);
    path0.arcToPoint(Offset(6 * scale, 2 * scale),
        radius: Radius.circular(2 * scale));
    path0.lineTo(14 * scale, 2 * scale);
    path0.arcToPoint(Offset(15.706 * scale, 2.706 * scale),
        radius: Radius.circular(2.4 * scale));
    path0.lineTo(19.294 * scale, 6.294 * scale);
    path0.arcToPoint(Offset(20 * scale, 8 * scale),
        radius: Radius.circular(2.4 * scale));
    path0.lineTo(20 * scale, 20 * scale);
    path0.arcToPoint(Offset(18 * scale, 22 * scale),
        radius: Radius.circular(2 * scale));
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
    final center = Offset(8.5 * scale, 19 * scale);
    canvas.translate(center.dx, center.dy);
    canvas.rotate(-pulse * .12);
    canvas.translate(-center.dx, -center.dy);
    final path2 = Path();
    path2.moveTo(10 * scale, 17.843 * scale);
    path2.lineTo(13.033 * scale, 16.088 * scale);
    path2.arcToPoint(Offset(14 * scale, 16.648 * scale),
        radius: Radius.circular(0.64 * scale));
    path2.lineTo(14 * scale, 21.352 * scale);
    path2.arcToPoint(Offset(13.033 * scale, 21.912 * scale),
        radius: Radius.circular(0.65 * scale));
    path2.lineTo(10 * scale, 20.157 * scale);
    canvas.drawPath(path2, paint);
    canvas.drawRRect(
        RRect.fromRectAndRadius(
            Rect.fromLTWH(3 * scale, 16 * scale, 7 * scale, 6 * scale),
            Radius.elliptical(1 * scale, 1 * scale)),
        paint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(FileVideoCameraPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
