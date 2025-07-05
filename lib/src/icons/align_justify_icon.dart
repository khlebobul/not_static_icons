import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

class AlignJustifyIcon extends AnimatedSVGIcon {
  const AlignJustifyIcon({
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
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return AlignJustifyPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }

  @override
  String get animationDescription =>
      'Lines draw sequentially from left to right, starting from top';
}

class AlignJustifyPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  AlignJustifyPainter({
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
      ..style = PaintingStyle.stroke;

    final scale = size.width / 24;

    final leftX = 3 * scale;
    final rightX = 21 * scale;

    if (animationValue == 0.0) {
      // Static state: show original full lines
      canvas.drawLine(
        Offset(leftX, 6 * scale),
        Offset(rightX, 6 * scale),
        paint,
      );
      canvas.drawLine(
        Offset(leftX, 12 * scale),
        Offset(rightX, 12 * scale),
        paint,
      );
      canvas.drawLine(
        Offset(leftX, 18 * scale),
        Offset(rightX, 18 * scale),
        paint,
      );
    } else {
      // Animation state: lines draw sequentially from left to right

      // Top line: draws first (0.0 - 0.33)
      final topProgress = (animationValue * 3).clamp(0.0, 1.0);
      final topRightX = Tween<double>(
        begin: leftX,
        end: rightX,
      ).transform(topProgress);

      canvas.drawLine(
        Offset(leftX, 6 * scale),
        Offset(topRightX, 6 * scale),
        paint,
      );

      // Middle line: draws second (0.33 - 0.66)
      if (animationValue > 0.33) {
        final middleProgress = ((animationValue - 0.33) * 3).clamp(0.0, 1.0);
        final middleRightX = Tween<double>(
          begin: leftX,
          end: rightX,
        ).transform(middleProgress);

        canvas.drawLine(
          Offset(leftX, 12 * scale),
          Offset(middleRightX, 12 * scale),
          paint,
        );
      }

      // Bottom line: draws third (0.66 - 1.0)
      if (animationValue > 0.66) {
        final bottomProgress = ((animationValue - 0.66) * 3).clamp(0.0, 1.0);
        final bottomRightX = Tween<double>(
          begin: leftX,
          end: rightX,
        ).transform(bottomProgress);

        canvas.drawLine(
          Offset(leftX, 18 * scale),
          Offset(bottomRightX, 18 * scale),
          paint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
