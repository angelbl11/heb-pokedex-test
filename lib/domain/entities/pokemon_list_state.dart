import 'package:pokedex_app/domain/entities/pokemon_summary.dart';

class PokemonListState {
  final List<PokemonSummary> items;
  final int offset;
  final bool hasMore;
  final bool loading;
  final String? error;

  const PokemonListState({
    required this.items,
    required this.offset,
    required this.hasMore,
    required this.loading,
    this.error,
  });

  PokemonListState copyWith({
    List<PokemonSummary>? items,
    int? offset,
    bool? hasMore,
    bool? loading,
    String? error,
  }) => PokemonListState(
    items: items ?? this.items,
    offset: offset ?? this.offset,
    hasMore: hasMore ?? this.hasMore,
    loading: loading ?? this.loading,
    error: error,
  );

  factory PokemonListState.initial() => const PokemonListState(
    items: [],
    offset: 0,
    hasMore: true,
    loading: false,
  );
}
