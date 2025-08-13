import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex_app/main.dart';

void main() {
  group('Pokédex App Widget Tests', () {
    testWidgets('App renders without crashing', (WidgetTester tester) async {
      // Build our app and trigger a frame
      await tester.pumpWidget(const ProviderScope(child: App()));

      // Verify that the app renders
      expect(find.byType(MaterialApp), findsOneWidget);

      // Wait for any pending timers to complete
      await tester.pumpAndSettle();
    });

    testWidgets('App shows Pokédex title', (WidgetTester tester) async {
      await tester.pumpWidget(const ProviderScope(child: App()));

      // Wait for the app to fully load
      await tester.pumpAndSettle();

      // Verify that the Pokédex title is displayed
      expect(find.text('Pokédex'), findsOneWidget);
    });

    testWidgets('Search field is present', (WidgetTester tester) async {
      await tester.pumpWidget(const ProviderScope(child: App()));

      await tester.pumpAndSettle();

      // Verify that the search field is present
      expect(find.byType(TextField), findsOneWidget);
      expect(find.byIcon(Icons.search), findsOneWidget);
    });

    testWidgets('App has search functionality', (WidgetTester tester) async {
      await tester.pumpWidget(const ProviderScope(child: App()));

      // Wait for the app to fully load and any timers to complete
      await tester.pumpAndSettle(const Duration(seconds: 3));

      // Verify that the search field is present
      expect(find.byType(TextField), findsOneWidget);
      expect(find.byIcon(Icons.search), findsOneWidget);
    });
  });
}
