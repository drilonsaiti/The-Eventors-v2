import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';

ListingTopEventDto newsModelFromJson(String str) =>
    ListingTopEventDto.fromJson(json.decode(str));

String newsModelToJson(ListingTopEventDto data) => json.encode(data.toJson());

class ListingTopEventDto {
  int id;

  String title;

  String coverImage;

  String location;
  int going;
  int interested;

  String startDateTime;

  String agoCreated;
  String createdBy;
  String profileImage;

  int categoryId;
  ListingTopEventDto(
      {required this.id,
      required this.title,
      required this.createdBy,
      required this.startDateTime,
      required this.coverImage,
      required this.profileImage,
      required this.location,
      required this.going,
      required this.interested,
      required this.categoryId,
      required this.agoCreated});

  factory ListingTopEventDto.fromJson(Map<String, dynamic> json) =>
      ListingTopEventDto(
        title: json["title"],
        startDateTime: json["startDateTime"],
        location: json["location"],
        going: json["going"],
        interested: json["interested"],
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
        "going": going,
        "interested": interested,
        "categoryId": categoryId,
        "startDateTime": startDateTime,
        "agoCreated": agoCreated,
        "coverImage": coverImage,
        "profileImage": profileImage,
        "id": "id"
      };
}
