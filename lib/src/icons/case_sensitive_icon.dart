import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../core/animated_svg_icon_base.dart';

/// Animated Case Sensitive Icon - Letters bounce
class CaseSensitiveIcon extends AnimatedSVGIcon {
  const CaseSensitiveIcon({
    super.key,
    super.size = 40.0,
    super.color,
    super.hoverColor,
    super.animationDuration = const Duration(milliseconds: 800),
    super.strokeWidth = 2.0,
    super.reverseOnExit = false,
    super.enableTouchInteraction = true,
    super.infiniteLoop = false,
  });

  @override
  String get animationDescription => "Letters bounce";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    // Bounce sequentially
    double bounce1 = 0.0;
    double bounce2 = 0.0;

    if (animationValue < 0.5) {
      final t = animationValue * 2;
      bounce1 = math.sin(t * math.pi) * 2.0;
    } else {
      final t = (animationValue - 0.5) * 2;
      bounce2 = math.sin(t * math.pi) * 2.0;
    }

    return CaseSensitivePainter(
      color: color,
      bounce1: bounce1,
      bounce2: bounce2,
      strokeWidth: strokeWidth,
    );
  }
}

class CaseSensitivePainter extends CustomPainter {
  final Color color;
  final double bounce1;
  final double bounce2;
  final double strokeWidth;

  CaseSensitivePainter({
    required this.color,
    required this.bounce1,
    required this.bounce2,
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

    // Letter 1: 'A'
    // m2 16 4.039-9.69a.5.5 0 0 1 .923 0L11 16
    // M3.304 13h6.392
    canvas.save();
    canvas.translate(0, -bounce1 * scale);

    final pathA = Path();
    pathA.moveTo(2 * scale, 16 * scale);
    pathA.lineTo(6.039 * scale, 6.31 * scale);
    // a.5.5 0 0 1 .923 0
    pathA.arcToPoint(Offset(6.962 * scale, 6.31 * scale),
        radius: Radius.circular(0.5 * scale), clockwise: true);
    pathA.lineTo(11 * scale, 16 * scale);
    canvas.drawPath(pathA, paint);

    canvas.drawLine(Offset(3.304 * scale, 13 * scale),
        Offset(9.696 * scale, 13 * scale), paint);

    canvas.restore();

    // Letter 2: 'a'
    // M22 9v7
    // circle cx="18.5" cy="12.5" r="3.5"
    canvas.save();
    canvas.translate(0, -bounce2 * scale);

    canvas.drawLine(
        Offset(22 * scale, 9 * scale), Offset(22 * scale, 16 * scale), paint);
    canvas.drawCircle(Offset(18.5 * scale, 12.5 * scale), 3.5 * scale, paint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(CaseSensitivePainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.bounce1 != bounce1 ||
        oldDelegate.bounce2 != bounce2 ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
