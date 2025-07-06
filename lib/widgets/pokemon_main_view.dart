import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokepok/models/pokemon_details.dart';
import 'package:pokepok/providers/pokemon_provider.dart';
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
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PokemonHeader(
                pokemonName: pokemon.name,
                pokemonId: pokemon.id,
              ),
              const SizedBox(height: 300),
              StatsTable(
                attack: pokemon.stats[1].baseStat.toString(),
                defense: pokemon.stats[2].baseStat.toString(),
                hp: pokemon.stats[0].baseStat.toString(),
                type: pokemon.types[0].typeName,
                backgroundColor: backgroundColor,
              ),
            ],
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 10,
            bottom: 300,
            child: PokemonImage(pokemonImage: pokemon.sprite),
          ),
        ],
      ),
    );
  }
}
