import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokepok/views/home_view.dart';
import 'package:pokepok/providers/shared_preferences_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final sharedPreferences = await SharedPreferences.getInstance();

  runApp(
    ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(sharedPreferences),
      ],
      child: const Pokepok(),
    ),
  );
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
