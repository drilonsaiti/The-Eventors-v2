import 'dart:convert';

NotificationInfoDto newsModelFromJson(String str) =>
    NotificationInfoDto.fromJson(json.decode(str));

String newsModelToJson(NotificationInfoDto data) => json.encode(data.toJson());

class NotificationInfoDto {
  String to;
  String from;
  String title;
  String message;

  NotificationInfoDto({
    required this.to,
    required this.from,
    required this.title,
    required this.message,
  });

  factory NotificationInfoDto.fromJson(Map<String, dynamic> json) =>
      NotificationInfoDto(
        to: json["to"],
        from: json["from"],
        title: json["title"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "to": to,
        "from": from,
        "title": title,
        "message": message,
      };
}
