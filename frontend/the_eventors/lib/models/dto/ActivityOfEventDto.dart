import 'dart:convert';

ActivityOfEventDto newsModelFromJson(String str) =>
    ActivityOfEventDto.fromJson(json.decode(str));

String newsModelToJson(ActivityOfEventDto data) => json.encode(data.toJson());

class ActivityOfEventDto {
  int going;
  int interested;
  int followers;
  int users;
  int anonymous;

  ActivityOfEventDto({
    this.going = 0,
    this.interested = 0,
    this.followers = 0,
    this.users = 0,
    this.anonymous = 0,
  });

  factory ActivityOfEventDto.fromJson(Map<String, dynamic> json) =>
      ActivityOfEventDto(
        going: json["going"],
        interested: json["interested"],
        followers: json["followers"],
        users: json["users"],
        anonymous: json["anonymous"],
      );

  Map<String, dynamic> toJson() => {
        "going": going,
        "interested": interested,
        "followers": followers,
        "users": users,
        "anonymous": anonymous,
      };
}
