import 'dart:convert';

Events newsModelFromJson(String str) => Events.fromJson(json.decode(str));

String newsModelToJson(Events data) => json.encode(data.toJson());

class Events {
  String title;
  String description;
  String location;

  //MultipartFile coverImage;
  //MultipartFile [] images;
  String guest;
  String startDateTime;
  String duration;
  String category;

  Events({
    required this.title,
    required this.description,
    required this.location,
    required this.guest,
    required this.startDateTime,
    required this.duration,
    required this.category,
  });

  //List<String> following;

  //List<String> followers;
  //List<Bookmakrs> bookmarks;

  factory Events.fromJson(Map<String, dynamic> json) => Events(
        title: json["title"],
        description: json["description"],
        location: json["location"],
        guest: json["guest"],
        startDateTime: json["startDateTime"],
        duration: json["duration"],
        category: json["category"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "description": description,
        "location": location,
        "guest": guest,
        "startDateTime": startDateTime,
        "duration": duration,
        "category": category,
      };
}
