import 'package:pokedex_app/data/datasources/pokeapi_remote_datasource.dart';
import 'package:pokedex_app/data/models/poke_list_response_model.dart';
import 'package:pokedex_app/domain/entities/pokemon_detail.dart';
import 'package:pokedex_app/domain/entities/pokemon_summary.dart';
import 'package:pokedex_app/domain/repositories/pokemon_repository.dart';

class PokemonRepositoryImpl extends PokemonRepository {
  final PokeapiRemoteDatasource remoteDatasource;
  PokemonRepositoryImpl(this.remoteDatasource);

  @override
  Future<({List<PokemonSummary> items, int nextOffset, bool hasMore})> getPage({
    int offset = 0,
    int limit = 20,
  }) async {
    final response = await remoteDatasource.fetchPokemonList(
      offset: offset,
      limit: limit,
    );

    final items = response.results.map((result) {
      return PokemonSummary(
        id: result.id,
        name: result.name,
        imageUrl: result.imageUrl,
      );
    }).toList();

    final hasMore = response.next.isNotEmpty;
    final nextOffset = hasMore ? offset + limit : offset;

    return (items: items, nextOffset: nextOffset, hasMore: hasMore);
  }

  @override
  Future<PokemonDetail> getDetail(String name) async {
    final detail = await remoteDatasource.fetchPokemonDetail(name);
    return PokemonDetail(
      id: detail.id,
      name: detail.name,
      imageUrl: imageUrlForId(detail.id),
      types: detail.types,
      abilities: detail.abilities,
      stats: detail.stats,
      weight: detail.weight,
      height: detail.height,
    );
  }
}
