import 'package:pokedex_app/domain/entities/pokemon_detail.dart';
import 'package:pokedex_app/presentation/state/pokemon_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

final pokemonDetailProvider = FutureProvider.family<PokemonDetail, String>((
  ref,
  nameOrId,
) async {
  final repo = ref.watch(repositoryProvider);
  return repo.getDetail(nameOrId);
});
