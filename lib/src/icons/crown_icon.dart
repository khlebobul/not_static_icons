import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Crown Icon - Crown bounces
class CrownIcon extends AnimatedSVGIcon {
  const CrownIcon({
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
  String get animationDescription => "Crown bounces";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return CrownPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

class CrownPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  CrownPainter({
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

    // Animation - crown bounces
    final oscillation = 4 * animationValue * (1 - animationValue);
    final bounceOffset = oscillation * 2.0;

    canvas.save();
    canvas.translate(0, -bounceOffset * scale);

    // Crown path: M11.562 3.266a.5.5 0 0 1 .876 0L15.39 8.87a1 1 0 0 0 1.516.294L21.183 5.5a.5.5 0 0 1 .798.519l-2.834 10.246a1 1 0 0 1-.956.734H5.81a1 1 0 0 1-.957-.734L2.02 6.02a.5.5 0 0 1 .798-.519l4.276 3.664a1 1 0 0 0 1.516-.294z
    final crownPath = Path();
    
    // Start at left peak
    crownPath.moveTo(11.562 * scale, 3.266 * scale);
    
    // Small arc at top (a.5.5 0 0 1 .876 0)
    crownPath.arcToPoint(
      Offset(12.438 * scale, 3.266 * scale),
      radius: Radius.circular(0.5 * scale),
      clockwise: true,
    );
    
    // Line to right peak (L15.39 8.87)
    crownPath.lineTo(15.39 * scale, 8.87 * scale);
    
    // Arc at right peak (a1 1 0 0 0 1.516.294)
    crownPath.arcToPoint(
      Offset(16.906 * scale, 9.164 * scale),
      radius: Radius.circular(1 * scale),
      clockwise: true,
    );
    
    // Line to top right corner (L21.183 5.5)
    crownPath.lineTo(21.183 * scale, 5.5 * scale);
    
    // Small arc at top right (a.5.5 0 0 1 .798.519)
    crownPath.arcToPoint(
      Offset(21.981 * scale, 6.019 * scale),
      radius: Radius.circular(0.5 * scale),
      clockwise: true,
    );
    
    // Line down right side (l-2.834 10.246)
    crownPath.lineTo(19.147 * scale, 16.265 * scale);
    
    // Arc at bottom right (a1 1 0 0 1-.956.734)
    crownPath.arcToPoint(
      Offset(18.191 * scale, 16.999 * scale),
      radius: Radius.circular(1 * scale),
      clockwise: false,
    );
    
    // Line across bottom (H5.81)
    crownPath.lineTo(5.81 * scale, 16.999 * scale);
    
    // Arc at bottom left (a1 1 0 0 1-.957-.734)
    crownPath.arcToPoint(
      Offset(4.853 * scale, 16.265 * scale),
      radius: Radius.circular(1 * scale),
      clockwise: false,
    );
    
    // Line up left side (L2.02 6.02)
    crownPath.lineTo(2.02 * scale, 6.02 * scale);
    
    // Small arc at top left (a.5.5 0 0 1 .798-.519)
    crownPath.arcToPoint(
      Offset(2.818 * scale, 5.501 * scale),
      radius: Radius.circular(0.5 * scale),
      clockwise: true,
    );
    
    // Line to left peak (l4.276 3.664)
    crownPath.lineTo(7.094 * scale, 9.165 * scale);
    
    // Arc at left peak (a1 1 0 0 0 1.516-.294)
    crownPath.arcToPoint(
      Offset(8.61 * scale, 8.871 * scale),
      radius: Radius.circular(1 * scale),
      clockwise: true,
    );
    
    // Close path back to start
    crownPath.close();
    
    canvas.drawPath(crownPath, paint);

    // Base line: M5 21h14
    canvas.drawLine(
      Offset(5 * scale, 21 * scale),
      Offset(19 * scale, 21 * scale),
      paint,
    );

    canvas.restore();
  }

  @override
  bool shouldRepaint(CrownPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
