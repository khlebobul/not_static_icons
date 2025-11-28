import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../core/animated_svg_icon_base.dart';

/// Animated Calendar Fold Icon - Corner folds
class CalendarFoldIcon extends AnimatedSVGIcon {
  const CalendarFoldIcon({
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
  String get animationDescription => "Corner folds";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    // Fold animation: 0 -> 1 -> 0
    // We can animate the corner moving.
    // The fold is at bottom right.
    // M15 22v-5a1 1 0 0 1 1-1h5
    // This is the folded part.
    // The main body has a cut: ...l3.588-3.588...

    // Let's animate the fold "opening" or "closing".
    // Or just scaling the fold triangle?
    // Let's scale the fold triangle from 1.0 to 0.0 (unfolded) and back?
    // Or just pulse it.

    final foldScale = 1.0 - math.sin(animationValue * math.pi) * 0.5;

    return CalendarFoldPainter(
      color: color,
      foldScale: foldScale,
      strokeWidth: strokeWidth,
    );
  }
}

class CalendarFoldPainter extends CustomPainter {
  final Color color;
  final double foldScale;
  final double strokeWidth;

  CalendarFoldPainter({
    required this.color,
    required this.foldScale,
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

    // Calendar Body (Static part)
    // M3 20a2 2 0 0 0 2 2h10a2.4 2.4 0 0 0 1.706-.706l3.588-3.588A2.4 2.4 0 0 0 21 16V6a2 2 0 0 0-2-2H5a2 2 0 0 0-2 2z
    // We need to adjust the cut based on foldScale?
    // If foldScale changes, the cut corner should move?
    // That's complex.
    // Let's just keep body static and animate the fold piece moving/scaling.

    final bodyPath = Path();
    bodyPath.moveTo(3 * scale, 20 * scale);
    bodyPath.arcToPoint(Offset(5 * scale, 22 * scale),
        radius: Radius.circular(2 * scale), clockwise: false);
    bodyPath.lineTo(15 * scale, 22 * scale);
    // Cut corner
    // a2.4 2.4 0 0 0 1.706-.706l3.588-3.588A2.4 2.4 0 0 0 21 16
    // This is the diagonal cut.
    // Let's draw it as is.
    bodyPath.arcToPoint(Offset(16.706 * scale, 21.294 * scale),
        radius: Radius.circular(2.4 * scale), clockwise: false);
    bodyPath.lineTo(20.294 * scale, 17.706 * scale);
    bodyPath.arcToPoint(Offset(21 * scale, 16 * scale),
        radius: Radius.circular(2.4 * scale), clockwise: false);

    bodyPath.lineTo(21 * scale, 6 * scale);
    bodyPath.arcToPoint(Offset(19 * scale, 4 * scale),
        radius: Radius.circular(2 * scale), clockwise: false);
    bodyPath.lineTo(5 * scale, 4 * scale);
    bodyPath.arcToPoint(Offset(3 * scale, 6 * scale),
        radius: Radius.circular(2 * scale), clockwise: false);
    bodyPath.close();
    canvas.drawPath(bodyPath, paint);

    // Fold Piece (Animated)
    // M15 22v-5a1 1 0 0 1 1-1h5
    // Pivot at 15, 22? Or 16, 21?
    // The corner is 16, 21 (inner corner of fold).
    // Let's pivot around 16, 21.

    canvas.save();
    // Pivot at 16, 21
    canvas.translate(16 * scale, 21 * scale);
    canvas.scale(foldScale);
    canvas.translate(-16 * scale, -21 * scale);

    final foldPath = Path();
    foldPath.moveTo(15 * scale, 22 * scale);
    foldPath.lineTo(15 * scale, 17 * scale);
    foldPath.arcToPoint(Offset(16 * scale, 16 * scale),
        radius: Radius.circular(1 * scale), clockwise: true);
    foldPath.lineTo(21 * scale, 16 * scale);
    canvas.drawPath(foldPath, paint);

    canvas.restore();

    // Top Lines
    // M16 2v4
    canvas.drawLine(
        Offset(16 * scale, 2 * scale), Offset(16 * scale, 6 * scale), paint);
    // M8 2v4
    canvas.drawLine(
        Offset(8 * scale, 2 * scale), Offset(8 * scale, 6 * scale), paint);

    // Horizontal Line
    // M3 10h18
    canvas.drawLine(
        Offset(3 * scale, 10 * scale), Offset(21 * scale, 10 * scale), paint);
  }

  @override
  bool shouldRepaint(CalendarFoldPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.foldScale != foldScale ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
