import 'package:pokedex_app/domain/entities/pokemon_detail.dart';
import 'package:pokedex_app/domain/entities/pokemon_summary.dart';

abstract class PokemonRepository {
  Future<({List<PokemonSummary> items, int nextOffset, bool hasMore})> getPage({
    int offset,
    int limit,
  });
  Future<PokemonDetail> getDetail(String nameOrId);
}
