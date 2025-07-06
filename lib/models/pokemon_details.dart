class PokemonDetails {
  final int id;
  final String name;
  final String sprite;
  final List<Stat> stats;
  final List<Type> types;

  PokemonDetails({
    required this.id,
    required this.name,
    required this.sprite,
    required this.stats,
    required this.types,
  });

  factory PokemonDetails.fromJson(Map<String, dynamic> json) => PokemonDetails(
        id: json["id"],
        name: json["name"],
        sprite: json["sprites"]['other']['home']['front_default'],
        stats: List<Stat>.from(
          json["stats"].map(
            (x) => Stat.fromJson(x),
          ),
        ),
        types: List<Type>.from(
          json["types"].map(
            (x) => Type.fromJson(x),
          ),
        ),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "sprites": {
          "other": {
            "home": {
              "front_default": sprite,
            }
          }
        },
        "stats": stats.map((x) => x.toJson()).toList(),
        "types": types.map((x) => x.toJson()).toList(),
      };
}

class Stat {
  final int baseStat;
  final String statName;

  Stat({
    required this.baseStat,
    required this.statName,
  });

  factory Stat.fromJson(Map<String, dynamic> json) => Stat(
        baseStat: json["base_stat"],
        statName: json["stat"]['name'],
      );

  Map<String, dynamic> toJson() => {
        "base_stat": baseStat,
        "stat": {
          "name": statName,
        },
      };
}

class Type {
  final int slot;
  final String typeName;

  Type({
    required this.slot,
    required this.typeName,
  });

  factory Type.fromJson(Map<String, dynamic> json) => Type(
        slot: json["slot"],
        typeName: json["type"]["name"],
      );

  Map<String, dynamic> toJson() => {
        "slot": slot,
        "type": {
          "name": typeName,
        },
      };
}
