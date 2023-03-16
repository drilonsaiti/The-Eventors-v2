import 'dart:convert';

EventForSearchDto newsModelFromJson(String str) =>
    EventForSearchDto.fromJson(json.decode(str));

String newsModelToJson(EventForSearchDto data) => json.encode(data.toJson());

class EventForSearchDto {
  int id;

  String title;

  EventForSearchDto({
    required this.id,
    required this.title,
  });

  factory EventForSearchDto.fromJson(Map<String, dynamic> json) =>
      EventForSearchDto(
        id: json["id"],
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
      };
}
