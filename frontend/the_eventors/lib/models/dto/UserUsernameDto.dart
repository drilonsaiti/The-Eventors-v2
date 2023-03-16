import 'dart:convert';

UserUsernameDto newsModelFromJson(String str) =>
    UserUsernameDto.fromJson(json.decode(str));

String newsModelToJson(UserUsernameDto data) => json.encode(data.toJson());

class UserUsernameDto {
  String username;
  String profileImage;

  UserUsernameDto({
    required this.username,
    required this.profileImage,
  });

  //List<String> following;

  //List<String> followers;
  //List<Bookmakrs> bookmarks;

  factory UserUsernameDto.fromJson(Map<String, dynamic> json) =>
      UserUsernameDto(
        username: json["username"],
        profileImage: json["profileImage"],
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "profileImage": profileImage,
      };
}
