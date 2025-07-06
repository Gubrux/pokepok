import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import '../services/pokemon_service.dart';

final pokemonServiceProvider = Provider<PokemonService>((ref) {
  final dio = Dio(BaseOptions(baseUrl: 'https://pokeapi.co/api/v2'));
  return PokemonService(dio);
});
