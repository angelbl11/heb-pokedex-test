import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex_app/presentation/theme/page_transitions.dart';

// Mock classes for testing
class MockBuildContext extends BuildContext {
  MockBuildContext();

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class MockAnimation extends Animation<double> {
  const MockAnimation();

  @override
  double get value => 1.0;

  @override
  bool get isDismissed => false;

  @override
  bool get isCompleted => true;

  @override
  void addListener(VoidCallback listener) {}

  @override
  void removeListener(VoidCallback listener) {}

  @override
  void addStatusListener(AnimationStatusListener listener) {}

  @override
  void removeStatusListener(AnimationStatusListener listener) {}

  @override
  AnimationStatus get status => AnimationStatus.completed;
}

void main() {
  group('Page Transitions Tests', () {
    late Widget testChild;

    setUp(() {
      testChild = const Scaffold(body: Center(child: Text('Test Page')));
    });

    test('should create slideFromBottom transition', () {
      final route = PokemonPageTransitions.slideFromBottom(child: testChild);

      expect(route, isA<PageRouteBuilder>());
      expect(route.transitionDuration, const Duration(milliseconds: 400));
    });

    test('should create slideFromRight transition', () {
      final route = PokemonPageTransitions.slideFromRight(child: testChild);

      expect(route, isA<PageRouteBuilder>());
      expect(route.transitionDuration, const Duration(milliseconds: 400));
    });

    test('should create fadeScale transition', () {
      final route = PokemonPageTransitions.fadeScale(child: testChild);

      expect(route, isA<PageRouteBuilder>());
      expect(route.transitionDuration, const Duration(milliseconds: 300));
    });

    test('should create slideFromBottomWithFade transition', () {
      final route = PokemonPageTransitions.slideFromBottomWithFade(
        child: testChild,
      );

      expect(route, isA<PageRouteBuilder>());
      expect(route.transitionDuration, const Duration(milliseconds: 500));
    });

    test('should handle settings parameter', () {
      const settings = RouteSettings(name: '/test');
      final route = PokemonPageTransitions.slideFromBottom(
        child: testChild,
        settings: settings,
      );

      expect(route.settings, equals(settings));
    });

    test('should build page correctly', () {
      final route = PokemonPageTransitions.slideFromBottom(child: testChild);

      final page = route.pageBuilder(
        MockBuildContext(),
        const MockAnimation(),
        const MockAnimation(),
      );
      expect(page, equals(testChild));
    });

    test('should handle different child widgets', () {
      final differentChild = const Scaffold(
        body: Center(child: Text('Different Page')),
      );

      final route = PokemonPageTransitions.slideFromRight(
        child: differentChild,
      );

      final page = route.pageBuilder(
        MockBuildContext(),
        const MockAnimation(),
        const MockAnimation(),
      );
      expect(page, equals(differentChild));
    });

    test('should create transitions with correct durations', () {
      final slideBottom = PokemonPageTransitions.slideFromBottom(
        child: testChild,
      );
      final slideRight = PokemonPageTransitions.slideFromRight(
        child: testChild,
      );
      final fadeScale = PokemonPageTransitions.fadeScale(child: testChild);
      final slideBottomFade = PokemonPageTransitions.slideFromBottomWithFade(
        child: testChild,
      );

      expect(slideBottom.transitionDuration, const Duration(milliseconds: 400));
      expect(slideRight.transitionDuration, const Duration(milliseconds: 400));
      expect(fadeScale.transitionDuration, const Duration(milliseconds: 300));
      expect(
        slideBottomFade.transitionDuration,
        const Duration(milliseconds: 500),
      );
    });

    test('should handle default settings', () {
      final route = PokemonPageTransitions.slideFromBottom(child: testChild);

      expect(route.settings, isNotNull);
    });

    test('should create unique route instances', () {
      final route1 = PokemonPageTransitions.slideFromBottom(child: testChild);
      final route2 = PokemonPageTransitions.slideFromBottom(child: testChild);

      expect(route1, isNot(same(route2)));
    });
  });
}
