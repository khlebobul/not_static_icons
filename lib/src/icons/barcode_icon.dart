import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Barcode Icon - original five vertical lines; lines blink
class BarcodeIcon extends AnimatedSVGIcon {
  const BarcodeIcon({
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
  String get animationDescription =>
      'Barcode: lines blink with staggered phases, then return to original';

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return _BarcodePainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

class _BarcodePainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  _BarcodePainter({
    required this.color,
    required this.animationValue,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final basePaint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..style = PaintingStyle.stroke;

    final scale = size.width / 24.0;
    final topY = 5 * scale;
    final bottomY = 19 * scale; // 5 + 14
    final xs = <double>[3, 8, 12, 17, 21].map((x) => x * scale).toList();

    if (animationValue == 0.0) {
      for (final x in xs) {
        canvas.drawLine(Offset(x, topY), Offset(x, bottomY), basePaint);
      }
      return;
    }

    // Blink each line with a phase offset; never fully invisible
    const double minAlpha = 0.3;
    for (int i = 0; i < xs.length; i++) {
      final phase = (animationValue + i / xs.length) % 1.0;
      final tri = phase < 0.5 ? (phase / 0.5) : (1 - (phase - 0.5) / 0.5);
      final linePaint = Paint()
        ..color = color.withValues(alpha: minAlpha + (1.0 - minAlpha) * tri)
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round
        ..style = PaintingStyle.stroke;
      final x = xs[i];
      canvas.drawLine(Offset(x, topY), Offset(x, bottomY), linePaint);
    }
  }

  @override
  bool shouldRepaint(_BarcodePainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
