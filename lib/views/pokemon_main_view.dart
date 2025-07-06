import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokepok/models/pokemon_details.dart';
import 'package:pokepok/providers/pokemon_provider.dart';
import 'package:pokepok/views/fav_pokemons.dart';
import 'package:pokepok/widgets/pokemon_header.dart';
import 'package:pokepok/widgets/pokemon_image.dart';
import 'package:pokepok/widgets/stats_table.dart';

class PokemonMainView extends ConsumerWidget {
  final PokemonDetails pokemon;
  const PokemonMainView({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pokemonNotifier = ref.watch(pokemonProvider.notifier);
    final Color backgroundColor = pokemonNotifier.getColorFromPokemonType(pokemon.types[0].typeName);
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        actions: [
          Row(
            children: [
              Text(
                'Mis favoritos',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
              SizedBox(width: 8),
              IconButton(
                icon: Icon(Icons.favorite_border, color: Colors.white),
                iconSize: 40,
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const FavPokemons()),
                  );
                },
              ),
              SizedBox(width: 12),
            ],
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PokemonHeader(
                  pokemonName: pokemon.name,
                  pokemonId: pokemon.id,
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.35),
                StatsTable(
                  attack: pokemon.stats[1].baseStat.toString(),
                  defense: pokemon.stats[2].baseStat.toString(),
                  hp: pokemon.stats[0].baseStat.toString(),
                  type: pokemon.types[0].typeName,
                  backgroundColor: backgroundColor,
                  pokemon: pokemon,
                ),
              ],
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 10,
              bottom: MediaQuery.of(context).size.height * 0.26,
              child: PokemonImage(pokemonImage: pokemon.sprite),
            ),
          ],
        ),
      ),
    );
  }
}
