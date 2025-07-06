import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokepok/providers/pokemon_provider.dart';
import 'package:pokepok/widgets/pokemon_card.dart';

class FavPokemons extends ConsumerWidget {
  const FavPokemons({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pokemonAsyncValue = ref.watch(pokemonProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Align(
          alignment: Alignment.centerRight,
          child: Text(
            'Mis favoritos',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.black, size: 40),
      ),
      body: pokemonAsyncValue.when(
        data: (pokemonState) {
          final favorites = pokemonState.favorites ?? [];

          if (favorites.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.favorite_border,
                    size: 64,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 16),
                  Text(
                    'No tienes pokémones favoritos',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Agrega algunos usando "Yo te elijo!"',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            );
          }

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                final pokemon = favorites[index];
                final pokemonNotifier = ref.read(pokemonProvider.notifier);
                final backgroundColor = pokemonNotifier.getColorFromPokemonType(pokemon.types[0].typeName);

                return PokemonCard(
                  backgroundColor: backgroundColor,
                  pokemon: pokemon,
                  onDelete: () {
                    pokemonNotifier.toggleFavorite(pokemon);
                  },
                );
              },
            ),
          );
        },
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        error: (error, stackTrace) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.error_outline,
                size: 64,
                color: Colors.red,
              ),
              const SizedBox(height: 16),
              Text(
                'Error al cargar favoritos',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.red[700],
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Error: $error',
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
