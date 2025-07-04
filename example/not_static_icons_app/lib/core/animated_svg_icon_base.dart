import 'package:flutter/material.dart';

/// Base class for animated SVG icons
abstract class AnimatedSVGIcon extends StatefulWidget {
  final double size;
  final Color? color;
  final Color? hoverColor;
  final Duration animationDuration;
  final double strokeWidth;

  const AnimatedSVGIcon({
    super.key,
    this.size = 40.0,
    this.color,
    this.hoverColor,
    this.animationDuration = const Duration(milliseconds: 600),
    this.strokeWidth = 2.0,
  });

  /// Method to create custom painter
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  });

  /// Animation description (for debugging)
  String get animationDescription;

  @override
  AnimatedSVGIconState createState() => AnimatedSVGIconState();
}

class AnimatedSVGIconState extends State<AnimatedSVGIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    );

    _animation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _startAnimation() {
    _controller.forward();
  }

  void _stopAnimation() {
    _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    final effectiveColor =
        widget.color ?? Theme.of(context).iconTheme.color ?? Colors.black87;
    final effectiveHoverColor = widget.hoverColor ?? Colors.grey;

    return MouseRegion(
      onEnter: (_) {
        setState(() {
          _isHovered = true;
        });
        _startAnimation();
      },
      onExit: (_) {
        setState(() {
          _isHovered = false;
        });
        _stopAnimation();
      },
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return CustomPaint(
            size: Size(widget.size, widget.size),
            painter: widget.createPainter(
              color: _isHovered ? effectiveHoverColor : effectiveColor,
              animationValue: _animation.value,
              strokeWidth: widget.strokeWidth,
            ),
          );
        },
      ),
    );
  }
}
