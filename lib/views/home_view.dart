import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokepok/providers/pokemon_provider.dart';
import 'package:pokepok/views/pokemon_main_view.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();

    _pageController.addListener(() {
      final notifier = ref.read(pokemonProvider.notifier);
      final currentPage = _pageController.page;

      final totalPages = ref.read(pokemonProvider).maybeWhen(
            data: (data) => data.pokemons.length,
            orElse: () => 0,
          );

      if (currentPage != null && currentPage >= totalPages - 2) {
        notifier.fetchMorePokemons();
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pokemon = ref.watch(pokemonProvider);

    return pokemon.when(
      data: (data) {
        return PageView.builder(
          controller: _pageController,
          scrollDirection: Axis.vertical,
          itemCount: data.pokemons.length,
          itemBuilder: (context, index) => PokemonMainView(pokemon: data.pokemons[index]),
        );
      },
      error: (error, stackTrace) => Scaffold(
        body: Center(
          child: Text(
            error.toString(),
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      loading: () => Center(
        child: const CircularProgressIndicator(),
      ),
    );
  }
}
