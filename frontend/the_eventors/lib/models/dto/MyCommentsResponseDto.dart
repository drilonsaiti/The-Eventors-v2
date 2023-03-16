import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';

MyCommentsResponseDto newsModelFromJson(String str) =>
    MyCommentsResponseDto.fromJson(json.decode(str));

String newsModelToJson(MyCommentsResponseDto data) =>
    json.encode(data.toJson());

class MyCommentsResponseDto {
  String message;
  String commentCreatedAt;
  String username;
  int idEvent;
  String createdBy;
  String title;
  String coverImage;
  String createdEvent;

  MyCommentsResponseDto({
    required this.message,
    required this.commentCreatedAt,
    required this.username,
    required this.idEvent,
    required this.createdBy,
    required this.title,
    required this.coverImage,
    required this.createdEvent,
  });

  factory MyCommentsResponseDto.fromJson(Map<String, dynamic> json) =>
      MyCommentsResponseDto(
        message: json["message"],
        commentCreatedAt: json["commentCreatedAt"],
        username: json["username"],
        idEvent: json["idEvent"],
        createdBy: json["createdBy"],
        title: json["title"],
        coverImage: json["coverImage"],
        createdEvent: json["createdEvent"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "commentCreatedAt": commentCreatedAt,
        "username": username,
        "idEvent": idEvent,
        "createdBy": createdBy,
        "title": title,
        "coverImage": coverImage,
        "createdEvent": createdEvent,
      };
}
