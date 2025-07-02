class Pokemon {
  final int id;
  final String name;
  final String imageUrl;
  final int attack;
  final int defense;
  final int hp;
  final String type;

  Pokemon({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.attack,
    required this.defense,
    required this.hp,
    required this.type,
  });

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    return Pokemon(
      id: json['id'],
      name: json['name'],
      imageUrl: json['sprites']['other']['official-artwork']['front_default'],
      attack: json['stats'][1]['base_stat'],
      defense: json['stats'][2]['base_stat'],
      hp: json['stats'][0]['base_stat'],
      type: json['types'][0]['type']['name'],
    );
  }
}
