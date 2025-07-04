import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

class ArrowUpNarrowWideIcon extends AnimatedSVGIcon {
  const ArrowUpNarrowWideIcon({
    super.key,
    super.size = 40,
    super.color = Colors.black,
    super.animationDuration = const Duration(milliseconds: 1500),
    super.strokeWidth = 2.0,
  });

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return _ArrowUpNarrowWidePainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }

  @override
  String get animationDescription =>
      'Lines disappearing and reappearing from narrow to wide upward';
}

class _ArrowUpNarrowWidePainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  _ArrowUpNarrowWidePainter({
    required this.color,
    required this.animationValue,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth / 1.7
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final scaleX = size.width / 24;
    final scaleY = size.height / 24;
    canvas.scale(scaleX, scaleY);

    // Static arrow (no movement)
    final arrowHeadPath = Path();
    arrowHeadPath.moveTo(3, 8);
    arrowHeadPath.lineTo(7, 4);
    arrowHeadPath.lineTo(11, 8);
    canvas.drawPath(arrowHeadPath, paint);

    final arrowLinePath = Path();
    arrowLinePath.moveTo(7, 4);
    arrowLinePath.lineTo(7, 20);
    canvas.drawPath(arrowLinePath, paint);

    // Animated lines with opacity - start visible, then animate
    double opacity1, opacity2, opacity3;

    if (animationValue == 0) {
      // Initial state - all lines visible
      opacity1 = opacity2 = opacity3 = 1.0;
    } else if (animationValue <= 0.2) {
      // Fade out all lines
      double fadeOut = 1.0 - (animationValue / 0.2);
      opacity1 = opacity2 = opacity3 = fadeOut;
    } else if (animationValue <= 0.8) {
      // Lines grow from bottom to top: longest (bottom) -> medium -> shortest (top)
      double progress = (animationValue - 0.2) / 0.6;
      opacity3 = (progress * 3).clamp(0.0, 1.0); // Longest (bottom) grows first
      opacity2 = ((progress - 0.33) * 3).clamp(0.0, 1.0); // Medium grows second
      opacity1 = ((progress - 0.66) * 3).clamp(
        0.0,
        1.0,
      ); // Shortest (top) grows last
    } else {
      // Fade back to all visible
      double fadeIn = (animationValue - 0.8) / 0.2;
      opacity1 = opacity2 = opacity3 = fadeIn;
    }

    // Line 1 (shortest) - closest to arrow
    final paint1 = Paint()
      ..color = color.withValues(alpha: opacity1)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth / 1.7
      ..strokeCap = StrokeCap.round;

    final line1Path = Path();
    line1Path.moveTo(11, 12);
    line1Path.lineTo(15, 12);
    canvas.drawPath(line1Path, paint1);

    // Line 2 (medium)
    final paint2 = Paint()
      ..color = color.withValues(alpha: opacity2)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth / 1.7
      ..strokeCap = StrokeCap.round;

    final line2Path = Path();
    line2Path.moveTo(11, 16);
    line2Path.lineTo(18, 16);
    canvas.drawPath(line2Path, paint2);

    // Line 3 (longest)
    final paint3 = Paint()
      ..color = color.withValues(alpha: opacity3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth / 1.7
      ..strokeCap = StrokeCap.round;

    final line3Path = Path();
    line3Path.moveTo(11, 20);
    line3Path.lineTo(21, 20);
    canvas.drawPath(line3Path, paint3);
  }

  @override
  bool shouldRepaint(covariant _ArrowUpNarrowWidePainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
