import 'dart:convert';

Category newsModelFromJson(String str) => Category.fromJson(json.decode(str));

String newsModelToJson(Category data) => json.encode(data.toJson());

class Category {
  int id;
  String imageUrl;
  String name;
  String description;

  Category({
    required this.id,
    required this.imageUrl,
    required this.name,
    required this.description,
  });

  //List<String> following;

  //List<String> followers;
  //List<Bookmakrs> bookmarks;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        imageUrl: json["imageUrl"],
        name: json["name"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "imageUrl": imageUrl,
        "name": name,
        "description": description,
      };
}
