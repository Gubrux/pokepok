import 'dart:async';
import 'dart:ui';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokepok/color_types.dart';
import 'package:pokepok/models/pokemon_details.dart';
import 'package:pokepok/providers/pokemon_service_provider.dart';

final pokemonProvider = AutoDisposeAsyncNotifierProvider<PokemonNotifier, PokemonState>(() => PokemonNotifier());

class PokemonNotifier extends AutoDisposeAsyncNotifier<PokemonState> {
  int _offset = 5;
  final int _limit = 5;
  bool _isLoading = false;
  bool _hasMore = true;

  @override
  FutureOr<PokemonState> build() async {
    final pokemonService = ref.read(pokemonServiceProvider);
    final pokemons = await pokemonService.fetchPokemons(offset: 0, limit: 5);
    return PokemonState(pokemons: pokemons);
  }

  Future<void> fetchMorePokemons() async {
    if (_isLoading || !_hasMore) return;

    _isLoading = true;
    final pokemonService = ref.read(pokemonServiceProvider);

    try {
      final newPokemons = await pokemonService.fetchPokemons(offset: _offset, limit: _limit);
      _offset += _limit;

      if (newPokemons.isEmpty) {
        _hasMore = false;
        return;
      }

      final currentState = state.value ?? PokemonState(pokemons: []);
      final updatedList = [...currentState.pokemons, ...newPokemons];
      state = AsyncData(currentState.copyWith(pokemons: updatedList));
    } catch (e, st) {
      state = AsyncError(e, st);
    } finally {
      _isLoading = false;
    }
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
