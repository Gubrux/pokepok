import 'package:flutter/material.dart';

class PokemonImage extends StatelessWidget {
  const PokemonImage({super.key, required this.pokemonImage});
  final String pokemonImage;

  @override
  Widget build(BuildContext context) {
    return Image.network(pokemonImage, width: 300, height: 300);
  }
}
