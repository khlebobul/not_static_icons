import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated File Box Icon - box tilts
class FileBoxIcon extends AnimatedSVGIcon {
  const FileBoxIcon({
    super.key,
    super.size = 40.0,
    super.color,
    super.hoverColor,
    super.animationDuration = const Duration(milliseconds: 850),
    super.strokeWidth = 2.0,
    super.reverseOnExit = false,
    super.enableTouchInteraction = true,
    super.infiniteLoop = false,
    super.onTap,
    super.interactive,
    super.controller,
  });

  @override
  String get animationDescription => "Box tilts";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return FileBoxPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

class FileBoxPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  FileBoxPainter({
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
    path0.moveTo(14.5 * scale, 22 * scale);
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
    path0.lineTo(4 * scale, 7.8 * scale);
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
    final center = Offset(7 * scale, 17 * scale);
    canvas.translate(center.dx, center.dy);
    canvas.rotate(pulse * .18);
    canvas.translate(-center.dx, -center.dy);
    final lid = Path()
      ..moveTo(11.7 * scale, 14.2 * scale)
      ..lineTo(7 * scale, 17 * scale)
      ..lineTo(2.3 * scale, 14.2 * scale);
    canvas.drawPath(lid, paint);
    final path3 = Path();
    path3.moveTo(3 * scale, 13.1 * scale);
    path3.arcToPoint(Offset(2.001 * scale, 14.86 * scale),
        radius: Radius.circular(2 * scale), clockwise: false);
    path3.lineTo(2.001 * scale, 18.1 * scale);
    path3.arcToPoint(Offset(2.97 * scale, 19.88 * scale),
        radius: Radius.circular(2 * scale), clockwise: false);
    path3.lineTo(6 * scale, 21.7 * scale);
    path3.arcToPoint(Offset(8.03 * scale, 21.71 * scale),
        radius: Radius.circular(2 * scale), clockwise: false);
    path3.lineTo(11 * scale, 19.9 * scale);
    path3.arcToPoint(Offset(12 * scale, 18.14 * scale),
        radius: Radius.circular(2 * scale), clockwise: false);
    path3.lineTo(12 * scale, 14.9 * scale);
    path3.arcToPoint(Offset(11.03 * scale, 13.12 * scale),
        radius: Radius.circular(2 * scale), clockwise: false);
    path3.lineTo(8 * scale, 11.3 * scale);
    path3.arcToPoint(Offset(5.97 * scale, 11.29 * scale),
        radius: Radius.circular(2 * scale), clockwise: false);
    path3.close();
    canvas.drawPath(path3, paint);
    final path4 = Path();
    path4.moveTo(7 * scale, 17 * scale);
    path4.lineTo(7 * scale, 22 * scale);
    canvas.drawPath(path4, paint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(FileBoxPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
