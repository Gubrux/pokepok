import 'package:dio/dio.dart';
import 'package:pokepok/models/pokemon_details.dart';

class PokemonService {
  final Dio _dio;

  PokemonService(this._dio);

  Future<List<PokemonDetails>> fetchPokemons({required int offset, required int limit}) async {
    final res = await _dio.get(
      '/pokemon',
      queryParameters: {
        'offset': offset,
        'limit': limit,
      },
    );

    final results = List<Map<String, dynamic>>.from(res.data['results']);

    final detailsFutures = results.map((e) => fetchPokemonDetails(e['url']));
    return Future.wait(detailsFutures);
  }

  Future<PokemonDetails> fetchPokemonDetails(String url) async {
    final res = await _dio.getUri(Uri.parse(url));
    return PokemonDetails.fromJson(res.data);
  }
}
