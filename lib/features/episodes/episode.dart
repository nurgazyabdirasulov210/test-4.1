class Episode {
  Episode({
    required this.id,
    required this.name,
    required this.airDate,
    required this.code,
  });

  factory Episode.fromJson(Map<String, dynamic> json) => Episode(
        id: json['id'] as int,
        name: json['name'] as String,
        airDate: json['air_date'] as String,
        code: json['episode'] as String,
      );

  final int id;
  final String name;
  final String airDate;
  final String code;
}
