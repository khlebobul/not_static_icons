import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'animated_svg_icon_base.dart';

abstract class DrawIconBase extends AnimatedSVGIcon {
  const DrawIconBase({
    super.key,
    super.size = 40,
    super.color,
    super.hoverColor,
    super.animationDuration = const Duration(milliseconds: 700),
    super.strokeWidth = 2,
    super.reverseOnExit = false,
    super.enableTouchInteraction = true,
    super.infiniteLoop = false,
    super.onTap,
    super.interactive,
    super.controller,
  });

  List<Path> get paths;

  void paintIcon(Canvas canvas, Paint paint, double animationValue) =>
      drawIconPaths(canvas, paint, paths);

  @override
  String get animationDescription => 'Icon parts animate';

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) =>
      _DrawIconPainter(this, color, animationValue, strokeWidth);
}

class _DrawIconPainter extends CustomPainter {
  const _DrawIconPainter(
    this.icon,
    this.color,
    this.animationValue,
    this.strokeWidth,
  );

  final DrawIconBase icon;
  final Color color;
  final double animationValue;
  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final scale = size.width / 24;
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth / scale
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..style = PaintingStyle.stroke;

    canvas.save();
    canvas.scale(scale);
    icon.paintIcon(canvas, paint, animationValue);
    canvas.restore();
  }

  @override
  bool shouldRepaint(_DrawIconPainter old) =>
      old.icon.runtimeType != icon.runtimeType ||
      old.color != color ||
      old.animationValue != animationValue ||
      old.strokeWidth != strokeWidth;
}

double iconPulse(double animationValue) =>
    math.sin(math.pi * animationValue.clamp(0, 1));

double iconWave(double animationValue) =>
    math.sin(math.pi * 2 * animationValue.clamp(0, 1));

void drawIconPaths(Canvas canvas, Paint paint, Iterable<Path> paths) {
  for (final path in paths) {
    canvas.drawPath(path, paint);
  }
}
