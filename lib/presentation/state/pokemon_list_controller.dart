// pokemon_list_controller.dart
import 'package:pokedex_app/domain/entities/pokemon_list_state.dart';
import 'package:pokedex_app/domain/entities/pokemon_summary.dart';
import 'package:pokedex_app/domain/repositories/pokemon_repository.dart';
import 'package:pokedex_app/presentation/state/pokemon_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'pokemon_list_controller.g.dart';

@riverpod
class PokemonListController extends _$PokemonListController {
  static const pageSize = 24;

  late final PokemonRepository _repository;

  @override
  PokemonListState build() {
    _repository = ref.read(repositoryProvider);
    return PokemonListState.initial();
  }

  Future<void> loadInitial() async {
    if (state.items.isNotEmpty) {
      return;
    }
    await loadMore(reset: true);
  }

  Future<void> loadMore({bool reset = false}) async {
    if (state.loading) {
      return;
    }
    if (!state.hasMore && !reset) {
      return;
    }

    state = state.copyWith(
      loading: true,
      error: null,
      items: reset ? [] : null,
      offset: reset ? 0 : state.offset,
    );

    try {
      final response = await _repository.getPage(
        offset: state.offset,
        limit: pageSize,
      );

      final merged = [...(reset ? [] : state.items), ...response.items];

      state = state.copyWith(
        items: merged.cast<PokemonSummary>(),
        offset: response.nextOffset,
        hasMore: response.hasMore,
        loading: false,
      );
    } catch (e) {
      state = state.copyWith(loading: false, error: e.toString());
    }
  }
}
