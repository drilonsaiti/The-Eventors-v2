import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';

ListingEventDto newsModelFromJson(String str) =>
    ListingEventDto.fromJson(json.decode(str));

String newsModelToJson(ListingEventDto data) => json.encode(data.toJson());

class ListingEventDto {
  int id;

  String title;

  String coverImage;

  String location;

  String startAt;

  String agoCreated;
  String createdBy;
  String profileImage;
  ListingEventDto(
      {required this.id,
      required this.title,
      required this.createdBy,
      required this.profileImage,
      required this.startAt,
      required this.coverImage,
      required this.location,
      required this.agoCreated});

  factory ListingEventDto.fromJson(Map<String, dynamic> json) =>
      ListingEventDto(
        title: json["title"],
        startAt: json["startAt"],
        location: json["location"],
        createdBy: json["createdBy"],
        agoCreated: json["agoCreated"],
        coverImage: json["coverImage"],
        profileImage: json["profileImage"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "createdBy": createdBy,
        "location": location,
        "startAt": startAt,
        "agoCreated": agoCreated,
        "coverImage": coverImage,
        "profileImage": profileImage,
        "id": "id"
      };
}
