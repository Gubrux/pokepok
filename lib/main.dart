import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokepok/home_view.dart';

void main() {
  runApp(const ProviderScope(child: Pokepok()));
}

class Pokepok extends StatelessWidget {
  const Pokepok({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pokepok',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const HomeView(),
      // debugShowCheckedModeBanner: false,
    );
  }
}
