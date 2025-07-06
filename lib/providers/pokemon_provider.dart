import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:ui';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokepok/utils/color_types.dart';
import 'package:pokepok/models/pokemon_details.dart';
import 'package:pokepok/providers/pokemon_service_provider.dart';
import 'package:pokepok/providers/shared_preferences_provider.dart';

final pokemonProvider = AutoDisposeAsyncNotifierProvider<PokemonNotifier, PokemonState>(() => PokemonNotifier());

class PokemonNotifier extends AutoDisposeAsyncNotifier<PokemonState> {
  int _offset = 0;
  final int _limit = 5;
  bool _isLoading = false;
  bool _hasMore = true;
  static const String _favoritesKey = 'favorite_pokemons';

  @override
  FutureOr<PokemonState> build() async {
    final pokemonService = ref.read(pokemonServiceProvider);
    final pokemons = await pokemonService.fetchPokemons(offset: _offset, limit: _limit);
    _offset += _limit;

    final favorites = await _loadFavorites();

    return PokemonState(pokemons: pokemons, favorites: favorites);
  }

  Future<List<PokemonDetails>> _loadFavorites() async {
    try {
      final prefs = ref.read(sharedPreferencesProvider);
      final favoritesJson = prefs.getStringList(_favoritesKey) ?? [];

      return favoritesJson.map((jsonString) => PokemonDetails.fromJson(json.decode(jsonString))).toList();
    } catch (e) {
      return [];
    }
  }

  Future<void> _saveFavorites(List<PokemonDetails> favorites) async {
    try {
      final prefs = ref.read(sharedPreferencesProvider);
      final favoritesJson = favorites.map((pokemon) => json.encode(pokemon.toJson())).toList();

      await prefs.setStringList(_favoritesKey, favoritesJson);
    } catch (e) {
      log('Error saving favorites: $e');
    }
  }

  Future<void> toggleFavorite(PokemonDetails pokemon) async {
    final currentState = state.value;
    if (currentState == null) return;

    final currentFavorites = List<PokemonDetails>.from(currentState.favorites ?? []);
    final isAlreadyFavorite = currentFavorites.any((fav) => fav.id == pokemon.id);

    if (isAlreadyFavorite) {
      currentFavorites.removeWhere((fav) => fav.id == pokemon.id);
    } else {
      currentFavorites.add(pokemon);
    }

    await _saveFavorites(currentFavorites);

    state = AsyncData(currentState.copyWith(favorites: currentFavorites));
  }

  bool isFavorite(PokemonDetails pokemon) {
    final currentState = state.value;
    if (currentState?.favorites == null) return false;

    return currentState!.favorites!.any((fav) => fav.id == pokemon.id);
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
