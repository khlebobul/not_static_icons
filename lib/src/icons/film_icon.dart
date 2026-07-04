import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Film Icon - film strip rolls
class FilmIcon extends AnimatedSVGIcon {
  const FilmIcon({
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
  String get animationDescription => "film strip rolls";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return FilmPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

class FilmPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  FilmPainter({
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
    final frame = Path()
      ..addRRect(RRect.fromRectAndRadius(
          Rect.fromLTWH(3 * scale, 3 * scale, 18 * scale, 18 * scale),
          Radius.elliptical(2 * scale, 2 * scale)));
    _drawFilmPath(canvas, frame, paint, animationValue, 0);
    final path1 = Path();
    path1.moveTo(7 * scale, 3 * scale);
    path1.lineTo(7 * scale, 21 * scale);
    _drawFilmPath(canvas, path1, paint, animationValue, 1);
    final path2 = Path();
    path2.moveTo(3 * scale, 7.5 * scale);
    path2.lineTo(7 * scale, 7.5 * scale);
    _drawFilmPath(canvas, path2, paint, animationValue, 2);
    final path3 = Path();
    path3.moveTo(3 * scale, 12 * scale);
    path3.lineTo(21 * scale, 12 * scale);
    _drawFilmPath(canvas, path3, paint, animationValue, 3);
    final path4 = Path();
    path4.moveTo(3 * scale, 16.5 * scale);
    path4.lineTo(7 * scale, 16.5 * scale);
    _drawFilmPath(canvas, path4, paint, animationValue, 4);
    final path5 = Path();
    path5.moveTo(17 * scale, 3 * scale);
    path5.lineTo(17 * scale, 21 * scale);
    _drawFilmPath(canvas, path5, paint, animationValue, 5);
    final path6 = Path();
    path6.moveTo(17 * scale, 7.5 * scale);
    path6.lineTo(21 * scale, 7.5 * scale);
    _drawFilmPath(canvas, path6, paint, animationValue, 6);
    final path7 = Path();
    path7.moveTo(17 * scale, 16.5 * scale);
    path7.lineTo(21 * scale, 16.5 * scale);
    _drawFilmPath(canvas, path7, paint, animationValue, 7);
  }

  @override
  bool shouldRepaint(FilmPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}

void _drawFilmPath(
  Canvas canvas,
  Path path,
  Paint paint,
  double animationValue,
  int index,
) {
  final progress = animationValue < .35
      ? 1 - animationValue / .35
      : ((animationValue - .35) / .65 * 1.45 - index * .05).clamp(0.0, 1.0);
  final animatedPath = Path();
  for (final metric in path.computeMetrics()) {
    animatedPath.addPath(
      metric.extractPath(0, metric.length * progress),
      Offset.zero,
    );
  }
  canvas.drawPath(animatedPath, paint);
}
