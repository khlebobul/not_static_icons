import 'package:flutter/material.dart';

/// Controller for programmatic control of AnimatedSVGIcon animations.
///
/// Use this controller when you need to trigger animations externally,
/// for example when using icons inside IconButton or custom widgets.
///
/// Example:
/// ```dart
/// final controller = AnimatedIconController();
///
/// IconButton(
///   onPressed: () {
///     controller.animate();
///     // your action here
///   },
///   icon: AppleIcon(
///     controller: controller,
///     interactive: false, // disable internal gesture handling
///   ),
/// )
/// ```
class AnimatedIconController extends ChangeNotifier {
  VoidCallback? _animateCallback;
  VoidCallback? _stopCallback;
  VoidCallback? _resetCallback;

  /// Triggers the animation to play forward.
  void animate() {
    _animateCallback?.call();
  }

  /// Stops the current animation.
  void stop() {
    _stopCallback?.call();
  }

  /// Resets the animation to its initial state.
  void reset() {
    _resetCallback?.call();
  }

  void _attach({
    required VoidCallback onAnimate,
    required VoidCallback onStop,
    required VoidCallback onReset,
  }) {
    _animateCallback = onAnimate;
    _stopCallback = onStop;
    _resetCallback = onReset;
  }

  void _detach() {
    _animateCallback = null;
    _stopCallback = null;
    _resetCallback = null;
  }
}

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

  /// Callback triggered when the icon is tapped.
  /// Use this instead of wrapping the icon in GestureDetector.
  final VoidCallback? onTap;

  /// When false, disables all internal gesture handling (GestureDetector and MouseRegion).
  /// Use this when placing the icon inside IconButton or other interactive widgets.
  /// Default is true.
  final bool interactive;

  /// Controller for programmatic animation control.
  /// Use with [interactive: false] when placing inside IconButton.
  final AnimatedIconController? controller;

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
    this.onTap,
    this.interactive = true,
    this.controller,
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

    // Attach external controller if provided
    _attachController();
  }

  @override
  void didUpdateWidget(covariant AnimatedSVGIcon oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.controller != widget.controller) {
      oldWidget.controller?._detach();
      _attachController();
    }
  }

  void _attachController() {
    widget.controller?._attach(
      onAnimate: _startAnimation,
      onStop: _stopAnimation,
      onReset: () {
        _controller.reset();
        setState(() {});
      },
    );
  }

  @override
  void dispose() {
    widget.controller?._detach();
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
    // Call onTap callback after animation starts
    widget.onTap?.call();
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

    // If interactive is false, return just the painted widget without gesture handlers
    // This is useful when placing icons inside IconButton or other interactive widgets
    if (!widget.interactive) {
      return child;
    }

    if (widget.enableTouchInteraction) {
      child = GestureDetector(
        behavior: HitTestBehavior.opaque,
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
