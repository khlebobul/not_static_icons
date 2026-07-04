import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Fishing Rod Icon - rod casts
class FishingRodIcon extends AnimatedSVGIcon {
  const FishingRodIcon({
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
  String get animationDescription => "rod casts";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return FishingRodPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

class FishingRodPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  FishingRodPainter({
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
    final path0 = Path();
    path0.moveTo(4 * scale, (11 - pulse * 3) * scale);
    path0.lineTo(5 * scale, (11 - pulse * 3) * scale);
    canvas.drawPath(path0, paint);
    final path1 = Path();
    path1.moveTo(8 * scale, (15 - pulse * 3) * scale);
    path1.arcToPoint(Offset(4 * scale, (15 - pulse * 3) * scale),
        radius: Radius.circular(2 * scale));
    path1.lineTo(4 * scale, 3 * scale);
    path1.arcToPoint(Offset(5 * scale, 2 * scale),
        radius: Radius.circular(1 * scale));
    path1.lineTo(5.5 * scale, 2 * scale);
    path1.cubicTo(
        14 * scale, 2 * scale, 20 * scale, 9 * scale, 20 * scale, 18 * scale);
    path1.lineTo(20 * scale, 22 * scale);
    canvas.drawPath(path1, paint);
    canvas.drawCircle(Offset(18 * scale, 18 * scale), 2 * scale, paint);
  }

  @override
  bool shouldRepaint(FishingRodPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
