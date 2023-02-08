import 'dart:convert';

UserUsernameDto newsModelFromJson(String str) =>
    UserUsernameDto.fromJson(json.decode(str));

String newsModelToJson(UserUsernameDto data) => json.encode(data.toJson());

class UserUsernameDto {
  String username;

  UserUsernameDto({
    required this.username,
  });

  //List<String> following;

  //List<String> followers;
  //List<Bookmakrs> bookmarks;

  factory UserUsernameDto.fromJson(Map<String, dynamic> json) =>
      UserUsernameDto(
        username: json["username"],
      );

  Map<String, dynamic> toJson() => {
        "username": username,
      };
}
