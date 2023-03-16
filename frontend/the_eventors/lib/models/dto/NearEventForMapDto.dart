import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';

NearEventForMapDto newsModelFromJson(String str) =>
    NearEventForMapDto.fromJson(json.decode(str));

String newsModelToJson(NearEventForMapDto data) => json.encode(data.toJson());

class NearEventForMapDto {
  int id;

  String title;

  String location;
  double distance;

  String startDateTime;

  NearEventForMapDto({
    required this.id,
    required this.title,
    required this.startDateTime,
    required this.location,
    required this.distance,
  });

  factory NearEventForMapDto.fromJson(Map<String, dynamic> json) =>
      NearEventForMapDto(
        title: json["title"],
        startDateTime: json["startDateTime"],
        location: json["location"],
        distance: json["distance"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "location": location,
        "distance": distance,
        "startDateTime": startDateTime,
        "id": "id"
      };
}
