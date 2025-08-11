import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Bed Double Icon - exact geometry; two pillows rise then settle
class BedDoubleIcon extends AnimatedSVGIcon {
  const BedDoubleIcon({
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
      'Bed double: both pillows rise/settle in slight phase offset';

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return _BedDoublePainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

class _BedDoublePainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  _BedDoublePainter({
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

    // Base frame: path1 M2 20 v-8 a2 2 0 0 1 2 -2 h16 a2 2 0 0 1 2 2 v8
    final p1 = Path()
      ..moveTo(2 * scale, 20 * scale)
      ..lineTo(2 * scale, 12 * scale)
      ..arcToPoint(Offset(4 * scale, 10 * scale),
          radius: Radius.circular(2 * scale), clockwise: true)
      ..lineTo(20 * scale, 10 * scale)
      ..arcToPoint(Offset(22 * scale, 12 * scale),
          radius: Radius.circular(2 * scale), clockwise: true)
      ..lineTo(22 * scale, 20 * scale);
    canvas.drawPath(p1, paint);

    // Top frame (pillows) bounce together
    final dy = -1.2 *
        scale *
        (animationValue == 0.0
            ? 0.0
            : (animationValue < 0.5
                ? (animationValue / 0.5)
                : (1 - (animationValue - 0.5) / 0.5)));
    final top = Path()
      ..moveTo(4 * scale, 10 * scale)
      ..lineTo(4 * scale, (6 * scale) + dy)
      ..arcToPoint(Offset(6 * scale, (4 * scale) + dy),
          radius: Radius.circular(2 * scale), clockwise: true)
      ..lineTo(18 * scale, (4 * scale) + dy)
      ..arcToPoint(Offset(20 * scale, (6 * scale) + dy),
          radius: Radius.circular(2 * scale), clockwise: true)
      ..lineTo(20 * scale, 10 * scale);
    canvas.drawPath(top, paint);

    // Center separator: M12 4 v6
    canvas.drawLine(
        Offset(12 * scale, 4 * scale), Offset(12 * scale, 10 * scale), paint);

    // Bottom line: path4 M2 18 h20
    canvas.drawLine(
        Offset(2 * scale, 18 * scale), Offset(22 * scale, 18 * scale), paint);
  }

  @override
  bool shouldRepaint(_BedDoublePainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
