import 'package:flutter/material.dart';
import 'package:pokepok/widgets/fav_pokemons.dart';
import 'package:pokepok/widgets/pokemon_main_view.dart';

void main() {
  runApp(const Pokepok());
}

class Pokepok extends StatelessWidget {
  const Pokepok({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pokepok',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Pokepok Main Peiyi'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
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
                  color: const Color.fromARGB(255, 200, 35, 35),
                  fontSize: 18,
                ),
              ),
              SizedBox(width: 8),
              IconButton(
                icon: Icon(Icons.favorite_border, color: Colors.red[400]),
                iconSize: 40,
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => FavPokemons()),
                  );
                },
              ),
              SizedBox(width: 12), // Espacio al borde derecho
            ],
          ),
        ],
      ),
      body: PokemonMainView(),
    );
  }
}
