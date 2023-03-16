import 'dart:convert';

AuthenticationResponse newsModelFromJson(String str) =>
    AuthenticationResponse.fromJson(json.decode(str));

String newsModelToJson(AuthenticationResponse data) =>
    json.encode(data.toJson());

class AuthenticationResponse {
  String token;

  String refreshToken;

  AuthenticationResponse({
    required this.token,
    required this.refreshToken,
  });

  //List<String> following;

  //List<String> followers;
  //List<Bookmakrs> bookmarks;

  factory AuthenticationResponse.fromJson(Map<String, dynamic> json) =>
      AuthenticationResponse(
        token: json["token"],
        refreshToken: json["refreshToken"],
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "refreshToken": refreshToken,
      };
}
