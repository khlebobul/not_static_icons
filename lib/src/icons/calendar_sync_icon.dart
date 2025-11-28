import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../core/animated_svg_icon_base.dart';

/// Animated Calendar Sync Icon - Arrows rotate
class CalendarSyncIcon extends AnimatedSVGIcon {
  const CalendarSyncIcon({
    super.key,
    super.size = 40.0,
    super.color,
    super.hoverColor,
    super.animationDuration = const Duration(milliseconds: 1000),
    super.strokeWidth = 2.0,
    super.reverseOnExit = false,
    super.enableTouchInteraction = true,
    super.infiniteLoop = false,
  });

  @override
  String get animationDescription => "Arrows rotate";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    // Rotate 360 degrees
    final angle = animationValue * math.pi * 2;

    return CalendarSyncPainter(
      color: color,
      angle: angle,
      strokeWidth: strokeWidth,
    );
  }
}

class CalendarSyncPainter extends CustomPainter {
  final Color color;
  final double angle;
  final double strokeWidth;

  CalendarSyncPainter({
    required this.color,
    required this.angle,
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

    // Calendar Body (Static)
    // M21 8.5V6a2 2 0 0 0-2-2H5a2 2 0 0 0-2 2v14a2 2 0 0 0 2 2h4.3
    final bodyPath = Path();
    bodyPath.moveTo(21 * scale, 8.5 * scale);
    bodyPath.lineTo(21 * scale, 6 * scale);
    bodyPath.arcToPoint(Offset(19 * scale, 4 * scale),
        radius: Radius.circular(2 * scale), clockwise: false);
    bodyPath.lineTo(5 * scale, 4 * scale);
    bodyPath.arcToPoint(Offset(3 * scale, 6 * scale),
        radius: Radius.circular(2 * scale), clockwise: false);
    bodyPath.lineTo(3 * scale, 20 * scale);
    bodyPath.arcToPoint(Offset(5 * scale, 22 * scale),
        radius: Radius.circular(2 * scale), clockwise: false);
    bodyPath.lineTo(9.3 * scale, 22 * scale);
    canvas.drawPath(bodyPath, paint);

    // M3 10h4
    canvas.drawLine(
        Offset(3 * scale, 10 * scale), Offset(7 * scale, 10 * scale), paint);

    // Top Lines
    // M16 2v4
    canvas.drawLine(
        Offset(16 * scale, 2 * scale), Offset(16 * scale, 6 * scale), paint);
    // M8 2v4
    canvas.drawLine(
        Offset(8 * scale, 2 * scale), Offset(8 * scale, 6 * scale), paint);

    // Sync Arrows (Animated)
    // Center roughly 16, 16.
    // M11 10v4h4
    // m11 14 1.535-1.605a5 5 0 0 1 8 1.5
    // m21 18-1.535 1.605a5 5 0 0 1-8-1.5
    // M21 22v-4h-4

    // The center of rotation seems to be 16, 16.
    // Let's check coordinates.
    // Top arrow starts at 11, 14.
    // Bottom arrow starts at 21, 18.
    // 11, 14 -> 1.535, -1.605 -> 12.535, 12.395.
    // Arc radius 5.
    // Center of arc?
    // If arc is from 12.535, 12.395 to 20.535, 13.895?
    // It's a bit complex to reconstruct exact center.
    // But visually it looks like a circle around 16, 16.

    canvas.save();
    canvas.translate(16 * scale, 16 * scale);
    canvas.rotate(angle);
    canvas.translate(-16 * scale, -16 * scale);

    // Arrow 1 (Top/Left)
    // M11 10v4h4 -> Arrow head
    final head1 = Path();
    head1.moveTo(11 * scale, 10 * scale);
    head1.lineTo(11 * scale, 14 * scale);
    head1.lineTo(15 * scale, 14 * scale);
    canvas.drawPath(head1, paint);

    // m11 14 1.535-1.605a5 5 0 0 1 8 1.5 -> Arc
    final arc1 = Path();
    arc1.moveTo(11 * scale, 14 * scale);
    arc1.lineTo(12.535 * scale, 12.395 * scale);
    arc1.arcToPoint(
      Offset(20.535 * scale, 13.895 * scale), // 12.535+8, 12.395+1.5
      radius: Radius.circular(5 * scale),
      largeArc: false,
      clockwise: true,
    );
    canvas.drawPath(arc1, paint);

    // Arrow 2 (Bottom/Right)
    // M21 22v-4h-4 -> Arrow head
    final head2 = Path();
    head2.moveTo(21 * scale, 22 * scale);
    head2.lineTo(21 * scale, 18 * scale);
    head2.lineTo(17 * scale, 18 * scale);
    canvas.drawPath(head2, paint);

    // m21 18-1.535 1.605a5 5 0 0 1-8-1.5 -> Arc
    final arc2 = Path();
    arc2.moveTo(21 * scale, 18 * scale);
    arc2.lineTo(19.465 * scale, 19.605 * scale);
    arc2.arcToPoint(
      Offset(11.465 * scale, 18.105 * scale), // 19.465-8, 19.605-1.5
      radius: Radius.circular(5 * scale),
      largeArc: false,
      clockwise: true,
    );
    canvas.drawPath(arc2, paint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(CalendarSyncPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.angle != angle ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
