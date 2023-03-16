import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';

MyEventResponseDto newsModelFromJson(String str) =>
    MyEventResponseDto.fromJson(json.decode(str));

String newsModelToJson(MyEventResponseDto data) => json.encode(data.toJson());

class MyEventResponseDto {
  String title;
  String createdBy;
  String timeAt;
  String coverImage;
  String startDateTime;

  String status;
  int id;

  MyEventResponseDto(
      {required this.title,
      required this.createdBy,
      required this.timeAt,
      required this.coverImage,
      required this.startDateTime,
      required this.status,
      required this.id});

  factory MyEventResponseDto.fromJson(Map<String, dynamic> json) =>
      MyEventResponseDto(
        title: json["title"],
        createdBy: json["createdBy"],
        timeAt: json["timeAt"],
        coverImage: json["coverImage"],
        startDateTime: json["startDateTime"],
        status: json["status"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "createdBy": createdBy,
        "timeAt": timeAt,
        "startDateTime": startDateTime,
        "coverImage": coverImage,
        "status": status,
        "id": "id"
      };
}
