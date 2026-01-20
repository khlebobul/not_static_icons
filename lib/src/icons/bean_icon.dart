import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Bean Icon - exact bean geometry; inner arc draws progressively
class BeanIcon extends AnimatedSVGIcon {
  const BeanIcon({
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
  String get animationDescription => 'Bean: inner arc draws from 0% to 100%';

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return _BeanPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

class _BeanPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  _BeanPainter({
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

    final outer = _buildOuterPath(scale);
    final innerArc = _buildInnerArcPath(scale);

    // Always draw outer path fully
    canvas.drawPath(outer, paint);

    if (animationValue == 0.0) {
      // Draw inner arc fully at rest
      canvas.drawPath(innerArc, paint);
      return;
    }

    // Draw inner arc progressively using path metrics
    final metrics = innerArc.computeMetrics();
    for (final m in metrics) {
      final len = m.length;
      final sub = m.extractPath(0.0, len * animationValue);
      canvas.drawPath(sub, paint);
    }
  }

  Path _buildOuterPath(double scale) {
    // M10.165 6.598 C9.954 7.478 9.64 8.36 9 9 c-.64 .64 -1.521 .954 -2.402 1.165 A6 6 0 0 0 8 22 c7.732 0 14 -6.268 14 -14 a6 6 0 0 0 -11.835 -1.402 Z
    final p = Path()
      ..moveTo(10.165 * scale, 6.598 * scale)
      ..cubicTo(9.954 * scale, 7.478 * scale, 9.64 * scale, 8.36 * scale,
          9 * scale, 9 * scale)
      ..relativeCubicTo(-0.64 * scale, 0.64 * scale, -1.521 * scale,
          0.954 * scale, -2.402 * scale, 1.165 * scale)
      ..arcToPoint(Offset(8 * scale, 22 * scale),
          radius: Radius.circular(6 * scale), clockwise: false)
      ..relativeCubicTo(
          7.732 * scale, 0, 14 * scale, -6.268 * scale, 14 * scale, -14 * scale)
      ..relativeArcToPoint(Offset(-11.835 * scale, -1.402 * scale),
          radius: Radius.circular(6 * scale), clockwise: false)
      ..close();
    return p;
  }

  Path _buildInnerArcPath(double scale) {
    // M5.341 10.62 a4 4 0 1 0 5.279 -5.28
    final p = Path()
      ..moveTo(5.341 * scale, 10.62 * scale)
      ..relativeArcToPoint(Offset(5.279 * scale, -5.28 * scale),
          radius: Radius.circular(4 * scale),
          rotation: 0,
          largeArc: true,
          clockwise: false);
    return p;
  }

  @override
  bool shouldRepaint(_BeanPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
