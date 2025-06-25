import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Alarm Smoke Icon - Smoke lines emerge from alarm
class AlarmSmokeIcon extends AnimatedSVGIcon {
  const AlarmSmokeIcon({
    super.key,
    super.size = 100.0,
    super.color,
    super.hoverColor,
    super.animationDuration = const Duration(milliseconds: 1000),
  });

  @override
  String get animationDescription => "Smoke lines emerge from alarm";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
  }) {
    return AlarmSmokePainter(color: color, animationValue: animationValue);
  }
}

/// Painter for Alarm Smoke icon
class AlarmSmokePainter extends CustomPainter {
  final Color color;
  final double animationValue;

  AlarmSmokePainter({required this.color, required this.animationValue});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 2.0
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..style = PaintingStyle.stroke;

    final scale = size.width / 24.0;

    // ========== STATIC PART - ALARM DEVICE ==========

    // Main alarm body (M21 3a1 1 0 0 1 1 1v2a2 2 0 0 1-2 2H4a2 2 0 0 1-2-2V4a1 1 0 0 1 1-1z)
    final alarmBodyPath = Path();
    alarmBodyPath.moveTo(21 * scale, 3 * scale);
    alarmBodyPath.arcToPoint(
      Offset(22 * scale, 4 * scale),
      radius: Radius.circular(1 * scale),
    );
    alarmBodyPath.lineTo(22 * scale, 6 * scale);
    alarmBodyPath.arcToPoint(
      Offset(20 * scale, 8 * scale),
      radius: Radius.circular(2 * scale),
    );
    alarmBodyPath.lineTo(4 * scale, 8 * scale);
    alarmBodyPath.arcToPoint(
      Offset(2 * scale, 6 * scale),
      radius: Radius.circular(2 * scale),
    );
    alarmBodyPath.lineTo(2 * scale, 4 * scale);
    alarmBodyPath.arcToPoint(
      Offset(3 * scale, 3 * scale),
      radius: Radius.circular(1 * scale),
    );
    alarmBodyPath.close();
    canvas.drawPath(alarmBodyPath, paint);

    // Bottom part (m19 8-.8 3a1.25 1.25 0 0 1-1.2 1H7a1.25 1.25 0 0 1-1.2-1L5 8)
    final bottomPath = Path();
    bottomPath.moveTo(19 * scale, 8 * scale);
    bottomPath.relativeLineTo(-0.8 * scale, 3 * scale);
    bottomPath.arcToPoint(
      Offset(17 * scale, 12 * scale),
      radius: Radius.circular(1.25 * scale),
    );
    bottomPath.lineTo(7 * scale, 12 * scale);
    bottomPath.arcToPoint(
      Offset(5.8 * scale, 11 * scale),
      radius: Radius.circular(1.25 * scale),
    );
    bottomPath.lineTo(5 * scale, 8 * scale);
    canvas.drawPath(bottomPath, paint);

    // ========== ANIMATED PART - SMOKE LINES ==========

    // Left smoke (M6 21c0-2.5 2-2.5 2-5)
    final leftSmokePath = Path();
    leftSmokePath.moveTo(6 * scale, 21 * scale);
    leftSmokePath.relativeCubicTo(
      0,
      -2.5 * scale,
      2 * scale,
      -2.5 * scale,
      2 * scale,
      -5 * scale,
    );

    // Middle smoke (M11 21c0-2.5 2-2.5 2-5)
    final middleSmokePath = Path();
    middleSmokePath.moveTo(11 * scale, 21 * scale);
    middleSmokePath.relativeCubicTo(
      0,
      -2.5 * scale,
      2 * scale,
      -2.5 * scale,
      2 * scale,
      -5 * scale,
    );

    // Right smoke (M16 21c0-2.5 2-2.5 2-5)
    final rightSmokePath = Path();
    rightSmokePath.moveTo(16 * scale, 21 * scale);
    rightSmokePath.relativeCubicTo(
      0,
      -2.5 * scale,
      2 * scale,
      -2.5 * scale,
      2 * scale,
      -5 * scale,
    );

    // If not animating, draw complete smoke lines. Otherwise, animate them appearing.
    if (animationValue == 0.0) {
      canvas.drawPath(leftSmokePath, paint);
      canvas.drawPath(middleSmokePath, paint);
      canvas.drawPath(rightSmokePath, paint);
    } else {
      // Animate smoke lines appearing sequentially
      final List<Path> smokePaths = [
        leftSmokePath,
        middleSmokePath,
        rightSmokePath,
      ];

      for (int i = 0; i < smokePaths.length; i++) {
        final delayedProgress = ((animationValue * 3) - i).clamp(0.0, 1.0);

        if (delayedProgress > 0) {
          for (final metric in smokePaths[i].computeMetrics()) {
            final extractPath = metric.extractPath(
              0,
              metric.length * delayedProgress,
            );
            canvas.drawPath(extractPath, paint);
          }
        }
      }
    }
  }

  @override
  bool shouldRepaint(AlarmSmokePainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue;
  }
}
