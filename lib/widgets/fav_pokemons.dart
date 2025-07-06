import 'package:flutter/material.dart';
import 'package:pokepok/widgets/pokemon_card.dart';

class FavPokemons extends StatelessWidget {
  const FavPokemons({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Align(
          alignment: Alignment.centerRight,
          child: Text(
            'Mis favoritos',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
        ),
        backgroundColor: Colors.orange,
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 70),
              child: PokemonCard(),
            ),
          ],
        ),
      ),
    );
  }
}
