import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Chess King Icon - King tilts
class ChessKingIcon extends AnimatedSVGIcon {
  const ChessKingIcon({
    super.key,
    super.size = 40.0,
    super.color,
    super.hoverColor,
    super.animationDuration = const Duration(milliseconds: 600),
    super.strokeWidth = 2.0,
    super.reverseOnExit = false,
    super.enableTouchInteraction = true,
    super.infiniteLoop = false,
  });

  @override
  String get animationDescription => "King tilts";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return ChessKingPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

class ChessKingPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  ChessKingPainter({
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

    // Animation - slight tilt
    final oscillation = 4 * animationValue * (1 - animationValue);
    final tiltAngle = oscillation * 0.08;

    canvas.save();
    canvas.translate(12 * scale, 21 * scale);
    canvas.rotate(tiltAngle);
    canvas.translate(-12 * scale, -21 * scale);

    // Base
    final basePath = Path();
    basePath.moveTo(4 * scale, 20 * scale);
    basePath.arcToPoint(Offset(6 * scale, 18 * scale),
        radius: Radius.circular(2 * scale), clockwise: true);
    basePath.lineTo(18 * scale, 18 * scale);
    basePath.arcToPoint(Offset(20 * scale, 20 * scale),
        radius: Radius.circular(2 * scale), clockwise: true);
    basePath.lineTo(20 * scale, 21 * scale);
    basePath.arcToPoint(Offset(19 * scale, 22 * scale),
        radius: Radius.circular(1 * scale), clockwise: true);
    basePath.lineTo(5 * scale, 22 * scale);
    basePath.arcToPoint(Offset(4 * scale, 21 * scale),
        radius: Radius.circular(1 * scale), clockwise: true);
    basePath.close();
    canvas.drawPath(basePath, paint);

    // Body
    final bodyPath = Path();
    bodyPath.moveTo(6.7 * scale, 18 * scale);
    bodyPath.lineTo(5.7 * scale, 17 * scale);
    bodyPath.cubicTo(4.35 * scale, 15.682 * scale, 3 * scale, 14.09 * scale,
        3 * scale, 12 * scale);
    bodyPath.arcToPoint(Offset(7.95 * scale, 7 * scale),
        radius: Radius.circular(5 * scale), clockwise: true);
    bodyPath.cubicTo(9.534 * scale, 7 * scale, 10.65 * scale, 7.455 * scale,
        12 * scale, 8.818 * scale);
    bodyPath.cubicTo(13.35 * scale, 7.455 * scale, 14.466 * scale, 7 * scale,
        16.05 * scale, 7 * scale);
    bodyPath.arcToPoint(Offset(21 * scale, 12 * scale),
        radius: Radius.circular(5 * scale), clockwise: true);
    bodyPath.cubicTo(21 * scale, 14.082 * scale, 19.641 * scale, 15.673 * scale,
        18.3 * scale, 17 * scale);
    bodyPath.lineTo(17.3 * scale, 18 * scale);
    canvas.drawPath(bodyPath, paint);

    // Cross horizontal: M10 4h4
    final crossH = Path();
    crossH.moveTo(10 * scale, 4 * scale);
    crossH.lineTo(14 * scale, 4 * scale);
    canvas.drawPath(crossH, paint);

    // Cross vertical: M12 2v6.818
    final crossV = Path();
    crossV.moveTo(12 * scale, 2 * scale);
    crossV.lineTo(12 * scale, 8.818 * scale);
    canvas.drawPath(crossV, paint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(ChessKingPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
