import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex_app/domain/entities/pokemon_list_state.dart';
import 'package:pokedex_app/domain/entities/pokemon_summary.dart';

void main() {
  group('PokemonListState Entity Tests', () {
    late PokemonSummary testPokemon;

    setUp(() {
      testPokemon = const PokemonSummary(
        id: 1,
        name: 'bulbasaur',
        imageUrl: 'https://example.com/bulbasaur.png',
      );
    });

    test('should create initial state correctly', () {
      final state = PokemonListState.initial();

      expect(state.items, isEmpty);
      expect(state.loading, isFalse);
      expect(state.error, isNull);
      expect(state.hasMore, isTrue);
      expect(state.offset, equals(0));
    });

    test('should create state with items', () {
      final state = PokemonListState(
        items: [testPokemon],
        loading: false,
        error: null,
        hasMore: true,
        offset: 20,
      );

      expect(state.items, hasLength(1));
      expect(state.items.first, equals(testPokemon));
      expect(state.loading, isFalse);
      expect(state.error, isNull);
      expect(state.hasMore, isTrue);
      expect(state.offset, equals(20));
    });

    test('should create loading state', () {
      final state = PokemonListState(
        items: [testPokemon],
        loading: true,
        error: null,
        hasMore: true,
        offset: 20,
      );

      expect(state.loading, isTrue);
      expect(state.items, hasLength(1));
    });

    test('should create error state', () {
      const errorMessage = 'Network error occurred';
      final state = PokemonListState(
        items: [testPokemon],
        loading: false,
        error: errorMessage,
        hasMore: true,
        offset: 20,
      );

      expect(state.error, equals(errorMessage));
      expect(state.loading, isFalse);
    });

    test('should create state with no more items', () {
      final state = PokemonListState(
        items: [testPokemon],
        loading: false,
        error: null,
        hasMore: false,
        offset: 20,
      );

      expect(state.hasMore, isFalse);
    });

    test('should support property comparison', () {
      final state1 = PokemonListState(
        items: [testPokemon],
        loading: false,
        error: null,
        hasMore: true,
        offset: 20,
      );

      final state2 = PokemonListState(
        items: [testPokemon],
        loading: false,
        error: null,
        hasMore: true,
        offset: 20,
      );

      expect(state1.items, equals(state2.items));
      expect(state1.loading, equals(state2.loading));
      expect(state1.error, equals(state2.error));
      expect(state1.hasMore, equals(state2.hasMore));
      expect(state1.offset, equals(state2.offset));
    });

    test('should support property inequality comparison', () {
      final state1 = PokemonListState(
        items: [testPokemon],
        loading: false,
        error: null,
        hasMore: true,
        offset: 20,
      );

      final state2 = PokemonListState(
        items: [testPokemon],
        loading: true,
        error: null,
        hasMore: true,
        offset: 20,
      );

      expect(state1.loading, isNot(equals(state2.loading)));
    });

    test('should handle empty items list', () {
      final state = PokemonListState(
        items: [],
        loading: false,
        error: null,
        hasMore: true,
        offset: 0,
      );

      expect(state.items, isEmpty);
      expect(state.offset, equals(0));
    });

    test('should handle multiple items', () {
      final pokemon2 = const PokemonSummary(
        id: 2,
        name: 'ivysaur',
        imageUrl: 'https://example.com/ivysaur.png',
      );

      final state = PokemonListState(
        items: [testPokemon, pokemon2],
        loading: false,
        error: null,
        hasMore: true,
        offset: 40,
      );

      expect(state.items, hasLength(2));
      expect(state.items.first, equals(testPokemon));
      expect(state.items.last, equals(pokemon2));
      expect(state.offset, equals(40));
    });
  });
}
