import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Brush Icon - Pivots back and forth
class BrushIcon extends AnimatedSVGIcon {
  const BrushIcon({
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
  String get animationDescription => "Brush pivots back and forth";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    // Pivot: 0 -> -angle -> +angle -> 0
    double angle = 0;
    const maxAngle = 0.3; // radians

    if (animationValue < 0.25) {
      angle = -maxAngle * (animationValue / 0.25);
    } else if (animationValue < 0.75) {
      angle = -maxAngle + 2 * maxAngle * ((animationValue - 0.25) / 0.5);
    } else {
      angle = maxAngle - maxAngle * ((animationValue - 0.75) / 0.25);
    }

    return BrushPainter(
      color: color,
      angle: angle,
      strokeWidth: strokeWidth,
    );
  }
}

class BrushPainter extends CustomPainter {
  final Color color;
  final double angle;
  final double strokeWidth;

  BrushPainter({
    required this.color,
    required this.angle,
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

    // Pivot point around the center of the brush handle roughly
    final pivotX = 12.0 * scale;
    final pivotY = 12.0 * scale;

    canvas.save();
    canvas.translate(pivotX, pivotY);
    canvas.rotate(angle);
    canvas.translate(-pivotX, -pivotY);

    // Handle
    // M9.969 17.031 21.378 5.624a1 1 0 0 0-3.002-3.002L6.967 14.031
    final handlePath = Path();
    handlePath.moveTo(9.969 * scale, 17.031 * scale);
    handlePath.lineTo(21.378 * scale, 5.624 * scale);
    handlePath.arcToPoint(
      Offset(18.376 * scale, 2.622 * scale),
      radius: Radius.circular(1 * scale), // Approximate radius from svg logic
      clockwise: false,
    );
    // Wait, SVG says a1 1 0 0 0 -3.002 -3.002
    // That's an arc.
    // Let's just draw line to start of arc, then arc, then line back.
    // Start point of arc: 21.378, 5.624
    // End point of arc: 21.378 - 3.002 = 18.376, 5.624 - 3.002 = 2.622
    // Radius 1.
    // Large arc flag 0, sweep flag 0 (counter-clockwise)

    handlePath.lineTo(6.967 * scale, 14.031 * scale);
    // We need to close the loop or connect to the paint blob?
    // The SVG has separate paths.
    // But wait, the handle path in SVG is just a line?
    // <path d="M9.969 17.031 21.378 5.624a1 1 0 0 0-3.002-3.002L6.967 14.031"/>
    // It's a shape.
    canvas.drawPath(handlePath, paint);

    // Detail line
    // m11 10 3 3
    canvas.drawLine(
        Offset(11 * scale, 10 * scale), Offset(14 * scale, 13 * scale), paint);

    // Paint Blob/Tip
    // M6.5 21A3.5 3.5 0 1 0 3 17.5a2.62 2.62 0 0 1-.708 1.792A1 1 0 0 0 3 21z
    final blobPath = Path();
    blobPath.moveTo(6.5 * scale, 21 * scale);
    blobPath.arcToPoint(
      Offset(3 * scale, 17.5 * scale),
      radius: Radius.circular(3.5 * scale),
      largeArc: true,
      clockwise: false, // 1 0 -> large arc 1, sweep 0
    );
    blobPath.arcToPoint(
      Offset(2.292 * scale, 19.292 * scale),
      radius: Radius.circular(2.62 * scale),
      clockwise: true, // 0 1 -> sweep 1
    );
    blobPath.arcToPoint(
      Offset(3 * scale, 21 * scale),
      radius: Radius.circular(1 * scale),
      clockwise: false, // 0 0 -> sweep 0
    );
    blobPath.close();
    canvas.drawPath(blobPath, paint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(BrushPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.angle != angle ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
