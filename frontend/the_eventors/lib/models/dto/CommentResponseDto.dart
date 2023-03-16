import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';

CommentResponseDto newsModelFromJson(String str) =>
    CommentResponseDto.fromJson(json.decode(str));

String newsModelToJson(CommentResponseDto data) => json.encode(data.toJson());

class CommentResponseDto {
  int id;
  String message;
  String createdAt;
  String username;
  String profileImage;
  int idEvent;

  List<CommentResponseDto> replies;

  CommentResponseDto({
    required this.id,
    required this.message,
    required this.createdAt,
    required this.username,
    required this.profileImage,
    required this.idEvent,
    required this.replies,
  });

  factory CommentResponseDto.fromJson(Map<String, dynamic> json) =>
      CommentResponseDto(
          id: json["id"],
          message: json["message"],
          createdAt: json["createdAt"],
          username: json["username"],
          profileImage: json["profileImage"],
          idEvent: json["idEvent"],
          replies: json["replies"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "message": message,
        "createdAt": createdAt,
        "username": username,
        "profileImage": profileImage,
        "idEvent": idEvent,
        "replies": replies,
      };
}
