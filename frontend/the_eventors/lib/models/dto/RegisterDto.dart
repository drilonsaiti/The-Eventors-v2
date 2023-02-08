import 'dart:convert';

RegisterDto newsModelFromJson(String str) =>
    RegisterDto.fromJson(json.decode(str));

String newsModelToJson(RegisterDto data) => json.encode(data.toJson());

class RegisterDto {
  String username;

  String password;

  String repeatPassword;

  String name;

  String surname;

  String role;

  RegisterDto({
    required this.username,
    required this.password,
    required this.repeatPassword,
    required this.name,
    required this.surname,
    required this.role,
  });

  //List<String> following;

  //List<String> followers;
  //List<Bookmakrs> bookmarks;

  factory RegisterDto.fromJson(Map<String, dynamic> json) => RegisterDto(
        username: json["username"],
        password: json["password"],
        repeatPassword: json["repeatPassword"],
        name: json["name"],
        surname: json["surname"],
        role: json["role"],
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "password": password,
        "repeatPassword": repeatPassword,
        "name": name,
        "surname": surname,
        "role": role,
      };
}
