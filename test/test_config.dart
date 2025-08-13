import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// Test configuration and utilities for the Pokédex app
class TestConfig {
  /// Creates a test MaterialApp with ProviderScope
  static Widget createTestApp({
    required Widget child,
    bool includeProviderScope = true,
  }) {
    final app = MaterialApp(home: child, debugShowCheckedModeBanner: false);

    if (includeProviderScope) {
      // Note: ProviderScope would be added here if needed
      // For now, we'll return the basic MaterialApp
      return app;
    }

    return app;
  }

  /// Creates a test Scaffold
  static Widget createTestScaffold({
    required Widget body,
    PreferredSizeWidget? appBar,
  }) {
    return Scaffold(appBar: appBar, body: body);
  }

  /// Waits for animations to complete
  static Future<void> waitForAnimations(WidgetTester tester) async {
    await tester.pumpAndSettle();
  }

  /// Pumps the widget tree multiple times to simulate time passing
  static Future<void> pumpMultipleTimes(
    WidgetTester tester, {
    int times = 3,
    Duration duration = const Duration(milliseconds: 100),
  }) async {
    for (int i = 0; i < times; i++) {
      await tester.pump(duration);
    }
  }

  /// Finds a widget by type and verifies it exists
  static T findWidget<T extends Widget>(WidgetTester tester) {
    final widget = tester.widget<T>(find.byType(T));
    expect(widget, isNotNull);
    return widget;
  }

  /// Finds text and verifies it exists
  static String findText(WidgetTester tester, String text) {
    final finder = find.text(text);
    expect(finder, findsOneWidget);
    return tester.widget<Text>(finder).data!;
  }

  /// Taps a widget and waits for animations
  static Future<void> tapAndWait(WidgetTester tester, Finder finder) async {
    await tester.tap(finder);
    await tester.pumpAndSettle();
  }

  /// Enters text and waits for animations
  static Future<void> enterTextAndWait(
    WidgetTester tester,
    Finder finder,
    String text,
  ) async {
    await tester.enterText(finder, text);
    await tester.pumpAndSettle();
  }

  /// Scrolls to find a widget
  static Future<void> scrollToFind(
    WidgetTester tester,
    Finder finder, {
    Duration duration = const Duration(milliseconds: 300),
  }) async {
    await tester.scrollUntilVisible(
      finder,
      500.0,
      scrollable: find.byType(Scrollable),
    );
    await tester.pumpAndSettle(duration);
  }
}

/// Common test data for the Pokédex app
class TestData {
  /// Sample Pokémon data for testing
  static const samplePokemonNames = [
    'bulbasaur',
    'ivysaur',
    'venusaur',
    'charmander',
    'charmeleon',
    'charizard',
  ];

  /// Sample Pokémon IDs for testing
  static const samplePokemonIds = [1, 2, 3, 4, 5, 6];

  /// Sample image URLs for testing
  static const sampleImageUrls = [
    'https://example.com/bulbasaur.png',
    'https://example.com/ivysaur.png',
    'https://example.com/venusaur.png',
  ];

  /// Sample search queries for testing
  static const sampleSearchQueries = [
    'bulba',
    'char',
    'saur',
    '001',
    '#001',
    '25',
    '#025',
  ];

  /// Sample error messages for testing
  static const sampleErrorMessages = [
    'Network error occurred',
    'Failed to fetch data',
    'Server unavailable',
    'Invalid response format',
  ];
}
