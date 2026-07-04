import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Fire Extinguisher Icon - extinguisher bumps forward
class FireExtinguisherIcon extends AnimatedSVGIcon {
  const FireExtinguisherIcon({
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
  String get animationDescription => "extinguisher bumps forward";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return FireExtinguisherPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

class FireExtinguisherPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  FireExtinguisherPainter({
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
    final center = Offset(13 * scale, 12 * scale);
    canvas.translate(center.dx, center.dy);
    canvas.rotate(-pulse * .15);
    canvas.translate(-center.dx, -center.dy);
    final path0 = Path();
    path0.moveTo(15 * scale, 6.5 * scale);
    path0.lineTo(15 * scale, 3 * scale);
    path0.arcToPoint(Offset(14 * scale, 2 * scale),
        radius: Radius.circular(1 * scale), clockwise: false);
    path0.lineTo(12 * scale, 2 * scale);
    path0.arcToPoint(Offset(11 * scale, 3 * scale),
        radius: Radius.circular(1 * scale), clockwise: false);
    path0.lineTo(11 * scale, 6.5 * scale);
    canvas.drawPath(path0, paint);
    final path1 = Path();
    path1.moveTo(9 * scale, 18 * scale);
    path1.lineTo(17 * scale, 18 * scale);
    canvas.drawPath(path1, paint);
    final path2 = Path();
    path2.moveTo(18 * scale, 3 * scale);
    path2.lineTo(15 * scale, 3 * scale);
    canvas.drawPath(path2, paint);
    final path3 = Path();
    path3.moveTo(11 * scale, 3 * scale);
    path3.arcToPoint(Offset(5 * scale, 9 * scale),
        radius: Radius.circular(6 * scale), clockwise: false);
    path3.lineTo(5 * scale, 20 * scale);
    canvas.drawPath(path3, paint);
    final path4 = Path();
    path4.moveTo(5 * scale, 13 * scale);
    path4.lineTo(9 * scale, 13 * scale);
    canvas.drawPath(path4, paint);
    final path5 = Path();
    path5.moveTo(17 * scale, 10 * scale);
    path5.arcToPoint(Offset(9 * scale, 10 * scale),
        radius: Radius.circular(4 * scale), clockwise: false);
    path5.lineTo(9 * scale, 20 * scale);
    path5.arcToPoint(Offset(11 * scale, 22 * scale),
        radius: Radius.circular(2 * scale), clockwise: false);
    path5.lineTo(15 * scale, 22 * scale);
    path5.arcToPoint(Offset(17 * scale, 20 * scale),
        radius: Radius.circular(2 * scale), clockwise: false);
    path5.close();
    canvas.drawPath(path5, paint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(FireExtinguisherPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
