import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Chart Candlestick Icon - Candles move up and down
class ChartCandlestickIcon extends AnimatedSVGIcon {
  const ChartCandlestickIcon({
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
  String get animationDescription => "Candlesticks move up and down";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return ChartCandlestickPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

/// Painter for Chart Candlestick icon
class ChartCandlestickPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  ChartCandlestickPainter({
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

    // ========== STATIC PART - AXES ==========
    final axisPath = Path();
    axisPath.moveTo(3 * scale, 3 * scale);
    axisPath.lineTo(3 * scale, 19 * scale);
    axisPath.quadraticBezierTo(3 * scale, 21 * scale, 5 * scale, 21 * scale);
    axisPath.lineTo(21 * scale, 21 * scale);
    canvas.drawPath(axisPath, paint);

    // ========== ANIMATED PART - CANDLESTICKS ==========
    final oscillation = 4 * animationValue * (1 - animationValue);

    // Left candle moves down, right candle moves up
    final leftOffset = oscillation * 2.0;
    final rightOffset = -oscillation * 2.0;

    // Left candlestick (at x=9)
    // Top wick: M9 5v4
    canvas.drawLine(
      Offset(9 * scale, (5 + leftOffset) * scale),
      Offset(9 * scale, (9 + leftOffset) * scale),
      paint,
    );

    // Body: rect width="4" height="6" x="7" y="9" rx="1"
    final leftBody = RRect.fromRectAndRadius(
      Rect.fromLTWH(7 * scale, (9 + leftOffset) * scale, 4 * scale, 6 * scale),
      Radius.circular(1 * scale),
    );
    canvas.drawRRect(leftBody, paint);

    // Bottom wick: M9 15v2
    canvas.drawLine(
      Offset(9 * scale, (15 + leftOffset) * scale),
      Offset(9 * scale, (17 + leftOffset) * scale),
      paint,
    );

    // Right candlestick (at x=17)
    // Top wick: M17 3v2
    canvas.drawLine(
      Offset(17 * scale, (3 + rightOffset) * scale),
      Offset(17 * scale, (5 + rightOffset) * scale),
      paint,
    );

    // Body: rect width="4" height="8" x="15" y="5" rx="1"
    final rightBody = RRect.fromRectAndRadius(
      Rect.fromLTWH(
          15 * scale, (5 + rightOffset) * scale, 4 * scale, 8 * scale),
      Radius.circular(1 * scale),
    );
    canvas.drawRRect(rightBody, paint);

    // Bottom wick: M17 13v3
    canvas.drawLine(
      Offset(17 * scale, (13 + rightOffset) * scale),
      Offset(17 * scale, (16 + rightOffset) * scale),
      paint,
    );
  }

  @override
  bool shouldRepaint(ChartCandlestickPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
