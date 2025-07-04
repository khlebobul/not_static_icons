import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

class ArrowDownZAIcon extends AnimatedSVGIcon {
  const ArrowDownZAIcon({
    super.key,
    super.size = 24,
    super.color = Colors.black,
    super.animationDuration = const Duration(milliseconds: 1500),
  });

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
  }) {
    return _ArrowDownZAPainter(color: color, animationValue: animationValue);
  }

  @override
  String get animationDescription =>
      'Letter Z shrinks while A grows, showing Z to A sorting';
}

class _ArrowDownZAPainter extends CustomPainter {
  final Color color;
  final double animationValue;

  _ArrowDownZAPainter({required this.color, required this.animationValue});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final scaleX = size.width / 24;
    final scaleY = size.height / 24;
    canvas.scale(scaleX, scaleY);

    // Static arrow pointing down
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
    double scaleZ, scaleA;
    if (animationValue <= 0.5) {
      // First half: Z shrinks, A grows
      double progress = animationValue * 2;
      scaleZ = 1.0 - (progress * 0.3); // Z shrinks to 70%
      scaleA = 1.0 + (progress * 0.3); // A grows to 130%
    } else {
      // Second half: return to normal size
      double progress = (animationValue - 0.5) * 2;
      scaleZ = 0.7 + (progress * 0.3); // Z returns to 100%
      scaleA = 1.3 - (progress * 0.3); // A returns to 100%
    }

    // Draw letter Z (source) - at top
    canvas.save();
    canvas.translate(17.5, 8); // Center of Z area
    canvas.scale(scaleZ, scaleZ);
    canvas.translate(-17.5, -8);

    // Z top line
    final zTopPath = Path();
    zTopPath.moveTo(15, 4);
    zTopPath.lineTo(20, 4);
    canvas.drawPath(zTopPath, paint);

    // Z diagonal
    final zDiagonalPath = Path();
    zDiagonalPath.moveTo(20, 4);
    zDiagonalPath.lineTo(15, 10);
    canvas.drawPath(zDiagonalPath, paint);

    // Z bottom line
    final zBottomPath = Path();
    zBottomPath.moveTo(15, 10);
    zBottomPath.lineTo(20, 10);
    canvas.drawPath(zBottomPath, paint);

    canvas.restore();

    // Draw letter A (target) - at bottom
    canvas.save();
    canvas.translate(17.5, 17); // Center of A area
    canvas.scale(scaleA, scaleA);
    canvas.translate(-17.5, -17);

    // A horizontal line
    final aHorizontalPath = Path();
    aHorizontalPath.moveTo(20, 18);
    aHorizontalPath.lineTo(15, 18);
    canvas.drawPath(aHorizontalPath, paint);

    // A left and right legs with arc
    final aLeftPath = Path();
    aLeftPath.moveTo(15, 20);
    aLeftPath.lineTo(15, 16.5);
    canvas.drawPath(aLeftPath, paint);

    final aRightPath = Path();
    aRightPath.moveTo(20, 20);
    aRightPath.lineTo(20, 16.5);
    canvas.drawPath(aRightPath, paint);

    // A arc at top
    final aArcPath = Path();
    aArcPath.addArc(
      Rect.fromCenter(center: const Offset(17.5, 16.5), width: 5, height: 5),
      -3.14159, // Start at left
      3.14159, // Half circle
    );
    canvas.drawPath(aArcPath, paint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
