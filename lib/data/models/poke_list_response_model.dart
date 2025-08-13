import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'poke_list_response_model.g.dart';

int _idFromUrl(String url) {
  final parts = url.split('/').where((e) => e.isNotEmpty).toList();
  return int.parse(parts.last);
}

String imageUrlForId(int id) =>
    'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/$id.png';

PokeListResponseModel pokeListResponseModelFromJson(String str) =>
    PokeListResponseModel.fromJson(json.decode(str));

String pokeListResponseModelToJson(PokeListResponseModel data) =>
    json.encode(data.toJson());

@JsonSerializable()
class PokeListResponseModel {
  @JsonKey(name: "count")
  int count;
  @JsonKey(name: "next")
  String next;
  @JsonKey(name: "previous")
  dynamic previous;
  @JsonKey(name: "results")
  List<Result> results;

  PokeListResponseModel({
    required this.count,
    required this.next,
    required this.previous,
    required this.results,
  });

  factory PokeListResponseModel.fromJson(Map<String, dynamic> json) =>
      _$PokeListResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$PokeListResponseModelToJson(this);
}

@JsonSerializable()
class Result {
  @JsonKey(name: "name")
  String name;
  @JsonKey(name: "url")
  String url;

  int get id => _idFromUrl(url);
  String get imageUrl => imageUrlForId(id);

  Result({required this.name, required this.url});

  factory Result.fromJson(Map<String, dynamic> json) => _$ResultFromJson(json);

  Map<String, dynamic> toJson() => _$ResultToJson(this);
}
