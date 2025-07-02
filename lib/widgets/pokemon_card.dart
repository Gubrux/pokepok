import 'package:flutter/material.dart';

class PokemonCard extends StatelessWidget {
  const PokemonCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 100,
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image.asset(
            'assets/charmander.jpg',
            width: 100,
            height: 100,
          ),
          Text(
            'Roberrrt',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black, fontFamily: 'Poppins'),
          ),
          Icon(
            Icons.delete_outline,
            // Icons.delete_outline,
            color: Colors.white,
            size: 40,
          ),
        ],
      ),
    );
  }
}
