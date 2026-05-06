import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Astroid Icon - twinkle pulse with a slight rotation on hover/tap
class AstroidIcon extends AnimatedSVGIcon {
  const AstroidIcon({
    super.key,
    super.size = 40.0,
    super.color,
    super.hoverColor,
    super.animationDuration = const Duration(milliseconds: 900),
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
  String get animationDescription => 'Astroid twinkles with a pulse';

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return _AstroidPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

class _AstroidPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  _AstroidPainter({
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

    final double s = size.width / 24.0;
    final double t = animationValue.clamp(0.0, 1.0);

    void drawAstroid() {
      final Path path = Path()
        ..moveTo(12.983 * s, 21.186 * s)
        ..relativeArcToPoint(
          Offset(-1.966 * s, 0),
          radius: Radius.circular(1 * s),
          clockwise: true,
        )
        ..relativeArcToPoint(
          Offset(-8.203 * s, -8.203 * s),
          radius: Radius.circular(10 * s),
          clockwise: false,
        )
        ..relativeArcToPoint(
          Offset(0, -1.966 * s),
          radius: Radius.circular(1 * s),
          clockwise: true,
        )
        ..relativeArcToPoint(
          Offset(8.203 * s, -8.203 * s),
          radius: Radius.circular(10 * s),
          clockwise: false,
        )
        ..relativeArcToPoint(
          Offset(1.966 * s, 0),
          radius: Radius.circular(1 * s),
          clockwise: true,
        )
        ..relativeArcToPoint(
          Offset(8.203 * s, 8.203 * s),
          radius: Radius.circular(10 * s),
          clockwise: false,
        )
        ..relativeArcToPoint(
          Offset(0, 1.966 * s),
          radius: Radius.circular(1 * s),
          clockwise: true,
        )
        ..relativeArcToPoint(
          Offset(-8.203 * s, 8.203 * s),
          radius: Radius.circular(10 * s),
          clockwise: false,
        );
      canvas.drawPath(path, paint);
    }

    if (t == 0.0) {
      drawAstroid();
      return;
    }

    final double pulse = math.sin(math.pi * t);
    final double scale = 1.0 + 0.18 * pulse;
    final double angle = 0.18 * math.sin(2 * math.pi * t);
    final Offset center = Offset(12 * s, 12 * s);

    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(angle);
    canvas.scale(scale, scale);
    canvas.translate(-center.dx, -center.dy);
    drawAstroid();
    canvas.restore();
  }

  @override
  bool shouldRepaint(_AstroidPainter old) =>
      old.color != color ||
      old.animationValue != animationValue ||
      old.strokeWidth != strokeWidth;
}
