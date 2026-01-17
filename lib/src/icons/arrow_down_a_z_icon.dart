import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

class ArrowDownAZIcon extends AnimatedSVGIcon {
  const ArrowDownAZIcon({
    super.key,
    super.size = 40,
    super.color = Colors.black,
    super.animationDuration = const Duration(milliseconds: 1500),
    super.strokeWidth = 2.0,
    super.reverseOnExit = false,
    super.enableTouchInteraction = true,
    super.infiniteLoop = false,
    super.onTap,
    super.interactive,
    super.controller,
  });

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return _ArrowDownAZPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }

  @override
  String get animationDescription =>
      'Letter A shrinks while Z grows, showing A to Z sorting';
}

class _ArrowDownAZPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  _ArrowDownAZPainter({
    required this.color,
    required this.animationValue,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth / 1.7
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final scaleX = size.width / 24;
    final scaleY = size.height / 24;
    canvas.scale(scaleX, scaleY);

    // Static arrow pointing down (A to Z direction)
    final arrowHeadPath = Path();
    arrowHeadPath.moveTo(3, 16);
    arrowHeadPath.lineTo(7, 20);
    arrowHeadPath.lineTo(11, 16);
    canvas.drawPath(arrowHeadPath, paint);

    final arrowLinePath = Path();
    arrowLinePath.moveTo(7, 20);
    arrowLinePath.lineTo(7, 4);
    canvas.drawPath(arrowLinePath, paint);

    // Animation scale factors
    double scaleA, scaleZ;
    if (animationValue <= 0.5) {
      // First half: A shrinks, Z grows
      double progress = animationValue * 2;
      scaleA = 1.0 - (progress * 0.3); // A shrinks to 70%
      scaleZ = 1.0 + (progress * 0.3); // Z grows to 130%
    } else {
      // Second half: return to normal size
      double progress = (animationValue - 0.5) * 2;
      scaleA = 0.7 + (progress * 0.3); // A returns to 100%
      scaleZ = 1.3 - (progress * 0.3); // Z returns to 100%
    }

    // Draw letter A (source) - at top
    canvas.save();
    canvas.translate(17.5, 8); // Center of A area
    canvas.scale(scaleA, scaleA);
    canvas.translate(-17.5, -8);

    // A horizontal line
    final aHorizontalPath = Path();
    aHorizontalPath.moveTo(20, 8);
    aHorizontalPath.lineTo(15, 8);
    canvas.drawPath(aHorizontalPath, paint);

    // A left and right legs with arc
    final aLeftPath = Path();
    aLeftPath.moveTo(15, 10);
    aLeftPath.lineTo(15, 6.5);
    canvas.drawPath(aLeftPath, paint);

    final aRightPath = Path();
    aRightPath.moveTo(20, 10);
    aRightPath.lineTo(20, 6.5);
    canvas.drawPath(aRightPath, paint);

    // A arc at top
    final aArcPath = Path();
    aArcPath.addArc(
      Rect.fromCenter(center: const Offset(17.5, 6.5), width: 5, height: 5),
      -3.14159, // Start at left
      3.14159, // Half circle
    );
    canvas.drawPath(aArcPath, paint);

    canvas.restore();

    // Draw letter Z (target) - at bottom
    canvas.save();
    canvas.translate(17.5, 17); // Center of Z area
    canvas.scale(scaleZ, scaleZ);
    canvas.translate(-17.5, -17);

    // Z top line
    final zTopPath = Path();
    zTopPath.moveTo(15, 14);
    zTopPath.lineTo(20, 14);
    canvas.drawPath(zTopPath, paint);

    // Z diagonal
    final zDiagonalPath = Path();
    zDiagonalPath.moveTo(20, 14);
    zDiagonalPath.lineTo(15, 20);
    canvas.drawPath(zDiagonalPath, paint);

    // Z bottom line
    final zBottomPath = Path();
    zBottomPath.moveTo(15, 20);
    zBottomPath.lineTo(20, 20);
    canvas.drawPath(zBottomPath, paint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _ArrowDownAZPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
