import 'package:flutter/material.dart';

Color colorType(String type) {
  switch (type) {
    case 'fairy':
      return const Color(0xFFD685AD);
    case 'ice':
      return const Color(0xFF96D9D6);
    case 'grass':
      return const Color(0xFF7AC74C);
    case 'dark':
      return const Color(0xFF705746);
    case 'electric':
      return const Color(0xFFF7D02C);
    case 'normal':
      return const Color(0xFFA8A77A);
    case 'fighting':
      return const Color(0xFFC22E28);
    case 'steel':
      return const Color(0xFFB7B7CE);
    case 'poison':
      return const Color(0xFFA33EA1);
    case 'dragon':
      return const Color(0xFF6F35FC);
    case 'bug':
      return const Color(0xFFA6B91A);
    case 'fire':
      return const Color(0xFFEE8130);
    case 'ground':
      return const Color(0xFFE2BF65);
    case 'flying':
      return const Color(0xFFA98FF3);
    case 'psychic':
      return const Color(0xFFF95587);
    case 'water':
      return const Color(0xFF6390F0);
    case 'rock':
      return const Color(0xFFB6A136);
    case 'ghost':
      return const Color(0xFF735797);
    default:
      return Colors.grey;
  }
}
