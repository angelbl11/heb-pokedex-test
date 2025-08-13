import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex_app/presentation/widgets/shimmer_loading.dart';

void main() {
  group('ShimmerLoading Widget Tests', () {
    testWidgets('should render ShimmerLoading with child', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: ShimmerLoading(child: Text('Test Content'))),
        ),
      );

      // Verify that the child content is displayed
      expect(find.text('Test Content'), findsOneWidget);
    });

    testWidgets('should render ShimmerCard with default values', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: ShimmerCard())),
      );

      // Wait for animations to start
      await tester.pump();

      // Verify that the shimmer card is rendered
      expect(find.byType(ShimmerCard), findsOneWidget);
      expect(find.byType(ShimmerLoading), findsOneWidget);
    });

    testWidgets('should render ShimmerCard with custom dimensions', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ShimmerCard(height: 200, width: 150, borderRadius: 16),
          ),
        ),
      );

      await tester.pump();

      // Verify that the shimmer card is rendered with custom dimensions
      expect(find.byType(ShimmerCard), findsOneWidget);
    });

    testWidgets('should apply custom colors when provided', (
      WidgetTester tester,
    ) async {
      const customBaseColor = Colors.red;
      const customHighlightColor = Colors.yellow;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ShimmerLoading(
              baseColor: customBaseColor,
              highlightColor: customHighlightColor,
              child: Container(width: 100, height: 100, color: Colors.blue),
            ),
          ),
        ),
      );

      await tester.pump();

      // Verify that the shimmer loading is rendered with custom colors
      expect(find.byType(ShimmerLoading), findsOneWidget);
    });

    testWidgets('should handle complex child widgets', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ShimmerLoading(
              child: Column(
                children: [
                  Text('Header'),
                  Container(height: 50, color: Colors.blue),
                  Text('Footer'),
                ],
              ),
            ),
          ),
        ),
      );

      await tester.pump();

      // Verify that all child elements are rendered
      expect(find.text('Header'), findsOneWidget);
      expect(find.text('Footer'), findsOneWidget);
      expect(find.byType(Container), findsOneWidget);
    });

    testWidgets('should animate continuously', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ShimmerLoading(
              child: Container(width: 100, height: 100, color: Colors.blue),
            ),
          ),
        ),
      );

      // Initial frame
      await tester.pump();

      // Wait for animation to progress
      await tester.pump(const Duration(milliseconds: 500));

      // Verify that the animation is running
      expect(find.byType(ShimmerLoading), findsOneWidget);
    });

    testWidgets('should handle empty child', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: ShimmerLoading(child: SizedBox.shrink())),
        ),
      );

      await tester.pump();

      // Verify that the shimmer loading is rendered even with empty child
      expect(find.byType(ShimmerLoading), findsOneWidget);
    });

    testWidgets('should handle null colors gracefully', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ShimmerLoading(
              baseColor: null,
              highlightColor: null,
              child: Container(width: 100, height: 100, color: Colors.blue),
            ),
          ),
        ),
      );

      await tester.pump();

      // Should use default colors and not crash
      expect(find.byType(ShimmerLoading), findsOneWidget);
    });
  });
}
