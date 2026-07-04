import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Fish Off Icon - fish drifts under slash
class FishOffIcon extends AnimatedSVGIcon {
  const FishOffIcon({
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
  String get animationDescription => "fish drifts under slash";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return FishOffPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

class FishOffPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  FishOffPainter({
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
    canvas.translate(-pulse * 1.2 * scale, -pulse * .25 * scale);
    final path0 = Path();
    path0.moveTo(18 * scale, 12.47 * scale);
    path0.lineTo(18 * scale, 12.5 * scale);
    path0.moveTo(18 * scale, 12 * scale);
    path0.lineTo(18 * scale, 12.47 * scale);
    path0.moveTo(17.525 * scale, 17.526 * scale);
    path0.arcToPoint(Offset(15 * scale, 18 * scale),
        radius: Radius.circular(6.744 * scale));
    path0.cubicTo(11.44 * scale, 18 * scale, 7.44 * scale, 15.47 * scale,
        6.5 * scale, 12 * scale);
    path0.cubicTo(6.848 * scale, 10.72 * scale, 7.614 * scale, 9.567 * scale,
        8.621 * scale, 8.62 * scale);
    path0.moveTo(12.065 * scale, 6.532 * scale);
    path0.arcToPoint(Offset(15 * scale, 6 * scale),
        radius: Radius.circular(8.802 * scale));
    path0.cubicTo(18.56 * scale, 6 * scale, 21.06 * scale, 8.54 * scale,
        22 * scale, 12 * scale);
    path0.cubicTo(21.691 * scale, 13.14 * scale, 21.214 * scale, 14.177 * scale,
        20.587 * scale, 15.058 * scale);
    canvas.drawPath(path0, paint);
    final path1 = Path();
    path1.moveTo(7 * scale, 10.67 * scale);
    path1.cubicTo(7 * scale, 8 * scale, 5.58 * scale, 5.97 * scale,
        2.73 * scale, 5.5 * scale);
    path1.cubicTo(1.73 * scale, 7 * scale, 1.73 * scale, 10.5 * scale,
        2.96 * scale, 12 * scale);
    path1.cubicTo(1.72 * scale, 13.5 * scale, 1.72 * scale, 17 * scale,
        2.73 * scale, 18.5 * scale);
    path1.cubicTo(5.58 * scale, 18.03 * scale, 7 * scale, 16 * scale, 7 * scale,
        13.33 * scale);
    path1.moveTo(14.48 * scale, 8.958 * scale);
    path1.arcToPoint(Offset(16 * scale, 6.07 * scale),
        radius: Radius.circular(9.77 * scale));
    path1.moveTo(16 * scale, 17.93 * scale);
    path1.arcToPoint(Offset(14.272 * scale, 14.312 * scale),
        radius: Radius.circular(9.77 * scale));
    canvas.drawPath(path1, paint);
    final path2 = Path();
    path2.moveTo(16.01 * scale, 17.93 * scale);
    path2.lineTo(15.78 * scale, 19.33 * scale);
    path2.arcToPoint(Offset(13.8 * scale, 21 * scale),
        radius: Radius.circular(2 * scale));
    path2.lineTo(9.5 * scale, 21 * scale);
    path2.arcToPoint(Offset(10.99 * scale, 17.02 * scale),
        radius: Radius.circular(5.96 * scale), clockwise: false);
    path2.moveTo(8.53 * scale, 3 * scale);
    path2.lineTo(13.8 * scale, 3 * scale);
    path2.arcToPoint(Offset(15.78 * scale, 4.67 * scale),
        radius: Radius.circular(2 * scale));
    path2.lineTo(16.01 * scale, 6.07 * scale);
    canvas.drawPath(path2, paint);
    canvas.restore();
    final slash = Path()
      ..moveTo(2 * scale, 2 * scale)
      ..lineTo(22 * scale, 22 * scale);
    final slashProgress = animationValue < .25
        ? 1 - animationValue / .25
        : ((animationValue - .25) / .5).clamp(0.0, 1.0);
    final slashMetric = slash.computeMetrics().first;
    canvas.drawPath(
      slashMetric.extractPath(0, slashMetric.length * slashProgress),
      paint,
    );
  }

  @override
  bool shouldRepaint(FishOffPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
