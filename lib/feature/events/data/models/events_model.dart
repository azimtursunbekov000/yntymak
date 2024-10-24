import 'package:intl/intl.dart';

class EventsModel {
  final int? count;
  final String? next;
  final String? previous;
  final List<Result>? results;

  EventsModel({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  factory EventsModel.fromJson(Map<String, dynamic> json) => EventsModel(
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        results: json["results"] != null
            ? List<Result>.from(json["results"].map((x) => Result.fromJson(x)))
            : [],
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "next": next,
        "previous": previous,
        "results": results != null
            ? List<dynamic>.from(results!.map((x) => x.toJson()))
            : [],
      };
}

class Result {
  final int? id;
  final String? title;
  final String? shortDescription;
  final String? description;
  final String? image;
  final String? author;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Result({
    this.id,
    this.title,
    this.shortDescription,
    this.description,
    this.image,
    this.author,
    this.createdAt,
    this.updatedAt,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        title: json["title"],
        shortDescription: json["short_description"],
        description: json["description"],
        image: json["image"],
        author: json["author"],
        createdAt: json["created_at"] != null
            ? DateFormat("dd/MM/yyyy HH:mm:ss").parse(json["created_at"])
            : null,
        updatedAt: json["updated_at"] != null
            ? DateFormat("dd/MM/yyyy HH:mm:ss").parse(json["updated_at"])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "short_description": shortDescription,
        "description": description,
        "image": image,
        "author": author,
        "created_at": createdAt != null
            ? DateFormat("dd/MM/yyyy HH:mm:ss").format(createdAt!)
            : null,
        "updated_at": updatedAt != null
            ? DateFormat("dd/MM/yyyy HH:mm:ss").format(updatedAt!)
            : null,
      };
}
