import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Coins Icon - Coins bounce
class CoinsIcon extends AnimatedSVGIcon {
  const CoinsIcon({
    super.key,
    super.size = 40.0,
    super.color,
    super.hoverColor,
    super.animationDuration = const Duration(milliseconds: 600),
    super.strokeWidth = 2.0,
    super.reverseOnExit = false,
    super.enableTouchInteraction = true,
    super.infiniteLoop = false,
    super.onTap,
    super.interactive,
    super.controller,
  });

  @override
  String get animationDescription => "Coins bounce";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return CoinsPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

class CoinsPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  CoinsPainter({
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

    // Animation - front coin bounces up
    final oscillation = 4 * animationValue * (1 - animationValue);
    final bounceOffset = oscillation * 2.0;

    // Back coin (static) - partial circle arc
    // M13.744 17.736a6 6 0 1 1-7.48-7.48
    final backCoinPath = Path();
    backCoinPath.moveTo(13.744 * scale, 17.736 * scale);
    backCoinPath.arcToPoint(
      Offset(6.264 * scale, 10.256 * scale),
      radius: Radius.circular(6 * scale),
      largeArc: true,
      clockwise: true,
    );
    canvas.drawPath(backCoinPath, paint);

    // Back coin detail lines (static)
    // M15 6h1v4 (vertical line on back coin)
    // Actually this is a line of detail on the back coin
    // But let me place it with slight offset - it's a marking
    // M6.134 14.768.866-.5 2 3.464
    // This is: M6.134 14.768 l0.866 -0.5 l2 3.464
    final backDetailPath = Path();
    backDetailPath.moveTo(6.134 * scale, 14.768 * scale);
    backDetailPath.lineTo(7 * scale, 14.268 * scale);
    backDetailPath.lineTo(9 * scale, 17.732 * scale);
    canvas.drawPath(backDetailPath, paint);

    // Front coin (animated - bounces)
    canvas.save();
    canvas.translate(0, -bounceOffset * scale);

    // Front coin circle: cx="16" cy="8" r="6"
    canvas.drawCircle(
      Offset(16 * scale, 8 * scale),
      6 * scale,
      paint,
    );

    // Front coin detail: M15 6h1v4
    // Vertical line inside front coin
    canvas.drawLine(
      Offset(15 * scale, 6 * scale),
      Offset(16 * scale, 6 * scale),
      paint,
    );
    canvas.drawLine(
      Offset(16 * scale, 6 * scale),
      Offset(16 * scale, 10 * scale),
      paint,
    );

    canvas.restore();
  }

  @override
  bool shouldRepaint(CoinsPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
