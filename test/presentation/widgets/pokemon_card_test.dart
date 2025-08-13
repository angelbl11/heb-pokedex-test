import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex_app/domain/entities/pokemon_summary.dart';
import 'package:pokedex_app/presentation/widgets/pokemon_card.dart';

void main() {
  group('PokemonCard Widget Tests', () {
    late PokemonSummary testPokemon;
    late VoidCallback mockOnTap;

    setUp(() {
      testPokemon = const PokemonSummary(
        id: 1,
        name: 'bulbasaur',
        imageUrl: 'https://example.com/bulbasaur.png',
      );
      mockOnTap = () {};
    });

    Widget createTestWidget({int index = 0}) {
      return MaterialApp(
        home: Scaffold(
          body: PokemonCard(item: testPokemon, onTap: mockOnTap, index: index),
        ),
      );
    }

    testWidgets('should render PokemonCard with correct information', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(createTestWidget());

      // Wait for animations to complete
      await tester.pumpAndSettle();

      // Verify that the Pokémon name is displayed
      expect(find.text('Bulbasaur'), findsOneWidget);

      // Verify that the Pokémon ID is displayed
      expect(find.text('#001'), findsOneWidget);

      // Verify that the image is present
      expect(find.byType(Image), findsOneWidget);
    });

    testWidgets('should call onTap when card is tapped', (
      WidgetTester tester,
    ) async {
      bool onTapCalled = false;
      testOnTap() => onTapCalled = true;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PokemonCard(item: testPokemon, onTap: testOnTap, index: 0),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Tap the card
      await tester.tap(find.byType(InkWell));
      await tester.pump();

      // Verify that onTap was called
      expect(onTapCalled, isTrue);
    });

    testWidgets('should display different Pokémon correctly', (
      WidgetTester tester,
    ) async {
      final differentPokemon = const PokemonSummary(
        id: 25,
        name: 'pikachu',
        imageUrl: 'https://example.com/pikachu.png',
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PokemonCard(
              item: differentPokemon,
              onTap: mockOnTap,
              index: 0,
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Verify that the correct Pokémon name is displayed
      expect(find.text('Pikachu'), findsOneWidget);

      // Verify that the correct Pokémon ID is displayed
      expect(find.text('#025'), findsOneWidget);
    });

    testWidgets('should handle empty name gracefully', (
      WidgetTester tester,
    ) async {
      final emptyNamePokemon = const PokemonSummary(
        id: 1,
        name: '',
        imageUrl: 'https://example.com/bulbasaur.png',
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PokemonCard(
              item: emptyNamePokemon,
              onTap: mockOnTap,
              index: 0,
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Should not crash and should display empty text
      expect(find.text(''), findsOneWidget);
    });

    testWidgets('should display correct ID format for single digit', (
      WidgetTester tester,
    ) async {
      final singleDigitPokemon = const PokemonSummary(
        id: 9,
        name: 'blastoise',
        imageUrl: 'https://example.com/blastoise.png',
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PokemonCard(
              item: singleDigitPokemon,
              onTap: mockOnTap,
              index: 0,
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Should display #009
      expect(find.text('#009'), findsOneWidget);
    });

    testWidgets('should display correct ID format for double digit', (
      WidgetTester tester,
    ) async {
      final doubleDigitPokemon = const PokemonSummary(
        id: 25,
        name: 'pikachu',
        imageUrl: 'https://example.com/pikachu.png',
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PokemonCard(
              item: doubleDigitPokemon,
              onTap: mockOnTap,
              index: 0,
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Should display #025
      expect(find.text('#025'), findsOneWidget);
    });

    testWidgets('should display correct ID format for triple digit', (
      WidgetTester tester,
    ) async {
      final tripleDigitPokemon = const PokemonSummary(
        id: 150,
        name: 'mewtwo',
        imageUrl: 'https://example.com/mewtwo.png',
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PokemonCard(
              item: tripleDigitPokemon,
              onTap: mockOnTap,
              index: 0,
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Should display #150
      expect(find.text('#150'), findsOneWidget);
    });
  });
}
