import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Chart Column Big Icon - Columns grow and shrink
class ChartColumnBigIcon extends AnimatedSVGIcon {
  const ChartColumnBigIcon({
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
  String get animationDescription => "Chart columns grow and shrink";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return ChartColumnBigPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

/// Painter for Chart Column Big icon
class ChartColumnBigPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  ChartColumnBigPainter({
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

    // ========== ANIMATED PART - COLUMNS ==========
    final oscillation = 4 * animationValue * (1 - animationValue);

    // Right column (taller): rect x="15" y="5" width="4" height="12" rx="1"
    // Grows taller (y decreases, height increases)
    final rightColY = 5.0 - oscillation * 2.0;
    final rightColHeight = 12.0 + oscillation * 2.0;
    final rightCol = RRect.fromRectAndRadius(
      Rect.fromLTWH(
          15 * scale, rightColY * scale, 4 * scale, rightColHeight * scale),
      Radius.circular(1 * scale),
    );
    canvas.drawRRect(rightCol, paint);

    // Left column (shorter): rect x="7" y="8" width="4" height="9" rx="1"
    // Shrinks (y increases, height decreases)
    final leftColY = 8.0 + oscillation * 2.0;
    final leftColHeight = 9.0 - oscillation * 2.0;
    final leftCol = RRect.fromRectAndRadius(
      Rect.fromLTWH(
          7 * scale, leftColY * scale, 4 * scale, leftColHeight * scale),
      Radius.circular(1 * scale),
    );
    canvas.drawRRect(leftCol, paint);
  }

  @override
  bool shouldRepaint(ChartColumnBigPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
