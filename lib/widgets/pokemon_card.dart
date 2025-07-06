import 'package:flutter/material.dart';
import 'package:pokepok/models/pokemon_details.dart';

class PokemonCard extends StatelessWidget {
  final Color backgroundColor;
  final PokemonDetails pokemon;
  final void Function() onDelete;
  const PokemonCard({super.key, required this.backgroundColor, required this.pokemon, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: backgroundColor.withValues(alpha: 0.3),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          SizedBox(
            height: 80,
            child: Image.network(
              pokemon.sprite,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(
                  Icons.catching_pokemon,
                  color: Colors.white,
                  size: 30,
                );
              },
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              pokemon.name[0].toUpperCase() + pokemon.name.substring(1),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          IconButton(
            onPressed: () async {
              final bool? shouldDelete = await showDialog<bool>(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Eliminar favorito'),
                    content: Text('¿Estás seguro que quieres eliminar a ${pokemon.name[0].toUpperCase() + pokemon.name.substring(1)} de tus favoritos?'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(false),
                        child: const Text('Cancelar'),
                      ),
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(true),
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.red,
                        ),
                        child: const Text('Eliminar'),
                      ),
                    ],
                  );
                },
              );

              if (shouldDelete == true) {
                onDelete();
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('${pokemon.name[0].toUpperCase() + pokemon.name.substring(1)} eliminado de favoritos'),
                      duration: const Duration(seconds: 2),
                      backgroundColor: Colors.orange,
                    ),
                  );
                }
              }
            },
            icon: const Icon(
              Icons.delete_outline_rounded,
              color: Colors.white,
              size: 38,
            ),
          ),
        ],
      ),
    );
  }
}
