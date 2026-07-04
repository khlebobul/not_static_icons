import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated File Scan Icon - scan target sweeps
class FileScanIcon extends AnimatedSVGIcon {
  const FileScanIcon({
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
  String get animationDescription => "scan target sweeps";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return FileScanPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

class FileScanPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  FileScanPainter({
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
    path0.moveTo(20 * scale, 10 * scale);
    path0.lineTo(20 * scale, 8 * scale);
    path0.arcToPoint(Offset(19.294 * scale, 6.296 * scale),
        radius: Radius.circular(2.4 * scale), clockwise: false);
    path0.lineTo(15.706 * scale, 2.708 * scale);
    path0.arcToPoint(Offset(14 * scale, 2 * scale),
        radius: Radius.circular(2.4 * scale), clockwise: false);
    path0.lineTo(6 * scale, 2 * scale);
    path0.arcToPoint(Offset(4 * scale, 4 * scale),
        radius: Radius.circular(2 * scale), clockwise: false);
    path0.lineTo(4 * scale, 20 * scale);
    path0.arcToPoint(Offset(6 * scale, 22 * scale),
        radius: Radius.circular(2 * scale), clockwise: false);
    path0.lineTo(10.35 * scale, 22 * scale);
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
    canvas.translate(0, pulse * 1.0 * scale);
    final path2 = Path();
    path2.moveTo(16 * scale, 14 * scale);
    path2.arcToPoint(Offset(14 * scale, 16 * scale),
        radius: Radius.circular(2 * scale), clockwise: false);
    canvas.drawPath(path2, paint);
    final path3 = Path();
    path3.moveTo(16 * scale, 22 * scale);
    path3.arcToPoint(Offset(14 * scale, 20 * scale),
        radius: Radius.circular(2 * scale));
    canvas.drawPath(path3, paint);
    final path4 = Path();
    path4.moveTo(20 * scale, 14 * scale);
    path4.arcToPoint(Offset(22 * scale, 16 * scale),
        radius: Radius.circular(2 * scale));
    canvas.drawPath(path4, paint);
    final path5 = Path();
    path5.moveTo(20 * scale, 22 * scale);
    path5.arcToPoint(Offset(22 * scale, 20 * scale),
        radius: Radius.circular(2 * scale), clockwise: false);
    canvas.drawPath(path5, paint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(FileScanPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
