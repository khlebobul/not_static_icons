import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Expand Icon - Corner arrows push outward
class ExpandIcon extends AnimatedSVGIcon {
  const ExpandIcon({
    super.key,
    super.size = 40.0,
    super.color,
    super.hoverColor,
    super.animationDuration = const Duration(milliseconds: 700),
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
  String get animationDescription => 'Corner arrows push outward then return';

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) =>
      _ExpandPainter(color, animationValue, strokeWidth);
}

class _ExpandPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  _ExpandPainter(this.color, this.animationValue, this.strokeWidth);

  @override
  void paint(Canvas canvas, Size size) {
    final s = size.width / 24.0;
    final paint = _paint(color, strokeWidth);
    final t = animationValue.clamp(0.0, 1.0);
    final pulse = 4 * t * (1 - t);
    final d = pulse * 1.5;

    // Top right corner (expands +x -y)
    canvas.save();
    canvas.translate(d * s, -d * s);
    canvas.drawLine(Offset(15 * s, 9 * s), Offset(21 * s, 3 * s), paint);
    final tr = Path()
      ..moveTo(21 * s, 8 * s)
      ..lineTo(21 * s, 3 * s)
      ..lineTo(16 * s, 3 * s);
    canvas.drawPath(tr, paint);
    canvas.restore();

    // Bottom right corner (+x +y)
    canvas.save();
    canvas.translate(d * s, d * s);
    canvas.drawLine(Offset(15 * s, 15 * s), Offset(21 * s, 21 * s), paint);
    final br = Path()
      ..moveTo(21 * s, 16 * s)
      ..lineTo(21 * s, 21 * s)
      ..lineTo(16 * s, 21 * s);
    canvas.drawPath(br, paint);
    canvas.restore();

    // Bottom left corner (-x +y)
    canvas.save();
    canvas.translate(-d * s, d * s);
    canvas.drawLine(Offset(3 * s, 21 * s), Offset(9 * s, 15 * s), paint);
    final bl = Path()
      ..moveTo(3 * s, 16 * s)
      ..lineTo(3 * s, 21 * s)
      ..lineTo(8 * s, 21 * s);
    canvas.drawPath(bl, paint);
    canvas.restore();

    // Top left corner (-x -y)
    canvas.save();
    canvas.translate(-d * s, -d * s);
    canvas.drawLine(Offset(9 * s, 9 * s), Offset(3 * s, 3 * s), paint);
    final tl = Path()
      ..moveTo(3 * s, 8 * s)
      ..lineTo(3 * s, 3 * s)
      ..lineTo(8 * s, 3 * s);
    canvas.drawPath(tl, paint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(_ExpandPainter old) =>
      old.color != color ||
      old.animationValue != animationValue ||
      old.strokeWidth != strokeWidth;
}

Paint _paint(Color color, double strokeWidth) {
  return Paint()
    ..color = color
    ..strokeWidth = strokeWidth
    ..strokeCap = StrokeCap.round
    ..strokeJoin = StrokeJoin.round
    ..style = PaintingStyle.stroke;
}
