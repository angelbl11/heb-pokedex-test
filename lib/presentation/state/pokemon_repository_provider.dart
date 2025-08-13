import 'package:pokedex_app/core/network/dio_provider.dart';
import 'package:pokedex_app/data/datasources/pokeapi_remote_datasource.dart';
import 'package:pokedex_app/data/repositories/pokemon_repository_impl.dart';
import 'package:pokedex_app/domain/repositories/pokemon_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'pokemon_repository_provider.g.dart';

@riverpod
PokemonRepository repository(ref) {
  final dio = ref.watch(dioControllerProvider);
  return PokemonRepositoryImpl(PokeapiRemoteDatasource(dio));
}
