import 'dart:convert';

UserProfileDto newsModelFromJson(String str) =>
    UserProfileDto.fromJson(json.decode(str));

String newsModelToJson(UserProfileDto data) => json.encode(data.toJson());

class UserProfileDto {
  String username;

  String profileImage;
  String fullName;
  String bio;
  int countEvents;
  int countFollowers;
  int countFollowing;

  UserProfileDto({
    required this.username,
    required this.profileImage,
    required this.fullName,
    required this.bio,
    required this.countEvents,
    required this.countFollowers,
    required this.countFollowing,
  });

  factory UserProfileDto.fromJson(Map<String, dynamic> json) => UserProfileDto(
        username: json["username"],
        profileImage: json["profileImage"],
        fullName: json["fullName"],
        bio: json["bio"],
        countEvents: json["countEvents"],
        countFollowers: json["countFollowers"],
        countFollowing: json["countFollowing"],
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "profileImage": profileImage,
        "fullName": fullName,
        "bio": bio,
        "countEvents": countEvents,
        "countFollowers": countFollowers,
        "countFollowing": countFollowing,
      };
}
