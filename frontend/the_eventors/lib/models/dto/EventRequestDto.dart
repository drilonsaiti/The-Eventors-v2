import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';

EventsRequestDto newsModelFromJson(String str) =>
    EventsRequestDto.fromJson(json.decode(str));

String newsModelToJson(EventsRequestDto data) => json.encode(data.toJson());

class EventsRequestDto {
  String title;
  String description;
  String location;

  File coverImage;
  List<File> images;
  String guest;
  String startDateTime;
  String duration;
  String category;

  EventsRequestDto({
    required this.title,
    required this.description,
    required this.location,
    required this.coverImage,
    required this.images,
    required this.guest,
    required this.startDateTime,
    required this.duration,
    required this.category,
  });

  //List<String> following;

  //List<String> followers;
  //List<Bookmakrs> bookmarks;

  factory EventsRequestDto.fromJson(Map<String, dynamic> json) =>
      EventsRequestDto(
        title: json["title"],
        description: json["description"],
        location: json["location"],
        coverImage: json["coverImage"],
        images: json["images"],
        guest: json["guest"],
        startDateTime: json["startDateTime"],
        duration: json["duration"],
        category: json["category"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "description": description,
        "location": location,
        "coverImage": coverImage,
        "images": images,
        "guest": guest,
        "startDateTime": startDateTime,
        "duration": duration,
        "category": category,
      };
}
