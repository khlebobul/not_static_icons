import 'package:flutter/material.dart';

/// Base class for animated SVG icons
abstract class AnimatedSVGIcon extends StatefulWidget {
  final double size; // Icon size
  final Color? color; // Icon color
  final Color? hoverColor; // Hover color
  final Duration animationDuration; // Animation duration
  final double strokeWidth; // Stroke width
  final bool reverseOnExit; // Reverse animation on exit
  final bool enableTouchInteraction; // Enable touch interaction
  final bool infiniteLoop; // Enable infinite loop animation
  final bool
      resetToStartOnComplete; // Reset back to original when animation completes

  const AnimatedSVGIcon({
    super.key,
    this.size = 40.0,
    this.color,
    this.hoverColor,
    this.animationDuration = const Duration(milliseconds: 600),
    this.strokeWidth = 2.0,
    this.reverseOnExit = false,
    this.enableTouchInteraction = true,
    this.infiniteLoop = false,
    this.resetToStartOnComplete = false,
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
  bool _isPressed = false;

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

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        if (widget.resetToStartOnComplete && !widget.infiniteLoop) {
          _controller.reset();
          setState(() {});
        }
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _startAnimation() {
    if (widget.infiniteLoop) {
      _controller.repeat();
    } else {
      _controller.reset();
      _controller.forward();
    }
  }

  void _stopAnimation() {
    if (widget.infiniteLoop) {
      _controller.stop();
      _controller.reset();
    } else if (widget.reverseOnExit) {
      _controller.reverse();
    }
  }

  void _onTapDown() {
    setState(() {
      _isPressed = true;
    });
    _startAnimation();
  }

  void _onTapUp() {
    setState(() {
      _isPressed = false;
    });
    _stopAnimation();
  }

  void _onTapCancel() {
    setState(() {
      _isPressed = false;
    });
    _stopAnimation();
  }

  void _onMouseEnter() {
    if (!_isPressed) {
      // Only start if not already pressed
      setState(() {
        _isHovered = true;
      });
      _startAnimation();
    }
  }

  void _onMouseExit() {
    setState(() {
      _isHovered = false;
    });
    if (!_isPressed) {
      // Only stop if not pressed
      _stopAnimation();
    }
  }

  @override
  Widget build(BuildContext context) {
    final effectiveColor =
        widget.color ?? Theme.of(context).iconTheme.color ?? Colors.black87;
    final effectiveHoverColor = widget.hoverColor ?? Colors.grey;

    Widget child = AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return CustomPaint(
          size: Size(widget.size, widget.size),
          painter: widget.createPainter(
            color: (_isHovered || _isPressed)
                ? effectiveHoverColor
                : effectiveColor,
            animationValue: _animation.value,
            strokeWidth: widget.strokeWidth,
          ),
        );
      },
    );

    if (widget.enableTouchInteraction) {
      child = GestureDetector(
        onTapDown: (_) => _onTapDown(),
        onTapUp: (_) => _onTapUp(),
        onTapCancel: () => _onTapCancel(),
        child: child,
      );
    }

    child = MouseRegion(
      onEnter: (_) => _onMouseEnter(),
      onExit: (_) => _onMouseExit(),
      child: child,
    );

    return child;
  }
}
