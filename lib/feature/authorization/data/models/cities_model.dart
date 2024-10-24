class CitiesModel {
  final int count;
  final dynamic next;
  final dynamic previous;
  final List<Result> results;

  CitiesModel({
    required this.count,
    required this.next,
    required this.previous,
    required this.results,
  });

  factory CitiesModel.fromJson(Map<String, dynamic> json) => CitiesModel(
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        results:
            List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "next": next,
        "previous": previous,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
      };
}

class Result {
  final int id;
  final String name;
  final Region region;

  Result({
    required this.id,
    required this.name,
    required this.region,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        name: json["name"],
        region: Region.fromJson(json["region"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "region": region.toJson(),
      };
}

class Region {
  final int id;
  final String name;

  Region({
    required this.id,
    required this.name,
  });

  factory Region.fromJson(Map<String, dynamic> json) => Region(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
