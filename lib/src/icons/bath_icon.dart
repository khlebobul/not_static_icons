import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Bath Icon - original tub and pipe; water droplets fall from the shower
class BathIcon extends AnimatedSVGIcon {
  const BathIcon({
    super.key,
    super.size = 40.0,
    super.color,
    super.hoverColor,
    super.animationDuration = const Duration(milliseconds: 1200),
    super.strokeWidth = 2.0,
    super.reverseOnExit = false,
    super.enableTouchInteraction = true,
    super.infiniteLoop = false,
    super.resetToStartOnComplete = true,
  });

  @override
  String get animationDescription =>
      'Bath: water droplets fall from the shower then return to original';

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return _BathPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

class _BathPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  _BathPainter({
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

    _drawOriginal(canvas, scale, paint);

    if (animationValue > 0.0) {
      _drawDroplets(canvas, scale, paint, animationValue);
    }
  }

  void _drawOriginal(Canvas canvas, double scale, Paint paint) {
    // Path d="M10 4 8 6"
    canvas.drawLine(
      Offset(10 * scale, 4 * scale),
      Offset(8 * scale, 6 * scale),
      paint,
    );

    // Path d="M17 19v2" and d="M7 19v2"
    canvas.drawLine(
      Offset(17 * scale, 19 * scale),
      Offset(17 * scale, 21 * scale),
      paint,
    );
    canvas.drawLine(
      Offset(7 * scale, 19 * scale),
      Offset(7 * scale, 21 * scale),
      paint,
    );

    // Path d="M2 12h20"
    canvas.drawLine(
      Offset(2 * scale, 12 * scale),
      Offset(22 * scale, 12 * scale),
      paint,
    );

    // Path d="M9 5 7.621 3.621 A2.121 2.121 0 0 0 4 5 v12 a2 2 0 0 0 2 2 h12 a2 2 0 0 0 2-2 v-5"
    final tub = Path()
      ..moveTo(9 * scale, 5 * scale)
      ..lineTo(7.621 * scale, 3.621 * scale)
      ..arcToPoint(
        Offset(4 * scale, 5 * scale),
        radius: Radius.circular(2.121 * scale),
        clockwise: false,
      )
      ..lineTo(4 * scale, 17 * scale)
      ..arcToPoint(
        Offset(6 * scale, 19 * scale),
        radius: Radius.circular(2 * scale),
        clockwise: false,
      )
      ..lineTo(18 * scale, 19 * scale)
      ..arcToPoint(
        Offset(20 * scale, 17 * scale),
        radius: Radius.circular(2 * scale),
        clockwise: false,
      )
      ..lineTo(20 * scale, 12 * scale);
    canvas.drawPath(tub, paint);
  }

  void _drawDroplets(Canvas canvas, double scale, Paint paint, double tGlobal) {
    // Three droplets falling from near the shower spout (around x ~ 9, y ~ 6)
    // Each droplet uses a phase offset so they are staggered
    final origins = <Offset>[
      Offset(9 * scale, 6.2 * scale),
      Offset(9.8 * scale, 6.0 * scale),
      Offset(8.2 * scale, 6.0 * scale),
    ];
    final endY = 12 * scale; // stop at the rim line

    for (int i = 0; i < origins.length; i++) {
      final phase = (tGlobal + i * 0.33) % 1.0;
      // ease-in for fall
      final p = phase < 0.5 ? (phase / 0.5) * (phase / 0.5) : 1.0;
      final start = origins[i];
      final y = start.dy + (endY - start.dy) * p;

      // small droplet segment
      final dropLen = 0.9 * scale;
      final dropPaint = Paint()
        ..color = color.withValues(alpha: 0.6 + 0.4 * (1.0 - p))
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round
        ..style = PaintingStyle.stroke;

      canvas.drawLine(
        Offset(start.dx, y - dropLen / 2),
        Offset(start.dx, y + dropLen / 2),
        dropPaint,
      );
    }
  }

  @override
  bool shouldRepaint(_BathPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
