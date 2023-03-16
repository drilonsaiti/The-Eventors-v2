import 'dart:convert';

Events newsModelFromJson(String str) => Events.fromJson(json.decode(str));

String newsModelToJson(Events data) => json.encode(data.toJson());

class Events {
  int id;
  String title;
  String description;
  String location;
  String createdBy;
  String coverImage;
  List<String> images;
  List<String> going;
  List<String> interested;

  List<String> guest;
  String startDateTime;
  String endDateTime;

  String duration;
  String category;
  int categoryId;

  Events({
    this.id = 0,
    this.title = "",
    this.description = "",
    this.location = "",
    this.createdBy = "",
    this.coverImage = "",
    required this.images,
    required this.going,
    required this.interested,
    required this.guest,
    this.startDateTime = "",
    this.endDateTime = "",
    this.duration = "",
    this.category = "",
    this.categoryId = 0,
  });

  factory Events.fromJson(Map<String, dynamic> json) => Events(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        location: json["location"],
        createdBy: json["createdBy"],
        coverImage: json["coverImage"],
        images: json["images"].cast<String>(),
        going: json["going"].cast<String>(),
        interested: json["interested"].cast<String>(),
        guest: json["guest"].cast<String>(),
        startDateTime: json["startDateTime"],
        endDateTime: json["endDateTime"],
        duration: json["duration"],
        category: json["category"],
        categoryId: json["categoryId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "location": location,
        "createdBy": createdBy,
        "coverImage": coverImage,
        "images": images,
        "going": going,
        "interested": interested,
        "guest": guest,
        "startDateTime": startDateTime,
        "endDateTime": endDateTime,
        "duration": duration,
        "category": category,
        "categoryId": categoryId,
      };
}
