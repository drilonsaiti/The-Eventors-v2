import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';

ListingAllEventDto newsModelFromJson(String str) =>
    ListingAllEventDto.fromJson(json.decode(str));

String newsModelToJson(ListingAllEventDto data) => json.encode(data.toJson());

class ListingAllEventDto {
  int id;

  String title;

  String coverImage;

  String location;

  String startDateTime;

  String agoCreated;
  String createdBy;
  String profileImage;

  int categoryId;
  ListingAllEventDto(
      {required this.id,
      required this.title,
      required this.createdBy,
      required this.startDateTime,
      required this.coverImage,
      required this.profileImage,
      required this.location,
      required this.categoryId,
      required this.agoCreated});

  factory ListingAllEventDto.fromJson(Map<String, dynamic> json) =>
      ListingAllEventDto(
        title: json["title"],
        startDateTime: json["startDateTime"],
        location: json["location"],
        createdBy: json["createdBy"],
        agoCreated: json["agoCreated"],
        coverImage: json["coverImage"],
        profileImage: json["profileImage"],
        id: json["id"],
        categoryId: json["categoryId"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "createdBy": createdBy,
        "location": location,
        "categoryId": categoryId,
        "startDateTime": startDateTime,
        "agoCreated": agoCreated,
        "coverImage": coverImage,
        "profileImage": profileImage,
        "id": "id"
      };
}
