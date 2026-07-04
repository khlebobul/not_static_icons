import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated File Key Icon - key turns
class FileKeyIcon extends AnimatedSVGIcon {
  const FileKeyIcon({
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
  String get animationDescription => "key turns";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return FileKeyPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

class FileKeyPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  FileKeyPainter({
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
    path0.moveTo(14 * scale, 2 * scale);
    path0.lineTo(14 * scale, 7 * scale);
    path0.arcToPoint(Offset(15 * scale, 8 * scale),
        radius: Radius.circular(1 * scale), clockwise: false);
    path0.lineTo(20 * scale, 8 * scale);
    canvas.drawPath(path0, paint);
    final path3 = Path();
    path3.moveTo(9.65 * scale, 22 * scale);
    path3.lineTo(18 * scale, 22 * scale);
    path3.arcToPoint(Offset(20 * scale, 20 * scale),
        radius: Radius.circular(2 * scale), clockwise: false);
    path3.lineTo(20 * scale, 8 * scale);
    path3.arcToPoint(Offset(19.294 * scale, 6.294 * scale),
        radius: Radius.circular(2.4 * scale), clockwise: false);
    path3.lineTo(15.706 * scale, 2.706 * scale);
    path3.arcToPoint(Offset(14 * scale, 2 * scale),
        radius: Radius.circular(2.4 * scale), clockwise: false);
    path3.lineTo(6 * scale, 2 * scale);
    path3.arcToPoint(Offset(4 * scale, 4 * scale),
        radius: Radius.circular(2 * scale), clockwise: false);
    path3.lineTo(4 * scale, 8 * scale);
    canvas.drawPath(path3, paint);
    final pulse = 4 * animationValue * (1 - animationValue);
    canvas.save();
    final center = Offset(4 * scale, 20 * scale);
    canvas.translate(center.dx, center.dy);
    canvas.rotate(-pulse * .22);
    canvas.translate(-center.dx, -center.dy);
    final path1 = Path();
    path1.moveTo(4 * scale, 12 * scale);
    path1.lineTo(4 * scale, 18 * scale);
    canvas.drawPath(path1, paint);
    final path2 = Path();
    path2.moveTo(4 * scale, 14 * scale);
    path2.lineTo(6 * scale, 14 * scale);
    canvas.drawPath(path2, paint);
    canvas.drawCircle(Offset(4 * scale, 20 * scale), 2 * scale, paint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(FileKeyPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
