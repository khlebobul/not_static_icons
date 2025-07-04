import 'dart:math';
import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Archive Restore Icon - Arrow moving up and down
class ArchiveRestoreIcon extends AnimatedSVGIcon {
  const ArchiveRestoreIcon({
    super.key,
    super.size = 40.0,
    super.color,
    super.hoverColor,
    super.animationDuration = const Duration(milliseconds: 1500),
    super.strokeWidth = 2.0,
  });

  @override
  String get animationDescription =>
      "Lid opening and arrow moving up and down for restore action";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return ArchiveRestorePainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

/// Painter for Archive Restore icon
class ArchiveRestorePainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  ArchiveRestorePainter({
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

    // Calculate arrow movement - up and down (smaller movement)
    final arrowOffset =
        sin(animationValue * pi) *
        0.8 *
        scale; // 0 to +0.8 units movement upward

    // Calculate lid opening angle - only upward opening, then closing
    final openAngle =
        -sin(animationValue * pi) *
        0.08; // 0 to -4.6 degrees opening (upward only)

    // Draw the animated lid with opening effect
    canvas.save();

    // Pivot point at the back edge of the lid for opening effect
    final lidPivot = Offset(2 * scale, 3 * scale);
    canvas.translate(lidPivot.dx, lidPivot.dy);
    canvas.rotate(openAngle);
    canvas.translate(-lidPivot.dx, -lidPivot.dy);

    // Draw the lid: rect width="20" height="5" x="2" y="3" rx="1"
    final lidRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(2 * scale, 3 * scale, 20 * scale, 5 * scale),
      Radius.circular(1 * scale),
    );
    canvas.drawRRect(lidRect, paint);

    canvas.restore();

    // Draw the left archive body: M4 8v11a2 2 0 0 0 2 2h2
    final leftBodyPath = Path();
    leftBodyPath.moveTo(4 * scale, 8 * scale);
    leftBodyPath.lineTo(4 * scale, 19 * scale);
    leftBodyPath.cubicTo(
      4 * scale,
      20.1 * scale,
      4.9 * scale,
      21 * scale,
      6 * scale,
      21 * scale,
    );
    leftBodyPath.lineTo(8 * scale, 21 * scale);
    canvas.drawPath(leftBodyPath, paint);

    // Draw the right archive body: M20 8v11a2 2 0 0 1-2 2h-2
    final rightBodyPath = Path();
    rightBodyPath.moveTo(20 * scale, 8 * scale);
    rightBodyPath.lineTo(20 * scale, 19 * scale);
    rightBodyPath.cubicTo(
      20 * scale,
      20.1 * scale,
      19.1 * scale,
      21 * scale,
      18 * scale,
      21 * scale,
    );
    rightBodyPath.lineTo(16 * scale, 21 * scale);
    canvas.drawPath(rightBodyPath, paint);

    // Draw animated arrow with vertical movement
    canvas.save();
    canvas.translate(0, -arrowOffset); // Move arrow up and down

    // Draw the arrow head: m9 15 3-3 3 3
    final arrowHeadPath = Path();
    arrowHeadPath.moveTo(9 * scale, 15 * scale);
    arrowHeadPath.lineTo(12 * scale, 12 * scale);
    arrowHeadPath.lineTo(15 * scale, 15 * scale);
    canvas.drawPath(arrowHeadPath, paint);

    // Draw the arrow shaft: M12 12v9
    final arrowShaftPath = Path();
    arrowShaftPath.moveTo(12 * scale, 12 * scale);
    arrowShaftPath.lineTo(12 * scale, 21 * scale);
    canvas.drawPath(arrowShaftPath, paint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(ArchiveRestorePainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
