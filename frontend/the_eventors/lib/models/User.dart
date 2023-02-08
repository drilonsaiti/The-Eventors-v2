import 'dart:convert';

User newsModelFromJson(String str) => User.fromJson(json.decode(str));

String newsModelToJson(User data) => json.encode(data.toJson());

class User {
  String username;

  String password;

  String name;

  String surname;

  User({
    required this.username,
    required this.password,
    required this.name,
    required this.surname,
  });

  //List<String> following;

  //List<String> followers;
  //List<Bookmakrs> bookmarks;

  factory User.fromJson(Map<String, dynamic> json) => User(
        username: json["username"],
        password: json["password"],
        name: json["name"],
        surname: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "password": password,
        "name": name,
        "surname": surname,
      };
}
