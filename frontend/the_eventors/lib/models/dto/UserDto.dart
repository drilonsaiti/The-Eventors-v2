import 'dart:convert';

UserDto newsModelFromJson(String str) => UserDto.fromJson(json.decode(str));

String newsModelToJson(UserDto data) => json.encode(data.toJson());

class UserDto {
  String username;

  String password;

  UserDto({
    required this.username,
    required this.password,
  });

  //List<String> following;

  //List<String> followers;
  //List<Bookmakrs> bookmarks;

  factory UserDto.fromJson(Map<String, dynamic> json) => UserDto(
        username: json["username"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "password": password,
      };
}
