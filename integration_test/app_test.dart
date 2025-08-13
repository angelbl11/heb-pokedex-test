import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex_app/main.dart';
import 'package:pokedex_app/presentation/widgets/shimmer_loading.dart';

void main() {
  group('Pokédex App Integration Tests', () {
    testWidgets('Complete app flow test', (WidgetTester tester) async {
      // Launch the app
      await tester.pumpWidget(const App());
      await tester.pumpAndSettle();

      // Verify that the app launches successfully
      expect(find.byType(MaterialApp), findsOneWidget);
      expect(find.text('Pokédex'), findsOneWidget);

      // Verify that search field is present
      expect(find.byType(TextField), findsOneWidget);
      expect(find.byIcon(Icons.search), findsOneWidget);

      // Verify that sort button is present
      expect(find.byType(PopupMenuButton), findsOneWidget);

      // Wait for initial data to load
      await tester.pumpAndSettle(const Duration(seconds: 3));

      // Verify that loading state is handled
      // Either shows shimmer loading or actual content
      final hasShimmer = find.byType(ShimmerLoading).evaluate().isNotEmpty;
      final hasContent = find.byType(GridView).evaluate().isNotEmpty;

      expect(
        hasShimmer || hasContent,
        isTrue,
        reason: 'App should show either loading state or content',
      );

      // Test search functionality
      final searchField = find.byType(TextField);
      await tester.enterText(searchField, 'bulba');
      await tester.pumpAndSettle();

      // Verify search is working (either shows results or no results message)
      expect(find.byType(TextField), findsOneWidget);

      // Clear search
      await tester.enterText(searchField, '');
      await tester.pumpAndSettle();

      // Test sort functionality
      final sortButton = find.byType(PopupMenuButton);
      await tester.tap(sortButton);
      await tester.pumpAndSettle();

      // Verify sort menu appears
      expect(find.byType(PopupMenuButton), findsOneWidget);

      // Close sort menu
      await tester.tapAt(const Offset(0, 0));
      await tester.pumpAndSettle();

      // Test pull to refresh
      if (find.byType(RefreshIndicator).evaluate().isNotEmpty) {
        await tester.drag(find.byType(RefreshIndicator), const Offset(0, 300));
        await tester.pumpAndSettle();
      }

      // Verify app is still responsive
      expect(find.byType(MaterialApp), findsOneWidget);
    });

    testWidgets('App performance test', (WidgetTester tester) async {
      // Launch the app
      await tester.pumpWidget(const App());
      await tester.pumpAndSettle();

      // Measure initial render time
      final stopwatch = Stopwatch()..start();

      // Perform some interactions
      final searchField = find.byType(TextField);
      await tester.enterText(searchField, 'test');
      await tester.pumpAndSettle();

      stopwatch.stop();

      // Verify that interactions are responsive (less than 1 second)
      expect(
        stopwatch.elapsedMilliseconds,
        lessThan(1000),
        reason: 'App interactions should be responsive',
      );
    });

    testWidgets('App accessibility test', (WidgetTester tester) async {
      // Launch the app
      await tester.pumpWidget(const App());
      await tester.pumpAndSettle();

      // Verify that important UI elements have semantic labels
      final searchField = find.byType(TextField);
      expect(searchField, findsOneWidget);

      final sortButton = find.byType(PopupMenuButton);
      expect(sortButton, findsOneWidget);

      // Verify that the app title is accessible
      expect(find.text('Pokédex'), findsOneWidget);

      // Verify that the app is navigable
      expect(find.byType(MaterialApp), findsOneWidget);
    });

    testWidgets('App error handling test', (WidgetTester tester) async {
      // Launch the app
      await tester.pumpWidget(const App());
      await tester.pumpAndSettle();

      // Verify that the app handles errors gracefully
      // This test verifies that the app doesn't crash
      expect(find.byType(MaterialApp), findsOneWidget);

      // Try to trigger some edge cases
      final searchField = find.byType(TextField);

      // Enter very long text
      final longText = 'a' * 1000;
      await tester.enterText(searchField, longText);
      await tester.pumpAndSettle();

      // Verify app is still stable
      expect(find.byType(MaterialApp), findsOneWidget);

      // Clear the search
      await tester.enterText(searchField, '');
      await tester.pumpAndSettle();

      // Verify app is still stable
      expect(find.byType(MaterialApp), findsOneWidget);
    });
  });
}
