import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated File Cog Icon - cog rotates inside a static file
class FileCogIcon extends AnimatedSVGIcon {
  const FileCogIcon({
    super.key,
    super.size = 40.0,
    super.color,
    super.hoverColor,
    super.animationDuration = const Duration(milliseconds: 900),
    super.strokeWidth = 2.0,
    super.reverseOnExit = false,
    super.enableTouchInteraction = true,
    super.infiniteLoop = false,
    super.onTap,
    super.interactive,
    super.controller,
  });

  @override
  String get animationDescription => "Cog rotates inside a static file";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return FileCogPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

class FileCogPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  FileCogPainter({
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
    path0.moveTo(15 * scale, 8 * scale);
    path0.arcToPoint(Offset(14 * scale, 7 * scale),
        radius: Radius.circular(1 * scale));
    path0.lineTo(14 * scale, 2 * scale);
    path0.arcToPoint(Offset(15.704 * scale, 2.706 * scale),
        radius: Radius.circular(2.4 * scale));
    path0.lineTo(19.292 * scale, 6.294 * scale);
    path0.arcToPoint(Offset(20 * scale, 8 * scale),
        radius: Radius.circular(2.4 * scale));
    path0.close();
    canvas.drawPath(path0, paint);
    final path1 = Path();
    path1.moveTo(20 * scale, 8 * scale);
    path1.lineTo(20 * scale, 20 * scale);
    path1.arcToPoint(Offset(18 * scale, 22 * scale),
        radius: Radius.circular(2 * scale));
    path1.lineTo(13.818 * scale, 22 * scale);
    canvas.drawPath(path1, paint);
    final path3 = Path();
    path3.moveTo(4 * scale, 10.592 * scale);
    path3.lineTo(4 * scale, 4 * scale);
    path3.arcToPoint(Offset(6 * scale, 2 * scale),
        radius: Radius.circular(2 * scale));
    path3.lineTo(14 * scale, 2 * scale);
    canvas.drawPath(path3, paint);
    final pulse = 4 * animationValue * (1 - animationValue);
    canvas.save();
    final center = Offset(7 * scale, 18 * scale);
    canvas.translate(center.dx, center.dy);
    canvas.rotate(pulse * .65);
    canvas.translate(-center.dx, -center.dy);
    final path2 = Path();
    path2.moveTo(3.305 * scale, 19.53 * scale);
    path2.lineTo(4.228 * scale, 19.148 * scale);
    canvas.drawPath(path2, paint);
    final path4 = Path();
    path4.moveTo(4.228 * scale, 16.852 * scale);
    path4.lineTo(3.304 * scale, 16.469 * scale);
    canvas.drawPath(path4, paint);
    final path5 = Path();
    path5.moveTo(5.852 * scale, 15.228 * scale);
    path5.lineTo(5.469 * scale, 14.305 * scale);
    canvas.drawPath(path5, paint);
    final path6 = Path();
    path6.moveTo(5.852 * scale, 20.772 * scale);
    path6.lineTo(5.469 * scale, 21.696 * scale);
    canvas.drawPath(path6, paint);
    final path7 = Path();
    path7.moveTo(8.148 * scale, 15.228 * scale);
    path7.lineTo(8.531 * scale, 14.305 * scale);
    canvas.drawPath(path7, paint);
    final path8 = Path();
    path8.moveTo(8.53 * scale, 21.696 * scale);
    path8.lineTo(8.148 * scale, 20.772 * scale);
    canvas.drawPath(path8, paint);
    final path9 = Path();
    path9.moveTo(9.773 * scale, 16.852 * scale);
    path9.lineTo(10.695 * scale, 16.469 * scale);
    canvas.drawPath(path9, paint);
    final path10 = Path();
    path10.moveTo(9.773 * scale, 19.148 * scale);
    path10.lineTo(10.695 * scale, 19.531 * scale);
    canvas.drawPath(path10, paint);
    canvas.drawCircle(Offset(7 * scale, 18 * scale), 3 * scale, paint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(FileCogPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
