import 'dart:convert';

Notifications newsModelFromJson(String str) =>
    Notifications.fromJson(json.decode(str));

String newsModelToJson(Notifications data) => json.encode(data.toJson());

class Notifications {
  int id;
  String fromUser;
  String title;
  String message;
  String createAt;
  bool read;
  String types;

  int idEvent;
  int idComment;

  Notifications({
    required this.id,
    required this.fromUser,
    required this.title,
    required this.message,
    required this.createAt,
    required this.read,
    required this.types,
    required this.idEvent,
    required this.idComment,
  });

  //List<String> following;

  //List<String> followers;
  //List<Bookmakrs> bookmarks;

  factory Notifications.fromJson(Map<String, dynamic> json) => Notifications(
        id: json["id"],
        fromUser: json["fromUser"],
        title: json["title"],
        message: json["message"],
        createAt: json["createAt"],
        read: json["read"],
        types: json["types"],
        idEvent: json["idEvent"],
        idComment: json["idComment"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "fromUser": fromUser,
        "title": title,
        "message": message,
        "fromUser": fromUser,
        "read": read,
        "types": types,
        "idEvent": idEvent,
        "idComment": idComment,
      };
}
