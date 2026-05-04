import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Crop Icon - two crop corners breathe apart and back together on hover/tap
class CropIcon extends AnimatedSVGIcon {
  const CropIcon({
    super.key,
    super.size = 40.0,
    super.color,
    super.hoverColor,
    super.animationDuration = const Duration(milliseconds: 800),
    super.strokeWidth = 2.0,
    super.reverseOnExit = false,
    super.enableTouchInteraction = true,
    super.infiniteLoop = false,
    super.resetToStartOnComplete = true,
    super.onTap,
    super.interactive,
    super.controller,
  });

  @override
  String get animationDescription => 'Crop corners breathe apart and back';

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return _CropPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

class _CropPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  _CropPainter({
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

    final double s = size.width / 24.0;
    final double t = animationValue.clamp(0.0, 1.0);

    // Spread amount: top-left corner moves up-left, bottom-right moves down-right
    final double spread = math.sin(math.pi * t) * 1.8 * s;

    // Path 1 (top-left corner): M6 2v14a2 2 0 0 0 2 2h14
    // This L-shape starts at top, goes down, then right — shift up-left
    canvas.save();
    canvas.translate(-spread, -spread);
    final Path p1 = Path()
      ..moveTo(6 * s, 2 * s)
      ..lineTo(6 * s, 16 * s)
      ..arcToPoint(
        Offset(8 * s, 18 * s),
        radius: Radius.circular(2 * s),
        clockwise: false,
      )
      ..lineTo(22 * s, 18 * s);
    canvas.drawPath(p1, paint);
    canvas.restore();

    // Path 2 (bottom-right corner): M18 22V8a2 2 0 0 0-2-2H2
    // This L-shape starts at bottom, goes up, then left — shift down-right
    canvas.save();
    canvas.translate(spread, spread);
    final Path p2 = Path()
      ..moveTo(18 * s, 22 * s)
      ..lineTo(18 * s, 8 * s)
      ..arcToPoint(
        Offset(16 * s, 6 * s),
        radius: Radius.circular(2 * s),
        clockwise: false,
      )
      ..lineTo(2 * s, 6 * s);
    canvas.drawPath(p2, paint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(_CropPainter old) =>
      old.color != color ||
      old.animationValue != animationValue ||
      old.strokeWidth != strokeWidth;
}
