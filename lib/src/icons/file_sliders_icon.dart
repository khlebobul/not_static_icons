import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated File Sliders Icon - sliders shift
class FileSlidersIcon extends AnimatedSVGIcon {
  const FileSlidersIcon({
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
  String get animationDescription => "sliders shift";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return FileSlidersPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

class FileSlidersPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  FileSlidersPainter({
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
    path0.moveTo(6 * scale, 22 * scale);
    path0.arcToPoint(Offset(4 * scale, 20 * scale),
        radius: Radius.circular(2 * scale));
    path0.lineTo(4 * scale, 4 * scale);
    path0.arcToPoint(Offset(6 * scale, 2 * scale),
        radius: Radius.circular(2 * scale));
    path0.lineTo(14 * scale, 2 * scale);
    path0.arcToPoint(Offset(15.704 * scale, 2.706 * scale),
        radius: Radius.circular(2.4 * scale));
    path0.lineTo(19.292 * scale, 6.294 * scale);
    path0.arcToPoint(Offset(20 * scale, 8 * scale),
        radius: Radius.circular(2.4 * scale));
    path0.lineTo(20 * scale, 20 * scale);
    path0.arcToPoint(Offset(18 * scale, 22 * scale),
        radius: Radius.circular(2 * scale));
    path0.close();
    canvas.drawPath(path0, paint);
    final path1 = Path();
    path1.moveTo(14 * scale, 2 * scale);
    path1.lineTo(14 * scale, 7 * scale);
    path1.arcToPoint(Offset(15 * scale, 8 * scale),
        radius: Radius.circular(1 * scale), clockwise: false);
    path1.lineTo(20 * scale, 8 * scale);
    canvas.drawPath(path1, paint);
    final pulse = 4 * animationValue * (1 - animationValue);
    final path2 = Path();
    path2.moveTo(8 * scale, 12 * scale);
    path2.lineTo(16 * scale, 12 * scale);
    canvas.drawPath(path2, paint);
    canvas.save();
    canvas.translate(pulse * 2 * scale, 0);
    final path3 = Path();
    path3.moveTo(10 * scale, 11 * scale);
    path3.lineTo(10 * scale, 13 * scale);
    canvas.drawPath(path3, paint);
    canvas.restore();
    final path4 = Path();
    path4.moveTo(8 * scale, 17 * scale);
    path4.lineTo(16 * scale, 17 * scale);
    canvas.drawPath(path4, paint);
    canvas.save();
    canvas.translate(-pulse * 2 * scale, 0);
    final path5 = Path();
    path5.moveTo(14 * scale, 16 * scale);
    path5.lineTo(14 * scale, 18 * scale);
    canvas.drawPath(path5, paint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(FileSlidersPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
