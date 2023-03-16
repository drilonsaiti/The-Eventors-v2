import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';

ListingEventNearDto newsModelFromJson(String str) =>
    ListingEventNearDto.fromJson(json.decode(str));

String newsModelToJson(ListingEventNearDto data) => json.encode(data.toJson());

class ListingEventNearDto {
  int id;

  String title;

  String coverImage;

  String location;
  double lat;
  double lng;
  double distance;

  String startDateTime;

  String agoCreated;
  String createdBy;
  String profileImage;

  int categoryId;
  ListingEventNearDto(
      {required this.id,
      required this.title,
      required this.createdBy,
      required this.profileImage,
      required this.startDateTime,
      required this.coverImage,
      required this.location,
      required this.distance,
      required this.lat,
      required this.lng,
      required this.categoryId,
      required this.agoCreated});

  factory ListingEventNearDto.fromJson(Map<String, dynamic> json) =>
      ListingEventNearDto(
        title: json["title"],
        startDateTime: json["startDateTime"],
        location: json["location"],
        distance: json["distance"],
        lat: json["lat"],
        lng: json["lng"],
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
        "distance": distance,
        "lat": lat,
        "lng": lng,
        "categoryId": categoryId,
        "startDateTime": startDateTime,
        "agoCreated": agoCreated,
        "coverImage": coverImage,
        "profileImage": profileImage,
        "id": "id"
      };
}
