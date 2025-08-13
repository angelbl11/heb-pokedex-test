import 'package:dio/dio.dart';
import 'package:pokedex_app/core/errors/failure.dart';
import 'package:pokedex_app/data/models/poke_list_response_model.dart';
import 'package:pokedex_app/data/models/pokemon_detail_model.dart';

class PokeapiRemoteDatasource {
  final Dio dio;
  PokeapiRemoteDatasource(this.dio);

  Future<PokeListResponseModel> fetchPokemonList({
    int offset = 0,
    int limit = 20,
  }) async {
    try {
      final response = await dio.get(
        'pokemon', // Use relative path since baseUrl is configured
        queryParameters: {'offset': offset, 'limit': limit},
      );
      return PokeListResponseModel.fromJson(response.data);
    } on DioException catch (e) {
      final code = e.response?.statusCode;
      throw Exception(
        'Failed to fetch Pokemon list: ${code ?? 'unknown error'}',
      );
    } catch (e) {
      throw Failure('Failed to fetch Pokemon list');
    }
  }

  Future<PokemonDetailModel> fetchPokemonDetail(String name) async {
    try {
      final response = await dio.get('https://pokeapi.co/api/v2/pokemon/$name');
      return PokemonDetailModel.fromJson(response.data);
    } on DioException catch (e) {
      final code = e.response?.statusCode;
      throw Exception(
        'Failed to fetch Pokemon detail: ${code ?? 'unknown error'}',
      );
    } catch (_) {
      throw Failure('Failed to fetch Pokemon detail');
    }
  }
}
