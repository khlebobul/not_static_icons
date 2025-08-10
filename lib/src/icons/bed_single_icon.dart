import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Bed Single Icon - exact geometry; top frame progressively draws then returns
class BedSingleIcon extends AnimatedSVGIcon {
  const BedSingleIcon({
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
  });

  @override
  String get animationDescription =>
      'Bed single: pillow bounce and return to original';

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return _BedSinglePainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

class _BedSinglePainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  _BedSinglePainter({
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

    // Base frame: M3 20 v-8 a2 2 0 0 1 2 -2 h14 a2 2 0 0 1 2 2 v8
    final base = Path()
      ..moveTo(3 * scale, 20 * scale)
      ..lineTo(3 * scale, 12 * scale)
      ..arcToPoint(Offset(5 * scale, 10 * scale),
          radius: Radius.circular(2 * scale), clockwise: true)
      ..lineTo(19 * scale, 10 * scale)
      ..arcToPoint(Offset(21 * scale, 12 * scale),
          radius: Radius.circular(2 * scale), clockwise: true)
      ..lineTo(21 * scale, 20 * scale);
    canvas.drawPath(base, paint);

    // Top frame (pillow) bounce
    final dy = -1.2 *
        scale *
        (animationValue == 0.0
            ? 0.0
            : (animationValue < 0.5
                ? (animationValue / 0.5)
                : (1 - (animationValue - 0.5) / 0.5)));
    final top = Path()
      ..moveTo(5 * scale, 10 * scale)
      ..lineTo(5 * scale, (6 * scale) + dy)
      ..arcToPoint(Offset(7 * scale, (4 * scale) + dy),
          radius: Radius.circular(2 * scale), clockwise: true)
      ..lineTo(17 * scale, (4 * scale) + dy)
      ..arcToPoint(Offset(19 * scale, (6 * scale) + dy),
          radius: Radius.circular(2 * scale), clockwise: true)
      ..lineTo(19 * scale, 10 * scale);
    canvas.drawPath(top, paint);

    // Bottom line: M3 18 h18
    canvas.drawLine(
        Offset(3 * scale, 18 * scale), Offset(21 * scale, 18 * scale), paint);
  }

  // No helpers

  @override
  bool shouldRepaint(_BedSinglePainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
