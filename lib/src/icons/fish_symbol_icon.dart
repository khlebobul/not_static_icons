import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Fish Symbol Icon - fish symbol swims
class FishSymbolIcon extends AnimatedSVGIcon {
  const FishSymbolIcon({
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
  String get animationDescription => "fish symbol swims";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return FishSymbolPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

class FishSymbolPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  FishSymbolPainter({
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
    canvas.translate(pulse * 1.0 * scale, 0);
    final path0 = Path();
    path0.moveTo(2 * scale, 16 * scale);
    path0.cubicTo(
        2 * scale, 16 * scale, 11 * scale, 1 * scale, 22 * scale, 12 * scale);
    path0.cubicTo(
        11 * scale, 23 * scale, 2 * scale, 8 * scale, 2 * scale, 8 * scale);
    canvas.drawPath(path0, paint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(FishSymbolPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
