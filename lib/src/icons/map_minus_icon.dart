import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Map Minus Icon - Map unfolds with minus sign
class MapMinusIcon extends AnimatedSVGIcon {
  const MapMinusIcon({
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
  String get animationDescription => "Map minus unfolds";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return MapMinusPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

/// Painter for Map Minus icon
class MapMinusPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  MapMinusPainter({
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

    // Animation - fold lines move apart (unfold effect)
    final oscillation = 4 * animationValue * (1 - animationValue);
    final unfoldOffset = oscillation * 1.5;

    // Main map shape (partial - cut off at bottom right)
    final mapPath = Path();
    mapPath.moveTo(11 * scale, 19 * scale);
    mapPath.lineTo(9.894 * scale, 18.448 * scale);
    mapPath.arcToPoint(
      Offset(8.106 * scale, 18.448 * scale),
      radius: Radius.circular(2 * scale),
      clockwise: false,
    );
    mapPath.lineTo(4.447 * scale, 20.278 * scale);
    mapPath.arcToPoint(
      Offset(3 * scale, 19.381 * scale),
      radius: Radius.circular(1 * scale),
      clockwise: true,
    );
    mapPath.lineTo(3 * scale, 6.618 * scale);
    mapPath.arcToPoint(
      Offset(3.553 * scale, 5.724 * scale),
      radius: Radius.circular(1 * scale),
      clockwise: true,
    );
    mapPath.lineTo(8.106 * scale, 3.447 * scale);
    mapPath.arcToPoint(
      Offset(9.894 * scale, 3.447 * scale),
      radius: Radius.circular(2 * scale),
      clockwise: true,
    );
    mapPath.lineTo(14.106 * scale, 5.553 * scale);
    mapPath.arcToPoint(
      Offset(15.894 * scale, 5.553 * scale),
      radius: Radius.circular(2 * scale),
      clockwise: false,
    );
    mapPath.lineTo(19.553 * scale, 3.723 * scale);
    mapPath.arcToPoint(
      Offset(21 * scale, 4.619 * scale),
      radius: Radius.circular(1 * scale),
      clockwise: true,
    );
    mapPath.lineTo(21 * scale, 14 * scale);
    canvas.drawPath(mapPath, paint);

    // Right fold line (shorter) - moves right: M15 5.764V14
    final rightFold = Path();
    rightFold.moveTo((15 + unfoldOffset) * scale, 5.764 * scale);
    rightFold.lineTo((15 + unfoldOffset) * scale, 14 * scale);
    canvas.drawPath(rightFold, paint);

    // Left fold line - moves left: M9 3.236v15
    final leftFold = Path();
    leftFold.moveTo((9 - unfoldOffset) * scale, 3.236 * scale);
    leftFold.lineTo((9 - unfoldOffset) * scale, 18.236 * scale);
    canvas.drawPath(leftFold, paint);

    // Minus sign: M21 18h-6
    final minusPath = Path();
    minusPath.moveTo(15 * scale, 18 * scale);
    minusPath.lineTo(21 * scale, 18 * scale);
    canvas.drawPath(minusPath, paint);
  }

  @override
  bool shouldRepaint(MapMinusPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
