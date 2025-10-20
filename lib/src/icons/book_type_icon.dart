import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Book Type Icon - letter T drawing animation
class BookTypeIcon extends AnimatedSVGIcon {
  const BookTypeIcon({
    super.key,
    super.size = 40.0,
    super.color,
    super.hoverColor,
    super.animationDuration = const Duration(milliseconds: 1600),
    super.strokeWidth = 2.0,
    super.reverseOnExit = false,
    super.enableTouchInteraction = true,
    super.infiniteLoop = false,
    super.resetToStartOnComplete = true,
  });

  @override
  String get animationDescription => 'BookType: letter T drawing animation';

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) =>
      _BookTypePainter(
        color: color,
        animationValue: animationValue,
        strokeWidth: strokeWidth,
      );
}

class _BookTypePainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  _BookTypePainter({
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
      _drawBookOutline(canvas, paint, scale);
      _drawAnimatedT(canvas, paint, scale);
    }
  }

  void _drawCompleteIcon(Canvas canvas, Paint paint, double scale) {
    _drawBookOutline(canvas, paint, scale);

    // Top horizontal: M16 8V6H8v2
    canvas.drawLine(
        Offset(16 * scale, 6 * scale), Offset(8 * scale, 6 * scale), paint);
    canvas.drawLine(
        Offset(16 * scale, 6 * scale), Offset(16 * scale, 8 * scale), paint);
    canvas.drawLine(
        Offset(8 * scale, 6 * scale), Offset(8 * scale, 8 * scale), paint);

    // Vertical stem: M12 6v7
    canvas.drawLine(
        Offset(12 * scale, 6 * scale), Offset(12 * scale, 13 * scale), paint);

    // Bottom horizontal: M10 13h4
    canvas.drawLine(
        Offset(10 * scale, 13 * scale), Offset(14 * scale, 13 * scale), paint);
  }

  void _drawBookOutline(Canvas canvas, Paint paint, double scale) {
    final bookPath = Path();

    bookPath.moveTo(4 * scale, 19.5 * scale);
    bookPath.lineTo(4 * scale, 4.5 * scale);
    bookPath.arcToPoint(
      Offset(6.5 * scale, 2 * scale),
      radius: Radius.circular(2.5 * scale),
      clockwise: true,
    );
    bookPath.lineTo(19 * scale, 2 * scale);
    bookPath.arcToPoint(
      Offset(20 * scale, 3 * scale),
      radius: Radius.circular(1 * scale),
      clockwise: true,
    );
    bookPath.lineTo(20 * scale, 21 * scale);
    bookPath.arcToPoint(
      Offset(19 * scale, 22 * scale),
      radius: Radius.circular(1 * scale),
      clockwise: true,
    );
    bookPath.lineTo(6.5 * scale, 22 * scale);
    bookPath.arcToPoint(
      Offset(6.5 * scale, 17 * scale),
      radius: Radius.circular(1 * scale),
      clockwise: true,
    );
    bookPath.lineTo(20 * scale, 17 * scale);

    canvas.drawPath(bookPath, paint);
  }

  void _drawAnimatedT(Canvas canvas, Paint paint, double scale) {
    final progress = animationValue;

    // Phase 1: Top horizontal bar (0.0 - 0.3)
    if (progress > 0.0) {
      final topProgress = (progress / 0.3).clamp(0.0, 1.0);

      // Draw top horizontal from center outwards
      final leftEnd = Offset.lerp(
        Offset(12 * scale, 6 * scale),
        Offset(8 * scale, 6 * scale),
        topProgress,
      )!;
      final rightEnd = Offset.lerp(
        Offset(12 * scale, 6 * scale),
        Offset(16 * scale, 6 * scale),
        topProgress,
      )!;

      canvas.drawLine(leftEnd, rightEnd, paint);

      // Side verticals
      canvas.drawLine(Offset(16 * scale, 6 * scale),
          Offset(16 * scale, 6 * scale + 2 * scale * topProgress), paint);
      canvas.drawLine(Offset(8 * scale, 6 * scale),
          Offset(8 * scale, 6 * scale + 2 * scale * topProgress), paint);
    }

    // Phase 2: Vertical stem (0.3 - 0.7)
    if (progress > 0.3) {
      final stemProgress = ((progress - 0.3) / 0.4).clamp(0.0, 1.0);
      final stemEnd = Offset.lerp(
        Offset(12 * scale, 6 * scale),
        Offset(12 * scale, 13 * scale),
        stemProgress,
      )!;

      canvas.drawLine(Offset(12 * scale, 6 * scale), stemEnd, paint);
    }

    // Phase 3: Bottom horizontal (0.7 - 1.0)
    if (progress > 0.7) {
      final bottomProgress = ((progress - 0.7) / 0.3).clamp(0.0, 1.0);

      final leftEnd = Offset.lerp(
        Offset(12 * scale, 13 * scale),
        Offset(10 * scale, 13 * scale),
        bottomProgress,
      )!;
      final rightEnd = Offset.lerp(
        Offset(12 * scale, 13 * scale),
        Offset(14 * scale, 13 * scale),
        bottomProgress,
      )!;

      canvas.drawLine(leftEnd, rightEnd, paint);
    }
  }

  @override
  bool shouldRepaint(_BookTypePainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
