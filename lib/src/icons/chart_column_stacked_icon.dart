import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Chart Column Stacked Icon - Stacked columns pulse
class ChartColumnStackedIcon extends AnimatedSVGIcon {
  const ChartColumnStackedIcon({
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
  String get animationDescription => "Stacked chart columns pulse";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return ChartColumnStackedPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

/// Painter for Chart Column Stacked icon
class ChartColumnStackedPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  ChartColumnStackedPainter({
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

    // ========== STATIC PART - AXES ==========
    final axisPath = Path();
    axisPath.moveTo(3 * scale, 3 * scale);
    axisPath.lineTo(3 * scale, 19 * scale);
    axisPath.quadraticBezierTo(3 * scale, 21 * scale, 5 * scale, 21 * scale);
    axisPath.lineTo(21 * scale, 21 * scale);
    canvas.drawPath(axisPath, paint);

    // ========== ANIMATED PART - STACKED COLUMNS ==========
    final oscillation = 4 * animationValue * (1 - animationValue);

    // Left column: rect x="7" y="8" width="4" height="9" rx="1"
    // Animate height
    final leftColHeight = 9.0 + oscillation * 2.0;
    final leftColY = 17.0 - leftColHeight;
    final leftCol = RRect.fromRectAndRadius(
      Rect.fromLTWH(7 * scale, leftColY * scale, 4 * scale, leftColHeight * scale),
      Radius.circular(1 * scale),
    );
    canvas.drawRRect(leftCol, paint);

    // Divider line in left column: M11 13H7
    final leftDividerY = leftColY + leftColHeight * 0.55;
    canvas.drawLine(
      Offset(7 * scale, leftDividerY * scale),
      Offset(11 * scale, leftDividerY * scale),
      paint,
    );

    // Right column: rect x="15" y="5" width="4" height="12" rx="1"
    final rightColHeight = 12.0 + oscillation * 2.0;
    final rightColY = 17.0 - rightColHeight;
    final rightCol = RRect.fromRectAndRadius(
      Rect.fromLTWH(15 * scale, rightColY * scale, 4 * scale, rightColHeight * scale),
      Radius.circular(1 * scale),
    );
    canvas.drawRRect(rightCol, paint);

    // Divider line in right column: M19 9h-4
    final rightDividerY = rightColY + rightColHeight * 0.33;
    canvas.drawLine(
      Offset(15 * scale, rightDividerY * scale),
      Offset(19 * scale, rightDividerY * scale),
      paint,
    );
  }

  @override
  bool shouldRepaint(ChartColumnStackedPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
