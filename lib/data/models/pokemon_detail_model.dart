// To parse this JSON data, do
//
//   final pokemonDetailModel = pokemonDetailModelFromJson(jsonString);

import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

part 'pokemon_detail_model.g.dart';

PokemonDetailModel pokemonDetailModelFromJson(String str) =>
    PokemonDetailModel.fromJson(json.decode(str) as Map<String, dynamic>);

String pokemonDetailModelToJson(PokemonDetailModel data) =>
    json.encode(data.toJson());

@JsonSerializable(createFactory: false)
class PokemonDetailModel {
  final int id;
  final String name;
  final String? sprite;
  final List<String> types;
  final List<String> abilities;
  final Map<String, int> stats;
  final int weight;
  final int height;

  const PokemonDetailModel({
    required this.id,
    required this.name,
    required this.sprite,
    required this.types,
    required this.abilities,
    required this.stats,
    required this.weight,
    required this.height,
  });

  factory PokemonDetailModel.fromJson(Map<String, dynamic> json) {
    // Tipos
    final types = (json['types'] as List<dynamic>)
        .map((e) => (e as Map<String, dynamic>)['type']['name'] as String)
        .toList();

    final abilities = (json['abilities'] as List<dynamic>)
        .map((e) => (e as Map<String, dynamic>)['ability']['name'] as String)
        .toList();

    final stats = <String, int>{};
    for (final s in (json['stats'] as List<dynamic>)) {
      final m = s as Map<String, dynamic>;
      final key = m['stat']['name'] as String;
      final value = (m['base_stat'] as num).toInt();
      stats[key] = value;
    }

    final sprites = json['sprites'] as Map<String, dynamic>?;
    final String? sprite =
        (sprites?['other']
                as Map<String, dynamic>?)?['official-artwork']?['front_default']
            as String? ??
        sprites?['front_default'] as String?;

    return PokemonDetailModel(
      id: json['id'] as int,
      name: json['name'] as String,
      sprite: sprite,
      types: types,
      abilities: abilities,
      stats: stats,
      weight: json['weight'] as int,
      height: json['height'] as int,
    );
  }

  Map<String, dynamic> toJson() => _$PokemonDetailModelToJson(this);
}
