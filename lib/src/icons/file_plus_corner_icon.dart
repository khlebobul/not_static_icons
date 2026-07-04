import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated File Plus Corner Icon - corner plus expands
class FilePlusCornerIcon extends AnimatedSVGIcon {
  const FilePlusCornerIcon({
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
  String get animationDescription => "corner plus expands";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return FilePlusCornerPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

class FilePlusCornerPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  FilePlusCornerPainter({
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
    path0.moveTo(11.35 * scale, 22 * scale);
    path0.lineTo(6 * scale, 22 * scale);
    path0.arcToPoint(Offset(4 * scale, 20 * scale),
        radius: Radius.circular(2 * scale));
    path0.lineTo(4 * scale, 4 * scale);
    path0.arcToPoint(Offset(6 * scale, 2 * scale),
        radius: Radius.circular(2 * scale));
    path0.lineTo(14 * scale, 2 * scale);
    path0.arcToPoint(Offset(15.706 * scale, 2.706 * scale),
        radius: Radius.circular(2.4 * scale));
    path0.lineTo(19.294 * scale, 6.294 * scale);
    path0.arcToPoint(Offset(20 * scale, 8 * scale),
        radius: Radius.circular(2.4 * scale));
    path0.lineTo(20 * scale, 13.35 * scale);
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
    final center = Offset(17 * scale, 19 * scale);
    canvas.translate(center.dx, center.dy);
    canvas.scale(1 + pulse * .16);
    canvas.translate(-center.dx, -center.dy);
    final path2 = Path();
    path2.moveTo(14 * scale, 19 * scale);
    path2.lineTo(20 * scale, 19 * scale);
    canvas.drawPath(path2, paint);
    final path3 = Path();
    path3.moveTo(17 * scale, 16 * scale);
    path3.lineTo(17 * scale, 22 * scale);
    canvas.drawPath(path3, paint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(FilePlusCornerPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
