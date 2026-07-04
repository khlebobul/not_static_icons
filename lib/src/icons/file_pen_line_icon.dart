import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated File Pen Line Icon - pen underlines
class FilePenLineIcon extends AnimatedSVGIcon {
  const FilePenLineIcon({
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
  String get animationDescription => "pen underlines";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return FilePenLinePainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

class FilePenLinePainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  FilePenLinePainter({
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
    final pulse = 4 * animationValue * (1 - animationValue);
    canvas.save();
    canvas.translate(pulse * .8 * scale, -pulse * .45 * scale);
    final path0 = Path();
    path0.moveTo(14.364 * scale, 13.634 * scale);
    path0.arcToPoint(Offset(13.858 * scale, 14.488 * scale),
        radius: Radius.circular(2 * scale), clockwise: false);
    path0.lineTo(13.021 * scale, 17.358 * scale);
    path0.arcToPoint(Offset(13.641 * scale, 17.978 * scale),
        radius: Radius.circular(0.5 * scale), clockwise: false);
    path0.lineTo(16.511 * scale, 17.141 * scale);
    path0.arcToPoint(Offset(17.365 * scale, 16.635 * scale),
        radius: Radius.circular(2 * scale), clockwise: false);
    path0.lineTo(21.378 * scale, 12.626 * scale);
    path0.arcToPoint(Offset(18.374 * scale, 9.622 * scale),
        radius: Radius.circular(1 * scale), clockwise: false);
    path0.close();
    canvas.drawPath(path0, paint);
    canvas.restore();
    final path1 = Path();
    path1.moveTo(14.487 * scale, 7.858 * scale);
    path1.arcToPoint(Offset(14 * scale, 7 * scale),
        radius: Radius.circular(1 * scale));
    path1.lineTo(14 * scale, 2 * scale);
    canvas.drawPath(path1, paint);
    final path2 = Path();
    path2.moveTo(20 * scale, 19.645 * scale);
    path2.lineTo(20 * scale, 20 * scale);
    path2.arcToPoint(Offset(18 * scale, 22 * scale),
        radius: Radius.circular(2 * scale));
    path2.lineTo(6 * scale, 22 * scale);
    path2.arcToPoint(Offset(4 * scale, 20 * scale),
        radius: Radius.circular(2 * scale));
    path2.lineTo(4 * scale, 4 * scale);
    path2.arcToPoint(Offset(6 * scale, 2 * scale),
        radius: Radius.circular(2 * scale));
    path2.lineTo(14 * scale, 2 * scale);
    path2.arcToPoint(Offset(15.704 * scale, 2.706 * scale),
        radius: Radius.circular(2.4 * scale));
    path2.lineTo(18.22 * scale, 5.222 * scale);
    canvas.drawPath(path2, paint);
    final path3 = Path();
    path3.moveTo(8 * scale, 18 * scale);
    path3.lineTo((9 + pulse * 2) * scale, 18 * scale);
    canvas.drawPath(path3, paint);
  }

  @override
  bool shouldRepaint(FilePenLinePainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
