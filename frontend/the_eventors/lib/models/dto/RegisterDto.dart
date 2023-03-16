import 'dart:convert';

RegisterDto newsModelFromJson(String str) =>
    RegisterDto.fromJson(json.decode(str));

String newsModelToJson(RegisterDto data) => json.encode(data.toJson());

class RegisterDto {
  String username;

  String password;

  String repeatPassword;

  String email;

  RegisterDto({
    required this.username,
    required this.password,
    required this.repeatPassword,
    required this.email,
  });

  //List<String> following;

  //List<String> followers;
  //List<Bookmakrs> bookmarks;

  factory RegisterDto.fromJson(Map<String, dynamic> json) => RegisterDto(
        username: json["username"],
        password: json["password"],
        repeatPassword: json["repeatPassword"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "password": password,
        "repeatPassword": repeatPassword,
        "email": email,
      };
}
