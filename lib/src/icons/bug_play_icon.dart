import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Bug Play Icon - Play button pulses
class BugPlayIcon extends AnimatedSVGIcon {
  const BugPlayIcon({
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
  String get animationDescription => "Play button pulses";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    // Pulse: 0 -> 1 -> 0
    final pulse =
        2 * animationValue * (1 - animationValue); // Parabolic 0->0.5->0
    // Actually we want 0 -> 1 -> 0 scale effect?
    // Or just scale up and down?
    // Let's do scale 1.0 -> 1.2 -> 1.0

    return BugPlayPainter(
      color: color,
      scaleValue: pulse * 0.3, // Max 0.15 scale increase?
      // Let's do 0 -> 1 for animationValue.
      // We want continuous pulse maybe?
      // Just one pulse on hover is fine.
      strokeWidth: strokeWidth,
    );
  }
}

class BugPlayPainter extends CustomPainter {
  final Color color;
  final double scaleValue;
  final double strokeWidth;

  BugPlayPainter({
    required this.color,
    required this.scaleValue,
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

    // Bug Parts (Static)

    // M10 19.655A6 6 0 0 1 6 14v-3a4 4 0 0 1 4-4h4a4 4 0 0 1 4 3.97
    final bodyPath = Path();
    bodyPath.moveTo(10 * scale, 19.655 * scale);
    bodyPath.arcToPoint(
      Offset(6 * scale, 14 * scale),
      radius: Radius.circular(6 * scale),
      clockwise: true,
    );
    bodyPath.lineTo(6 * scale, 11 * scale);
    bodyPath.arcToPoint(
      Offset(10 * scale, 7 * scale),
      radius: Radius.circular(4 * scale),
      clockwise: true,
    );
    bodyPath.lineTo(14 * scale, 7 * scale);
    bodyPath.arcToPoint(
      Offset(18 * scale, 10.97 * scale),
      radius: Radius.circular(4 * scale),
      clockwise: true,
    );
    canvas.drawPath(bodyPath, paint);

    // Antennae & Head
    // M14.12 3.88 16 2
    canvas.drawLine(Offset(14.12 * scale, 3.88 * scale),
        Offset(16 * scale, 2 * scale), paint);
    // m8 2 1.88 1.88 -> M8 2 L9.88 3.88
    canvas.drawLine(Offset(8 * scale, 2 * scale),
        Offset(9.88 * scale, 3.88 * scale), paint);
    // M9 7.13V6a3 3 0 1 1 6 0v1.13
    final headPath = Path();
    headPath.moveTo(9 * scale, 7.13 * scale);
    headPath.lineTo(9 * scale, 6 * scale);
    headPath.arcToPoint(
      Offset(15 * scale, 6 * scale),
      radius: Radius.circular(3 * scale),
      largeArc: true,
      clockwise: true,
    );
    headPath.lineTo(15 * scale, 7.13 * scale);
    canvas.drawPath(headPath, paint);

    // Legs
    // M21 5a4 4 0 0 1-3.55 3.97
    final trLeg = Path();
    trLeg.moveTo(21 * scale, 5 * scale);
    trLeg.arcToPoint(
      Offset(17.45 * scale, 8.97 * scale),
      radius: Radius.circular(4 * scale),
      clockwise: true,
    );
    canvas.drawPath(trLeg, paint);

    // M3 21a4 4 0 0 1 3.81-4
    final blLeg = Path();
    blLeg.moveTo(3 * scale, 21 * scale);
    blLeg.arcToPoint(
      Offset(6.81 * scale, 17 * scale),
      radius: Radius.circular(4 * scale),
      clockwise: true,
    );
    canvas.drawPath(blLeg, paint);

    // M3 5a4 4 0 0 0 3.55 3.97
    final tlLeg = Path();
    tlLeg.moveTo(3 * scale, 5 * scale);
    tlLeg.arcToPoint(
      Offset(6.55 * scale, 8.97 * scale),
      radius: Radius.circular(4 * scale),
      clockwise: false,
    );
    canvas.drawPath(tlLeg, paint);

    // M6 13H2
    canvas.drawLine(
        Offset(6 * scale, 13 * scale), Offset(2 * scale, 13 * scale), paint);

    // Play Triangle (Animated)
    // M14 15.003a1 1 0 0 1 1.517-.859l4.997 2.997a1 1 0 0 1 0 1.718l-4.997 2.997a1 1 0 0 1-1.517-.86z
    // Center of triangle roughly:
    // x range: 14 to 14+1.517+4.997 ~ 20.5
    // y range: 15 to 15+some ~ 19
    // Bounding box center roughly (17, 17)

    final centerX = 17.0 * scale;
    final centerY = 17.0 * scale;

    canvas.save();
    canvas.translate(centerX, centerY);
    canvas.scale(1.0 + scaleValue);
    canvas.translate(-centerX, -centerY);

    final playPath = Path();
    playPath.moveTo(14 * scale, 15.003 * scale);
    // a1 1 0 0 1 1.517-.859
    playPath.arcToPoint(
      Offset(15.517 * scale, 14.144 * scale), // 15.003 - 0.859 = 14.144
      radius: Radius.circular(1 * scale),
      clockwise: true,
    );
    // l4.997 2.997
    playPath.lineTo(20.514 * scale, 17.141 * scale);
    // a1 1 0 0 1 0 1.718
    playPath.arcToPoint(
      Offset(20.514 * scale, 18.859 * scale),
      radius: Radius.circular(1 * scale),
      clockwise: true,
    );
    // l-4.997 2.997
    playPath.lineTo(15.517 * scale, 21.856 * scale);
    // a1 1 0 0 1-1.517-.86z
    playPath.arcToPoint(
      Offset(
          14 * scale, 20.996 * scale), // Close enough to vertical line start?
      radius: Radius.circular(1 * scale),
      clockwise: true,
    );
    playPath.close();
    canvas.drawPath(playPath, paint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(BugPlayPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.scaleValue != scaleValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
