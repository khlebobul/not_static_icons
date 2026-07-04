import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Fingerprint Pattern Icon - fingerprint scan breathes
class FingerprintPatternIcon extends AnimatedSVGIcon {
  const FingerprintPatternIcon({
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
  String get animationDescription => "fingerprint scan breathes";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return FingerprintPatternPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

class FingerprintPatternPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  FingerprintPatternPainter({
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
    path0.moveTo(12 * scale, 10 * scale);
    path0.arcToPoint(Offset(10 * scale, 12 * scale),
        radius: Radius.circular(2 * scale), clockwise: false);
    path0.cubicTo(10 * scale, 13.02 * scale, 9.9 * scale, 14.51 * scale,
        9.74 * scale, 16 * scale);
    _drawAnimatedPath(canvas, path0, paint, animationValue, 0);
    final path1 = Path();
    path1.moveTo(14 * scale, 13.12 * scale);
    path1.cubicTo(14 * scale, 15.5 * scale, 14 * scale, 19.5 * scale,
        13 * scale, 22 * scale);
    _drawAnimatedPath(canvas, path1, paint, animationValue, 1);
    final path2 = Path();
    path2.moveTo(17.29 * scale, 21.02 * scale);
    path2.cubicTo(17.41 * scale, 20.42 * scale, 17.72 * scale, 18.72 * scale,
        17.79 * scale, 18 * scale);
    _drawAnimatedPath(canvas, path2, paint, animationValue, 2);
    final path3 = Path();
    path3.moveTo(2 * scale, 12 * scale);
    path3.arcToPoint(Offset(20 * scale, 6 * scale),
        radius: Radius.circular(10 * scale));
    _drawAnimatedPath(canvas, path3, paint, animationValue, 3);
    final path4 = Path();
    path4.moveTo(2 * scale, 16 * scale);
    path4.lineTo(2.01 * scale, 16 * scale);
    _drawAnimatedPath(canvas, path4, paint, animationValue, 4);
    final path5 = Path();
    path5.moveTo(21.8 * scale, 16 * scale);
    path5.cubicTo(22 * scale, 14 * scale, 21.931 * scale, 10.646 * scale,
        21.8 * scale, 10 * scale);
    _drawAnimatedPath(canvas, path5, paint, animationValue, 5);
    final path6 = Path();
    path6.moveTo(5 * scale, 19.5 * scale);
    path6.cubicTo(
        5.5 * scale, 18 * scale, 6 * scale, 15 * scale, 6 * scale, 12 * scale);
    path6.arcToPoint(Offset(6.34 * scale, 10 * scale),
        radius: Radius.circular(6 * scale));
    _drawAnimatedPath(canvas, path6, paint, animationValue, 6);
    final path7 = Path();
    path7.moveTo(8.65 * scale, 22 * scale);
    path7.cubicTo(8.86 * scale, 21.34 * scale, 9.1 * scale, 20.68 * scale,
        9.22 * scale, 20 * scale);
    _drawAnimatedPath(canvas, path7, paint, animationValue, 7);
    final path8 = Path();
    path8.moveTo(9 * scale, 6.8 * scale);
    path8.arcToPoint(Offset(18 * scale, 12 * scale),
        radius: Radius.circular(6 * scale));
    path8.lineTo(18 * scale, 14 * scale);
    _drawAnimatedPath(canvas, path8, paint, animationValue, 8);
  }

  @override
  bool shouldRepaint(FingerprintPatternPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}

void _drawAnimatedPath(
  Canvas canvas,
  Path path,
  Paint paint,
  double animationValue,
  int index,
) {
  final progress = animationValue < .4
      ? 1 - animationValue / .4
      : ((animationValue - .4) / .6 * 1.5 - index * .06).clamp(0.0, 1.0);
  final animatedPath = Path();
  for (final metric in path.computeMetrics()) {
    animatedPath.addPath(
      metric.extractPath(0, metric.length * progress),
      Offset.zero,
    );
  }
  canvas.drawPath(animatedPath, paint);
}
