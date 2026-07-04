import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Fishing Hook Icon - hook swings
class FishingHookIcon extends AnimatedSVGIcon {
  const FishingHookIcon({
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
  String get animationDescription => "hook swings";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return FishingHookPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

class FishingHookPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  FishingHookPainter({
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
    final center = Offset(12 * scale, 2 * scale);
    canvas.translate(center.dx, center.dy);
    canvas.rotate(pulse * .35);
    canvas.translate(-center.dx, -center.dy);
    final path0 = Path();
    path0.moveTo(17.586 * scale, 11.414 * scale);
    path0.lineTo(11.656 * scale, 17.344 * scale);
    path0.arcToPoint(Offset(3.656 * scale, 9.344 * scale),
        radius: Radius.circular(1 * scale));
    path0.lineTo(6.793 * scale, 6.207 * scale);
    path0.arcToPoint(Offset(8 * scale, 6.707 * scale),
        radius: Radius.circular(0.707 * scale));
    path0.lineTo(8 * scale, 10 * scale);
    canvas.drawPath(path0, paint);
    final path1 = Path();
    path1.moveTo(20.414 * scale, 8.586 * scale);
    path1.lineTo(22 * scale, 7 * scale);
    canvas.drawPath(path1, paint);
    canvas.drawCircle(Offset(19 * scale, 10 * scale), 2 * scale, paint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(FishingHookPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
