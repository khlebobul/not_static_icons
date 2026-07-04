import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated File Pen Icon - pen writes
class FilePenIcon extends AnimatedSVGIcon {
  const FilePenIcon({
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
  String get animationDescription => "pen writes";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return FilePenPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

class FilePenPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  FilePenPainter({
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
    path0.moveTo(12.659 * scale, 22 * scale);
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
    path0.lineTo(4 * scale, 13.34 * scale);
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
    canvas.translate(pulse * .9 * scale, -pulse * .5 * scale);
    final path2 = Path();
    path2.moveTo(10.378 * scale, 12.622 * scale);
    path2.arcToPoint(Offset(13.378 * scale, 15.625 * scale),
        radius: Radius.circular(1 * scale));
    path2.lineTo(8.36 * scale, 20.637 * scale);
    path2.arcToPoint(Offset(7.506 * scale, 21.143 * scale),
        radius: Radius.circular(2 * scale));
    path2.lineTo(4.639 * scale, 21.98 * scale);
    path2.arcToPoint(Offset(4.019 * scale, 21.36 * scale),
        radius: Radius.circular(0.5 * scale));
    path2.lineTo(4.855 * scale, 18.491 * scale);
    path2.arcToPoint(Offset(5.361 * scale, 17.638 * scale),
        radius: Radius.circular(2 * scale));
    path2.close();
    canvas.drawPath(path2, paint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(FilePenPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
