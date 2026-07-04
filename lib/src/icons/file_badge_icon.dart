import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated File Badge Icon - badge stamp pops
class FileBadgeIcon extends AnimatedSVGIcon {
  const FileBadgeIcon({
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
  String get animationDescription => "badge stamp pops";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return FileBadgePainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

class FileBadgePainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  FileBadgePainter({
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
    final path0 = Path();
    path0.moveTo(13 * scale, 22 * scale);
    path0.lineTo(18 * scale, 22 * scale);
    path0.arcToPoint(Offset(20 * scale, 20 * scale),
        radius: Radius.circular(2 * scale), clockwise: false);
    path0.lineTo(20 * scale, 8 * scale);
    path0.arcToPoint(Offset(19.294 * scale, 6.294 * scale),
        radius: Radius.circular(2.4 * scale), clockwise: false);
    path0.lineTo(15.706 * scale, 2.706 * scale);
    path0.arcToPoint(Offset(14 * scale, 2 * scale),
        radius: Radius.circular(2.4 * scale), clockwise: false);
    path0.lineTo(6 * scale, 2 * scale);
    path0.arcToPoint(Offset(4 * scale, 4 * scale),
        radius: Radius.circular(2 * scale), clockwise: false);
    path0.lineTo(4 * scale, 7.3 * scale);
    canvas.drawPath(path0, paint);
    final path1 = Path();
    path1.moveTo(14 * scale, 2 * scale);
    path1.lineTo(14 * scale, 7 * scale);
    path1.arcToPoint(Offset(15 * scale, 8 * scale),
        radius: Radius.circular(1 * scale), clockwise: false);
    path1.lineTo(20 * scale, 8 * scale);
    canvas.drawPath(path1, paint);
    final pulse = 4 * animationValue * (1 - animationValue);
    canvas.save();
    final center = Offset(12 * scale, 15 * scale);
    canvas.translate(center.dx, center.dy);
    canvas.translate(0, -pulse * 1.1 * scale);
    canvas.rotate(pulse * .08);
    canvas.translate(-center.dx, -center.dy);
    final path2 = Path();
    path2.moveTo(7.69 * scale, 16.479 * scale);
    path2.lineTo(8.98 * scale, 21.359 * scale);
    path2.arcToPoint(Offset(8.282 * scale, 21.95 * scale),
        radius: Radius.circular(0.5 * scale));
    path2.lineTo(6.439 * scale, 21.101 * scale);
    path2.arcToPoint(Offset(5.56 * scale, 21.102 * scale),
        radius: Radius.circular(1 * scale), clockwise: false);
    path2.lineTo(3.714 * scale, 21.952 * scale);
    path2.arcToPoint(Offset(3.022 * scale, 21.359 * scale),
        radius: Radius.circular(0.5 * scale));
    path2.lineTo(4.312 * scale, 16.479 * scale);
    canvas.drawPath(path2, paint);
    canvas.drawCircle(Offset(6 * scale, 14 * scale), 3 * scale, paint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(FileBadgePainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
