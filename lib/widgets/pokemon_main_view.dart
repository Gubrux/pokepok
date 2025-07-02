import 'package:flutter/material.dart';
import 'package:pokepok/widgets/stats_table.dart';

class PokemonMainView extends StatelessWidget {
  const PokemonMainView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Pokemon nro 1', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black, fontFamily: 'Poppins')),
        Text('Roberrrt', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: Colors.black, fontFamily: 'Poppins')),
        Image.asset('assets/charmander.jpg', width: 100, height: 100),
        StatsTable(),
      ],
    );
  }
}
