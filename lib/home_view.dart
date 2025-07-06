import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokepok/providers/pokemon_provider.dart';
import 'package:pokepok/widgets/fav_pokemons.dart';
import 'package:pokepok/widgets/pokemon_main_view.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  @override
  Widget build(BuildContext context) {
    final pokemon = ref.watch(pokemonProvider);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: null,
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
                    MaterialPageRoute(builder: (context) => FavPokemons()),
                  );
                },
              ),
              SizedBox(width: 12),
            ],
          ),
        ],
      ),
      body: pokemon.when(
        data: (data) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: PageView.builder(
              scrollDirection: Axis.vertical,
              itemCount: data.pokemons.length,
              itemBuilder: (context, index) => PokemonMainView(pokemon: data.pokemons[index]),
            ),
          );
        },
        error: (error, stackTrace) => Center(
          child: Text(
            error.toString(),
          ),
        ),
        loading: () => Center(
          child: const CircularProgressIndicator(),
        ),
      ),
    );
  }
}
