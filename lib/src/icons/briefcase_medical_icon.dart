import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Briefcase Medical Icon - Handle moves up and down
class BriefcaseMedicalIcon extends AnimatedSVGIcon {
  const BriefcaseMedicalIcon({
    super.key,
    super.size = 40.0,
    super.color,
    super.hoverColor,
    super.animationDuration = const Duration(milliseconds: 600),
    super.strokeWidth = 2.0,
    super.reverseOnExit = false,
    super.enableTouchInteraction = true,
    super.infiniteLoop = false,
  });

  @override
  String get animationDescription => "Briefcase handle moves up and down";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    final oscillation = 2 * animationValue * (1 - animationValue);
    return BriefcaseMedicalPainter(
      color: color,
      handleOffset: oscillation * 2,
      strokeWidth: strokeWidth,
    );
  }
}

class BriefcaseMedicalPainter extends CustomPainter {
  final Color color;
  final double handleOffset;
  final double strokeWidth;

  BriefcaseMedicalPainter({
    required this.color,
    required this.handleOffset,
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

    // Handle
    // M16 6V4a2 2 0 0 0-2-2h-4a2 2 0 0 0-2 2v2
    final path = Path();
    path.moveTo(16 * scale, (6 - handleOffset) * scale);
    path.lineTo(16 * scale, (4 - handleOffset) * scale);
    path.arcToPoint(
      Offset(14 * scale, (2 - handleOffset) * scale),
      radius: Radius.circular(2 * scale),
      clockwise: false,
    );
    path.lineTo(10 * scale, (2 - handleOffset) * scale);
    path.arcToPoint(
      Offset(8 * scale, (4 - handleOffset) * scale),
      radius: Radius.circular(2 * scale),
      clockwise: false,
    );
    path.lineTo(8 * scale, (6 - handleOffset) * scale);
    canvas.drawPath(path, paint);

    // Body
    // rect width="20" height="14" x="2" y="6" rx="2"
    final rect = RRect.fromRectAndRadius(
      Rect.fromLTWH(2 * scale, 6 * scale, 20 * scale, 14 * scale),
      Radius.circular(2 * scale),
    );
    canvas.drawRRect(rect, paint);

    // Cross V: M12 11v4
    canvas.drawLine(Offset(12 * scale, 11 * scale), Offset(12 * scale, 15 * scale), paint);
    
    // Cross H: M14 13h-4
    canvas.drawLine(Offset(14 * scale, 13 * scale), Offset(10 * scale, 13 * scale), paint);

    // Side R: M18 6v14
    canvas.drawLine(Offset(18 * scale, 6 * scale), Offset(18 * scale, 20 * scale), paint);

    // Side L: M6 6v14
    canvas.drawLine(Offset(6 * scale, 6 * scale), Offset(6 * scale, 20 * scale), paint);
  }

  @override
  bool shouldRepaint(BriefcaseMedicalPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.handleOffset != handleOffset ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
