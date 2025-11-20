import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Briefcase Icon - Handle moves up and down
class BriefcaseIcon extends AnimatedSVGIcon {
  const BriefcaseIcon({
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
    return BriefcasePainter(
      color: color,
      handleOffset: oscillation * 2,
      strokeWidth: strokeWidth,
    );
  }
}

class BriefcasePainter extends CustomPainter {
  final Color color;
  final double handleOffset;
  final double strokeWidth;

  BriefcasePainter({
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
    // M16 20V4a2 2 0 0 0-2-2h-4a2 2 0 0 0-2 2v16
    final path = Path();
    // We apply handleOffset to Y coordinates to move it up
    path.moveTo(16 * scale, (20 - handleOffset) * scale);
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

    path.lineTo(8 * scale, (20 - handleOffset) * scale);

    canvas.drawPath(path, paint);

    // Body
    // rect width="20" height="14" x="2" y="6" rx="2"
    final rect = RRect.fromRectAndRadius(
      Rect.fromLTWH(2 * scale, 6 * scale, 20 * scale, 14 * scale),
      Radius.circular(2 * scale),
    );
    canvas.drawRRect(rect, paint);
  }

  @override
  bool shouldRepaint(BriefcasePainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.handleOffset != handleOffset ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
