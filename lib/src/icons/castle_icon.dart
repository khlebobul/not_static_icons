import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Castle Icon - building up animation
class CastleIcon extends AnimatedSVGIcon {
  const CastleIcon({
    super.key,
    super.size = 40.0,
    super.color,
    super.hoverColor,
    super.animationDuration = const Duration(milliseconds: 1800),
    super.strokeWidth = 2.0,
    super.reverseOnExit = false,
    super.enableTouchInteraction = true,
    super.infiniteLoop = false,
    super.resetToStartOnComplete = true,
  });

  @override
  String get animationDescription => 'Castle: building up animation';

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) =>
      _CastlePainter(
        color: color,
        animationValue: animationValue,
        strokeWidth: strokeWidth,
      );
}

class _CastlePainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  _CastlePainter({
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

    if (animationValue == 0) {
      _drawCompleteIcon(canvas, paint, scale);
    } else {
      _drawAnimated(canvas, paint, scale);
    }
  }

  void _drawCompleteIcon(Canvas canvas, Paint paint, double scale) {
    // M10 5V3
    canvas.drawLine(
      Offset(10 * scale, 5 * scale),
      Offset(10 * scale, 3 * scale),
      paint,
    );

    // M14 5V3
    canvas.drawLine(
      Offset(14 * scale, 5 * scale),
      Offset(14 * scale, 3 * scale),
      paint,
    );

    // M15 21v-3a3 3 0 0 0-6 0v3
    final doorPath = Path()
      ..moveTo(15 * scale, 21 * scale)
      ..lineTo(15 * scale, 18 * scale)
      ..arcToPoint(
        Offset(12 * scale, 15 * scale),
        radius: Radius.circular(3 * scale),
        clockwise: false,
      )
      ..arcToPoint(
        Offset(9 * scale, 18 * scale),
        radius: Radius.circular(3 * scale),
        clockwise: false,
      )
      ..lineTo(9 * scale, 21 * scale);
    canvas.drawPath(doorPath, paint);

    // M18 3v8
    canvas.drawLine(
      Offset(18 * scale, 3 * scale),
      Offset(18 * scale, 11 * scale),
      paint,
    );

    // M18 5H6
    canvas.drawLine(
      Offset(18 * scale, 5 * scale),
      Offset(6 * scale, 5 * scale),
      paint,
    );

    // M22 11H2
    canvas.drawLine(
      Offset(22 * scale, 11 * scale),
      Offset(2 * scale, 11 * scale),
      paint,
    );

    // M22 9v10a2 2 0 0 1-2 2H4a2 2 0 0 1-2-2V9
    final basePath = Path()
      ..moveTo(22 * scale, 9 * scale)
      ..lineTo(22 * scale, 19 * scale)
      ..arcToPoint(
        Offset(20 * scale, 21 * scale),
        radius: Radius.circular(2 * scale),
        clockwise: true,
      )
      ..lineTo(4 * scale, 21 * scale)
      ..arcToPoint(
        Offset(2 * scale, 19 * scale),
        radius: Radius.circular(2 * scale),
        clockwise: true,
      )
      ..lineTo(2 * scale, 9 * scale);
    canvas.drawPath(basePath, paint);

    // M6 3v8
    canvas.drawLine(
      Offset(6 * scale, 3 * scale),
      Offset(6 * scale, 11 * scale),
      paint,
    );
  }

  void _drawAnimated(Canvas canvas, Paint paint, double scale) {
    final t = animationValue;

    // Draw elements progressively from bottom to top
    // Base foundation (appears first)
    if (t >= 0.0) {
      final baseProgress = (t / 0.3).clamp(0.0, 1.0);
      final basePaint = Paint()
        ..color = color.withValues(alpha: baseProgress)
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round
        ..style = PaintingStyle.stroke;

      final basePath = Path()
        ..moveTo(22 * scale, 9 * scale)
        ..lineTo(22 * scale, 19 * scale)
        ..arcToPoint(
          Offset(20 * scale, 21 * scale),
          radius: Radius.circular(2 * scale),
          clockwise: true,
        )
        ..lineTo(4 * scale, 21 * scale)
        ..arcToPoint(
          Offset(2 * scale, 19 * scale),
          radius: Radius.circular(2 * scale),
          clockwise: true,
        )
        ..lineTo(2 * scale, 9 * scale);
      canvas.drawPath(basePath, basePaint);
    }

    // Horizontal line (appears second)
    if (t >= 0.3) {
      final lineProgress = ((t - 0.3) / 0.2).clamp(0.0, 1.0);
      final linePaint = Paint()
        ..color = color.withValues(alpha: lineProgress)
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.round
        ..style = PaintingStyle.stroke;

      canvas.drawLine(
        Offset(22 * scale, 11 * scale),
        Offset(2 * scale, 11 * scale),
        linePaint,
      );
    }

    // Towers (appear third)
    if (t >= 0.5) {
      final towerProgress = ((t - 0.5) / 0.3).clamp(0.0, 1.0);
      final towerPaint = Paint()
        ..color = color.withValues(alpha: towerProgress)
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.round
        ..style = PaintingStyle.stroke;

      // Left tower: M6 3v8
      canvas.drawLine(
        Offset(6 * scale, 3 * scale),
        Offset(6 * scale, 11 * scale),
        towerPaint,
      );

      // Right tower: M18 3v8
      canvas.drawLine(
        Offset(18 * scale, 3 * scale),
        Offset(18 * scale, 11 * scale),
        towerPaint,
      );

      // Top horizontal line: M18 5H6
      canvas.drawLine(
        Offset(18 * scale, 5 * scale),
        Offset(6 * scale, 5 * scale),
        towerPaint,
      );
    }

    // Door (appears fourth)
    if (t >= 0.8) {
      final doorProgress = ((t - 0.8) / 0.1).clamp(0.0, 1.0);
      final doorPaint = Paint()
        ..color = color.withValues(alpha: doorProgress)
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round
        ..style = PaintingStyle.stroke;

      final doorPath = Path()
        ..moveTo(15 * scale, 21 * scale)
        ..lineTo(15 * scale, 18 * scale)
        ..arcToPoint(
          Offset(12 * scale, 15 * scale),
          radius: Radius.circular(3 * scale),
          clockwise: false,
        )
        ..arcToPoint(
          Offset(9 * scale, 18 * scale),
          radius: Radius.circular(3 * scale),
          clockwise: false,
        )
        ..lineTo(9 * scale, 21 * scale);
      canvas.drawPath(doorPath, doorPaint);
    }

    // Flags (appear last)
    if (t >= 0.9) {
      final flagProgress = ((t - 0.9) / 0.1).clamp(0.0, 1.0);
      final flagPaint = Paint()
        ..color = color.withValues(alpha: flagProgress)
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.round
        ..style = PaintingStyle.stroke;

      // M10 5V3
      canvas.drawLine(
        Offset(10 * scale, 5 * scale),
        Offset(10 * scale, 3 * scale),
        flagPaint,
      );

      // M14 5V3
      canvas.drawLine(
        Offset(14 * scale, 5 * scale),
        Offset(14 * scale, 3 * scale),
        flagPaint,
      );
    }
  }

  @override
  bool shouldRepaint(_CastlePainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
