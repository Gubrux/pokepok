import 'dart:async';
import 'dart:ui';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokepok/color_types.dart';
import 'package:pokepok/models/pokemon_details.dart';
import 'package:pokepok/providers/pokemon_service_provider.dart';

final pokemonProvider = AutoDisposeAsyncNotifierProvider<PokemonNotifier, PokemonState>(() => PokemonNotifier());

class PokemonNotifier extends AutoDisposeAsyncNotifier<PokemonState> {
  @override
  FutureOr<PokemonState> build() async {
    final pokemonService = ref.read(pokemonServiceProvider);
    final pokemons = await pokemonService.fetchPokemons(offset: 0, limit: 5);
    return PokemonState(pokemons: pokemons);
  }

  Color getColorFromPokemonType(String type) {
    return colorType(type);
  }
}

class PokemonState {
  List<PokemonDetails> pokemons;
  List<PokemonDetails>? favorites = [];

  PokemonState({required this.pokemons, this.favorites});

  PokemonState copyWith({List<PokemonDetails>? pokemons, List<PokemonDetails>? favorites}) {
    return PokemonState(pokemons: pokemons ?? this.pokemons, favorites: favorites ?? this.favorites);
  }
}
