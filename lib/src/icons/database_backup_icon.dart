import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Database Backup Icon - backup arrow rotates around the restore circle
class DatabaseBackupIcon extends AnimatedSVGIcon {
  const DatabaseBackupIcon({
    super.key,
    super.size = 40.0,
    super.color,
    super.hoverColor,
    super.animationDuration = const Duration(milliseconds: 1000),
    super.strokeWidth = 2.0,
    super.reverseOnExit = false,
    super.enableTouchInteraction = true,
    super.infiniteLoop = false,
    super.resetToStartOnComplete = true,
    super.onTap,
    super.interactive,
    super.controller,
  });

  @override
  String get animationDescription => 'Backup arrow rotates around database';

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) =>
      _DatabaseBackupPainter(color, animationValue, strokeWidth);
}

class _DatabaseBackupPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  _DatabaseBackupPainter(this.color, this.animationValue, this.strokeWidth);

  @override
  void paint(Canvas canvas, Size size) {
    final s = size.width / 24.0;
    final paint = _strokePaint(color, strokeWidth);
    final t = animationValue.clamp(0.0, 1.0);

    _drawDatabaseTop(canvas, s, paint);
    final middle = Path()
      ..moveTo(3 * s, 12 * s)
      ..arcToPoint(
        Offset(8 * s, 14.69 * s),
        radius: Radius.elliptical(9 * s, 3 * s),
        clockwise: false,
      );
    canvas.drawPath(middle, paint);
    canvas.drawLine(Offset(21 * s, 9.3 * s), Offset(21 * s, 5 * s), paint);
    final left = Path()
      ..moveTo(3 * s, 5 * s)
      ..lineTo(3 * s, 19 * s)
      ..arcToPoint(
        Offset(9.47 * s, 21.88 * s),
        radius: Radius.elliptical(9 * s, 3 * s),
        clockwise: false,
      );
    canvas.drawPath(left, paint);

    final center = Offset(17 * s, 17 * s);
    final angle = t == 0.0 ? 0.0 : math.sin(math.pi * t) * -0.55;
    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(angle);
    canvas.translate(-center.dx, -center.dy);
    canvas.drawLine(Offset(12 * s, 12 * s), Offset(12 * s, 16 * s), paint);
    canvas.drawLine(Offset(12 * s, 16 * s), Offset(16 * s, 16 * s), paint);
    final restore = Path()
      ..moveTo(13 * s, 20 * s)
      ..arcToPoint(
        Offset(22 * s, 17 * s),
        radius: Radius.circular(5 * s),
        clockwise: false,
      )
      ..arcToPoint(
        Offset(17.5 * s, 12.5 * s),
        radius: Radius.circular(4.5 * s),
        clockwise: false,
      )
      ..cubicTo(16.17 * s, 12.5 * s, 14.96 * s, 13.04 * s, 14.09 * s, 13.91 * s)
      ..lineTo(12 * s, 16 * s);
    canvas.drawPath(restore, paint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(_DatabaseBackupPainter old) =>
      old.color != color ||
      old.animationValue != animationValue ||
      old.strokeWidth != strokeWidth;
}

Paint _strokePaint(Color color, double strokeWidth) {
  return Paint()
    ..color = color
    ..strokeWidth = strokeWidth
    ..strokeCap = StrokeCap.round
    ..strokeJoin = StrokeJoin.round
    ..style = PaintingStyle.stroke;
}

void _drawDatabaseTop(Canvas canvas, double s, Paint paint) {
  canvas.drawOval(
    Rect.fromCenter(
      center: Offset(12 * s, 5 * s),
      width: 18 * s,
      height: 6 * s,
    ),
    paint,
  );
}
