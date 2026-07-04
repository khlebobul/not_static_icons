import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated File Chart Pie Icon - pie slice expands
class FileChartPieIcon extends AnimatedSVGIcon {
  const FileChartPieIcon({
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
  String get animationDescription => "pie slice expands";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return FileChartPiePainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

class FileChartPiePainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  FileChartPiePainter({
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
    path0.moveTo(15.941 * scale, 22 * scale);
    path0.lineTo(18 * scale, 22 * scale);
    path0.arcToPoint(Offset(20 * scale, 20 * scale),
        radius: Radius.circular(2 * scale), clockwise: false);
    path0.lineTo(20 * scale, 8 * scale);
    path0.arcToPoint(Offset(19.294 * scale, 6.296 * scale),
        radius: Radius.circular(2.4 * scale), clockwise: false);
    path0.lineTo(15.706 * scale, 2.708 * scale);
    path0.arcToPoint(Offset(14 * scale, 2 * scale),
        radius: Radius.circular(2.4 * scale), clockwise: false);
    path0.lineTo(6 * scale, 2 * scale);
    path0.arcToPoint(Offset(4 * scale, 4 * scale),
        radius: Radius.circular(2 * scale), clockwise: false);
    path0.lineTo(4 * scale, 7.512 * scale);
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
    path2.moveTo(4.017 * scale, 11.512 * scale);
    path2.arcToPoint(Offset(12.483 * scale, 19.987 * scale),
        radius: Radius.circular(6 * scale), largeArc: true, clockwise: false);
    canvas.drawPath(path2, paint);
    canvas.save();
    final center = Offset(8 * scale, 16 * scale);
    canvas.translate(center.dx, center.dy);
    canvas.rotate(-pulse * .22);
    canvas.translate(-center.dx, -center.dy);
    final path3 = Path();
    path3.moveTo(9 * scale, 16 * scale);
    path3.arcToPoint(Offset(8 * scale, 15 * scale),
        radius: Radius.circular(1 * scale));
    path3.lineTo(8 * scale, 11 * scale);
    path3.cubicTo(8 * scale, 10.448 * scale, 8.45 * scale, 9.992 * scale,
        8.995 * scale, 10.083 * scale);
    path3.arcToPoint(Offset(13.917 * scale, 15.005 * scale),
        radius: Radius.circular(6 * scale));
    path3.cubicTo(14.008 * scale, 15.549 * scale, 13.552 * scale, 16 * scale,
        13 * scale, 16 * scale);
    path3.close();
    canvas.drawPath(path3, paint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(FileChartPiePainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
