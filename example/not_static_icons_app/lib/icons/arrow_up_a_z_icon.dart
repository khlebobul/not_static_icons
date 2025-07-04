import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

class ArrowUpAZIcon extends AnimatedSVGIcon {
  const ArrowUpAZIcon({
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
    return _ArrowUpAZPainter(color: color, animationValue: animationValue);
  }

  @override
  String get animationDescription =>
      'Letter A shrinks while Z grows, showing A to Z sorting upward';
}

class _ArrowUpAZPainter extends CustomPainter {
  final Color color;
  final double animationValue;

  _ArrowUpAZPainter({required this.color, required this.animationValue});

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

    // Static arrow pointing up
    final arrowHeadPath = Path();
    arrowHeadPath.moveTo(3, 8);
    arrowHeadPath.lineTo(7, 4);
    arrowHeadPath.lineTo(11, 8);
    canvas.drawPath(arrowHeadPath, paint);

    final arrowLinePath = Path();
    arrowLinePath.moveTo(7, 4);
    arrowLinePath.lineTo(7, 20);
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

    // Draw letter A (source) - at bottom
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

    // Draw letter Z (target) - at top
    canvas.save();
    canvas.translate(17.5, 8); // Center of Z area
    canvas.scale(scaleZ, scaleZ);
    canvas.translate(-17.5, -8);

    // Z top line
    final zTopPath = Path();
    zTopPath.moveTo(15, 6);
    zTopPath.lineTo(20, 6);
    canvas.drawPath(zTopPath, paint);

    // Z diagonal
    final zDiagonalPath = Path();
    zDiagonalPath.moveTo(20, 6);
    zDiagonalPath.lineTo(15, 10);
    canvas.drawPath(zDiagonalPath, paint);

    // Z bottom line
    final zBottomPath = Path();
    zBottomPath.moveTo(15, 10);
    zBottomPath.lineTo(20, 10);
    canvas.drawPath(zBottomPath, paint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
