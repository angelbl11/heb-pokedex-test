import 'package:flutter/material.dart';

/// Global animation configuration and helper methods for the Pokédex app
class AppAnimations {
  // Standard animation durations
  static const Duration fast = Duration(milliseconds: 200);
  static const Duration normal = Duration(milliseconds: 300);
  static const Duration slow = Duration(milliseconds: 500);
  static const Duration verySlow = Duration(milliseconds: 800);

  // Predefined animation curves
  static const Curve bounce = Curves.elasticOut;
  static const Curve smooth = Curves.easeInOutCubic;
  static const Curve slide = Curves.easeOutCubic;
  static const Curve fade = Curves.easeOut;

  // Entrance animation configuration
  static const Duration staggerDelay = Duration(milliseconds: 50);
  static const Duration cardAnimationDelay = Duration(milliseconds: 100);

  // Page transition configuration
  static const Duration pageTransitionDuration = Duration(milliseconds: 400);
  static const Curve pageTransitionCurve = Curves.easeInOutCubic;

  // Hover animation configuration
  static const Duration hoverDuration = Duration(milliseconds: 150);
  static const double hoverScale = 1.05;
  static const double hoverElevation = 8.0;

  // Loading animation configuration
  static const Duration shimmerDuration = Duration(milliseconds: 1500);
  static const Curve shimmerCurve = Curves.easeInOutSine;

  // Stats and abilities animation configuration
  static const Duration statsAnimationDelay = Duration(milliseconds: 80);
  static const Duration abilitiesAnimationDelay = Duration(milliseconds: 100);

  /// Creates a staggered animation with delay based on index
  static Animation<double> createStaggeredAnimation(
    AnimationController controller,
    int index,
    Duration baseDelay,
    Duration totalDuration,
  ) {
    final delay = index * baseDelay.inMilliseconds;
    final interval = delay / totalDuration.inMilliseconds;

    return Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(interval, 1.0, curve: Curves.easeOutCubic),
      ),
    );
  }

  /// Creates a standard entrance animation
  static Animation<double> createEntranceAnimation(
    AnimationController controller, {
    Curve curve = Curves.easeOutCubic,
    Duration? duration,
  }) {
    return Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: controller, curve: curve));
  }

  /// Creates a scale animation with custom range
  static Animation<double> createScaleAnimation(
    AnimationController controller, {
    double begin = 0.8,
    double end = 1.0,
    Curve curve = Curves.elasticOut,
  }) {
    return Tween<double>(
      begin: begin,
      end: end,
    ).animate(CurvedAnimation(parent: controller, curve: curve));
  }

  /// Creates a slide animation with custom offset range
  static Animation<Offset> createSlideAnimation(
    AnimationController controller, {
    Offset begin = const Offset(0, 0.3),
    Offset end = Offset.zero,
    Curve curve = Curves.easeOutCubic,
  }) {
    return Tween<Offset>(
      begin: begin,
      end: end,
    ).animate(CurvedAnimation(parent: controller, curve: curve));
  }
}
