import 'package:flutter/material.dart';

/// Central place to define colors for Pokémon types.
/// Use [typeColor] to get the primary color for a given type.
const Map<String, Color> _kTypeToColor = {
  'grass': Color(0xFF78C850),
  'fire': Color(0xFFF08030),
  'water': Color(0xFF6890F0),
  'electric': Color(0xFFF8D030),
  'bug': Color(0xFFA8B820),
  'poison': Color(0xFFA040A0),
  'flying': Color(0xFFA890F0),
  'ground': Color(0xFFE0C068),
  'rock': Color(0xFFB8A038),
  'psychic': Color(0xFFF85888),
  'ice': Color(0xFF98D8D8),
  'dragon': Color(0xFF7038F8),
  'dark': Color(0xFF705848),
  'steel': Color(0xFFB8B8D0),
  'fairy': Color(0xFFEE99AC),
};

Color typeColor(String type) {
  final key = type.toLowerCase();
  return _kTypeToColor[key] ?? const Color(0xFF8A8A8A);
}
