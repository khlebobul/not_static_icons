import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Fish Icon - Fish swims
class FishIcon extends AnimatedSVGIcon {
  const FishIcon({
    super.key,
    super.size = 40.0,
    super.color,
    super.hoverColor,
    super.animationDuration = const Duration(milliseconds: 800),
    super.strokeWidth = 2.0,
    super.reverseOnExit = false,
    super.enableTouchInteraction = true,
    super.infiniteLoop = false,
    super.onTap,
    super.interactive,
    super.controller,
  });

  @override
  String get animationDescription => "Fish swims";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return FishPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

class FishPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  FishPainter({
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

    // Animation - fish tail moves
    final oscillation = 4 * animationValue * (1 - animationValue);
    final tailOffset = oscillation * 1.5;

    // Main body: M6.5 12c.94-3.46 4.94-6 8.5-6 3.56 0 6.06 2.54 7 6-.94 3.47-3.44 6-7 6s-7.56-2.53-8.5-6Z
    final bodyPath = Path();
    bodyPath.moveTo(6.5 * scale, 12 * scale);
    bodyPath.cubicTo(
      7.44 * scale,
      8.54 * scale,
      11.44 * scale,
      6 * scale,
      15 * scale,
      6 * scale,
    );
    bodyPath.cubicTo(
      18.56 * scale,
      6 * scale,
      21.06 * scale,
      8.54 * scale,
      22 * scale,
      12 * scale,
    );
    bodyPath.cubicTo(
      21.06 * scale,
      15.47 * scale,
      18.56 * scale,
      18 * scale,
      15 * scale,
      18 * scale,
    );
    bodyPath.cubicTo(
      11.44 * scale,
      18 * scale,
      7.44 * scale,
      15.47 * scale,
      6.5 * scale,
      12 * scale,
    );
    bodyPath.close();
    canvas.drawPath(bodyPath, paint);

    // Eye: M18 12v.5
    canvas.drawLine(
      Offset(18 * scale, 12 * scale),
      Offset(18 * scale, 12.5 * scale),
      paint,
    );

    // Gill: M16 17.93a9.77 9.77 0 0 1 0-11.86
    final gillPath = Path();
    gillPath.moveTo(16 * scale, 17.93 * scale);
    gillPath.arcToPoint(
      Offset(16 * scale, 6.07 * scale),
      radius: Radius.circular(9.77 * scale),
      clockwise: true,
    );
    canvas.drawPath(gillPath, paint);

    // Tail: M7 10.67C7 8 5.58 5.97 2.73 5.5c-1 1.5-1 5 .23 6.5-1.24 1.5-1.24 5-.23 6.5C5.58 18.03 7 16 7 13.33
    canvas.save();
    canvas.translate(7 * scale, 12 * scale);
    canvas.rotate(tailOffset * 0.1);
    canvas.translate(-7 * scale, -12 * scale);

    final tailPath = Path();
    tailPath.moveTo(7 * scale, 10.67 * scale);
    tailPath.cubicTo(
      7 * scale,
      8 * scale,
      5.58 * scale,
      5.97 * scale,
      2.73 * scale,
      5.5 * scale,
    );
    tailPath.cubicTo(
      1.73 * scale,
      7 * scale,
      1.73 * scale,
      10.5 * scale,
      2.96 * scale,
      12 * scale,
    );
    tailPath.cubicTo(
      1.72 * scale,
      13.5 * scale,
      1.72 * scale,
      17 * scale,
      2.73 * scale,
      18.5 * scale,
    );
    tailPath.cubicTo(
      5.58 * scale,
      18.03 * scale,
      7 * scale,
      16 * scale,
      7 * scale,
      13.33 * scale,
    );
    canvas.drawPath(tailPath, paint);
    canvas.restore();

    // Top fin: M10.46 7.26C10.2 5.88 9.17 4.24 8 3h5.8a2 2 0 0 1 1.98 1.67l.23 1.4
    final topFinPath = Path();
    topFinPath.moveTo(10.46 * scale, 7.26 * scale);
    topFinPath.cubicTo(
      10.2 * scale,
      5.88 * scale,
      9.17 * scale,
      4.24 * scale,
      8 * scale,
      3 * scale,
    );
    topFinPath.lineTo(13.8 * scale, 3 * scale);
    topFinPath.arcToPoint(
      Offset(15.78 * scale, 4.67 * scale),
      radius: Radius.circular(2 * scale),
      clockwise: true,
    );
    topFinPath.lineTo(16.01 * scale, 6.07 * scale);
    canvas.drawPath(topFinPath, paint);

    // Bottom fin: m16.01 17.93-.23 1.4A2 2 0 0 1 13.8 21H9.5a5.96 5.96 0 0 0 1.49-3.98
    final bottomFinPath = Path();
    bottomFinPath.moveTo(16.01 * scale, 17.93 * scale);
    bottomFinPath.lineTo(15.78 * scale, 19.33 * scale);
    bottomFinPath.arcToPoint(
      Offset(13.8 * scale, 21 * scale),
      radius: Radius.circular(2 * scale),
      clockwise: false,
    );
    bottomFinPath.lineTo(9.5 * scale, 21 * scale);
    bottomFinPath.cubicTo(
      10.2 * scale,
      19.5 * scale,
      10.99 * scale,
      18.5 * scale,
      10.99 * scale,
      17.02 * scale,
    );
    canvas.drawPath(bottomFinPath, paint);
  }

  @override
  bool shouldRepaint(FishPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
