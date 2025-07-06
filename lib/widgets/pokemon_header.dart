import 'package:flutter/material.dart';

class PokemonHeader extends StatelessWidget {
  const PokemonHeader({super.key, required this.pokemonName, required this.pokemonId});
  final String pokemonName;
  final int pokemonId;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Pokemon Nro $pokemonId',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          pokemonName[0].toUpperCase() + pokemonName.substring(1),
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
