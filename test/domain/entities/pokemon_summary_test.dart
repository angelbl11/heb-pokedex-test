import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex_app/domain/entities/pokemon_summary.dart';

void main() {
  group('PokemonSummary Entity Tests', () {
    test('should create PokemonSummary with correct values', () {
      const pokemon = PokemonSummary(
        id: 1,
        name: 'bulbasaur',
        imageUrl: 'https://example.com/bulbasaur.png',
      );

      expect(pokemon.id, equals(1));
      expect(pokemon.name, equals('bulbasaur'));
      expect(pokemon.imageUrl, equals('https://example.com/bulbasaur.png'));
    });

    test('should create PokemonSummary with different values', () {
      const pokemon = PokemonSummary(
        id: 25,
        name: 'pikachu',
        imageUrl: 'https://example.com/pikachu.png',
      );

      expect(pokemon.id, equals(25));
      expect(pokemon.name, equals('pikachu'));
      expect(pokemon.imageUrl, equals('https://example.com/pikachu.png'));
    });

    test('should support equality comparison', () {
      const pokemon1 = PokemonSummary(
        id: 1,
        name: 'bulbasaur',
        imageUrl: 'https://example.com/bulbasaur.png',
      );

      const pokemon2 = PokemonSummary(
        id: 1,
        name: 'bulbasaur',
        imageUrl: 'https://example.com/bulbasaur.png',
      );

      expect(pokemon1, equals(pokemon2));
      expect(pokemon1.hashCode, equals(pokemon2.hashCode));
    });

    test('should support inequality comparison', () {
      const pokemon1 = PokemonSummary(
        id: 1,
        name: 'bulbasaur',
        imageUrl: 'https://example.com/bulbasaur.png',
      );

      const pokemon2 = PokemonSummary(
        id: 2,
        name: 'ivysaur',
        imageUrl: 'https://example.com/ivysaur.png',
      );

      expect(pokemon1, isNot(equals(pokemon2)));
      expect(pokemon1.hashCode, isNot(equals(pokemon2.hashCode)));
    });

    test('should handle empty name', () {
      const pokemon = PokemonSummary(
        id: 1,
        name: '',
        imageUrl: 'https://example.com/bulbasaur.png',
      );

      expect(pokemon.name, equals(''));
    });

    test('should handle long URLs', () {
      const longUrl =
          'https://example.com/very/long/url/with/many/segments/and/parameters?param1=value1&param2=value2';
      const pokemon = PokemonSummary(
        id: 1,
        name: 'bulbasaur',
        imageUrl: longUrl,
      );

      expect(pokemon.imageUrl, equals(longUrl));
    });
  });
}
