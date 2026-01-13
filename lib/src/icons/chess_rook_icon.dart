import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Chess Rook Icon - Rook tilts
class ChessRookIcon extends AnimatedSVGIcon {
  const ChessRookIcon({
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
  String get animationDescription => "Rook tilts";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return ChessRookPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

class ChessRookPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  ChessRookPainter({
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
    basePath.moveTo(5 * scale, 20 * scale);
    basePath.arcToPoint(Offset(7 * scale, 18 * scale), radius: Radius.circular(2 * scale), clockwise: true);
    basePath.lineTo(17 * scale, 18 * scale);
    basePath.arcToPoint(Offset(19 * scale, 20 * scale), radius: Radius.circular(2 * scale), clockwise: true);
    basePath.lineTo(19 * scale, 21 * scale);
    basePath.arcToPoint(Offset(18 * scale, 22 * scale), radius: Radius.circular(1 * scale), clockwise: true);
    basePath.lineTo(6 * scale, 22 * scale);
    basePath.arcToPoint(Offset(5 * scale, 21 * scale), radius: Radius.circular(1 * scale), clockwise: true);
    basePath.close();
    canvas.drawPath(basePath, paint);

    // Left merlon: M10 2v2
    final leftMerlon = Path();
    leftMerlon.moveTo(10 * scale, 2 * scale);
    leftMerlon.lineTo(10 * scale, 4 * scale);
    canvas.drawPath(leftMerlon, paint);

    // Right merlon: M14 2v2
    final rightMerlon = Path();
    rightMerlon.moveTo(14 * scale, 2 * scale);
    rightMerlon.lineTo(14 * scale, 4 * scale);
    canvas.drawPath(rightMerlon, paint);

    // Right body line: m17 18-1-9
    final rightBody = Path();
    rightBody.moveTo(17 * scale, 18 * scale);
    rightBody.lineTo(16 * scale, 9 * scale);
    canvas.drawPath(rightBody, paint);

    // Top body: M6 2v5a2 2 0 0 0 2 2h8a2 2 0 0 0 2-2V2
    final topBody = Path();
    topBody.moveTo(6 * scale, 2 * scale);
    topBody.lineTo(6 * scale, 7 * scale);
    topBody.arcToPoint(Offset(8 * scale, 9 * scale), radius: Radius.circular(2 * scale), clockwise: false);
    topBody.lineTo(16 * scale, 9 * scale);
    topBody.arcToPoint(Offset(18 * scale, 7 * scale), radius: Radius.circular(2 * scale), clockwise: false);
    topBody.lineTo(18 * scale, 2 * scale);
    canvas.drawPath(topBody, paint);

    // Top horizontal: M6 4h12
    final topHoriz = Path();
    topHoriz.moveTo(6 * scale, 4 * scale);
    topHoriz.lineTo(18 * scale, 4 * scale);
    canvas.drawPath(topHoriz, paint);

    // Left body line: m7 18 1-9
    final leftBody = Path();
    leftBody.moveTo(7 * scale, 18 * scale);
    leftBody.lineTo(8 * scale, 9 * scale);
    canvas.drawPath(leftBody, paint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(ChessRookPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
