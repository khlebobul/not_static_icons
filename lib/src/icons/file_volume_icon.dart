import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated File Volume Icon - volume wave pulses
class FileVolumeIcon extends AnimatedSVGIcon {
  const FileVolumeIcon({
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
  String get animationDescription => "volume wave pulses";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return FileVolumePainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

class FileVolumePainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  FileVolumePainter({
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
    path0.moveTo(4 * scale, 11.55 * scale);
    path0.lineTo(4 * scale, 4 * scale);
    path0.arcToPoint(Offset(6 * scale, 2 * scale),
        radius: Radius.circular(2 * scale));
    path0.lineTo(14 * scale, 2 * scale);
    path0.arcToPoint(Offset(15.706 * scale, 2.706 * scale),
        radius: Radius.circular(2.4 * scale));
    path0.lineTo(19.294 * scale, 6.294 * scale);
    path0.arcToPoint(Offset(20 * scale, 8 * scale),
        radius: Radius.circular(2.4 * scale));
    path0.lineTo(20 * scale, 20 * scale);
    path0.arcToPoint(Offset(18 * scale, 22 * scale),
        radius: Radius.circular(2 * scale));
    path0.lineTo(16.05 * scale, 22 * scale);
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
    final center = Offset(14 * scale, 15 * scale);
    canvas.translate(center.dx, center.dy);
    canvas.scale(1 + pulse * .14);
    canvas.translate(-center.dx, -center.dy);
    final path2 = Path();
    path2.moveTo(12 * scale, 15 * scale);
    path2.arcToPoint(Offset(12 * scale, 21 * scale),
        radius: Radius.circular(5 * scale));
    canvas.drawPath(path2, paint);
    final path3 = Path();
    path3.moveTo(8 * scale, 14.502 * scale);
    path3.arcToPoint(Offset(7.174 * scale, 14.121 * scale),
        radius: Radius.circular(0.5 * scale), clockwise: false);
    path3.lineTo(5.281 * scale, 15.752 * scale);
    path3.arcToPoint(Offset(4.63 * scale, 15.995 * scale),
        radius: Radius.circular(1 * scale));
    path3.lineTo(3.5 * scale, 15.995 * scale);
    path3.arcToPoint(Offset(3 * scale, 16.496 * scale),
        radius: Radius.circular(0.5 * scale), clockwise: false);
    path3.lineTo(3 * scale, 19.502 * scale);
    path3.arcToPoint(Offset(3.5 * scale, 20.003 * scale),
        radius: Radius.circular(0.5 * scale), clockwise: false);
    path3.lineTo(4.629 * scale, 20.003 * scale);
    path3.arcToPoint(Offset(5.281 * scale, 20.246 * scale),
        radius: Radius.circular(1 * scale));
    path3.lineTo(7.174 * scale, 21.879 * scale);
    path3.arcToPoint(Offset(8 * scale, 21.499 * scale),
        radius: Radius.circular(0.5 * scale), clockwise: false);
    path3.close();
    canvas.drawPath(path3, paint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(FileVolumePainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
