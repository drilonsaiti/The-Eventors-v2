import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:the_eventors/models/dto/AuthenticationResponse.dart';
import 'package:the_eventors/models/dto/RegisterDto.dart';
import 'package:the_eventors/models/dto/UserUsernameDto.dart';
import 'package:the_eventors/services/ApiService.dart';

import 'dart:convert';
import 'package:async/async.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_eventors/models/dto/UserDto.dart';
import 'package:the_eventors/ui/login_screen.dart';

import '../db/RefreshTokenDB.dart';
import '../models/RefreshToken.dart';
import '../models/User.dart';
import '../models/dto/NotificationInfoDto.dart';
import '../models/dto/UserDto.dart';
import '../models/dto/UserProfileDto.dart';

class UserRepository {
  final APIService _apiService = APIService();
  static FirebaseMessaging fMessaging = FirebaseMessaging.instance;
  Future login(String? username, String? password) async {
    UserDto userDto = new UserDto(username: username!, password: password!);
    http.Response response =
        await _apiService.post("/auth/login", userDto.toJson());

    if (response.statusCode != 200) {
      return response.body;
    }
    AuthenticationResponse auth =
        AuthenticationResponse.fromJson(jsonDecode(response.body));
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('token', auth.token);
    print(pref.get('token'));
    Map<String, dynamic> jsonMap = {
      'token': auth.token,
    };
    http.Response response2 =
        await _apiService.post("/auth/extract-username", jsonMap);
    pref.setString('username', response2.body);
    await fMessaging.requestPermission();
    String notificationToken = "";
    await fMessaging.getToken().then((value) => {
          if (value != null) {notificationToken = value}
        });
    Map<String, dynamic> jsonMap2 = {
      'notificationToken': notificationToken,
      'username': response2.body
    };
    await _apiService.post("/auth/notification-token", jsonMap2);

    final refreshToken =
        RefreshToken(username: response2.body, refreshToken: auth.refreshToken);
    await RefreshTokenDB.instance.create(refreshToken);
  }

  Future register(RegisterDto registerDto) async {
    http.Response response =
        await _apiService.post("/auth/register", registerDto.toJson());

    if (response.statusCode != 200) {
      return response.body;
    }
    await fMessaging.requestPermission();
    String notificationToken = "";
    await fMessaging.getToken().then((value) => {
          if (value != null) {notificationToken = value}
        });
    Map<String, dynamic> jsonMap = {
      'notificationToken': notificationToken,
      'username': registerDto.username
    };
    http.Response response2 =
        await _apiService.post("/auth/notification-token", jsonMap);
    AuthenticationResponse auth =
        AuthenticationResponse.fromJson(jsonDecode(response.body));
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('token', auth.token);
    final refreshToken = RefreshToken(
        username: registerDto.username, refreshToken: auth.refreshToken);
    await RefreshTokenDB.instance.create(refreshToken);
  }

  Future<String> getUsername() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString('token');
    Map<String, dynamic> jsonMap = {
      'token': token,
    };
    http.Response response =
        await _apiService.post("/auth/extract-username", jsonMap);
    print("RESPONSE BODY");
    print(response.body);
    return response.body;
  }

  Future<String> getEmail() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString('token');
    Map<String, dynamic> jsonMap = {
      'token': token,
    };
    http.Response response =
        await _apiService.post("/auth/extract-email", jsonMap);
    return response.body;
  }

  Future<List<UserUsernameDto>> getDiscoverUsers() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString('token');
    http.Response response =
        await _apiService.get("/users/discover?token=${token}");
    List jsonResponse = json.decode(response.body);

    return jsonResponse.map((u) => UserUsernameDto.fromJson(u)).toList();
  }

  Future<int> countFollwoing() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString('token');
    http.Response response =
        await _apiService.get("/users/count-following?token=${token}");
    int jsonResponse = json.decode(response.body);

    return jsonResponse;
  }

  Future<List<UserUsernameDto>> findUsersByQuery(String query) async {
    http.Response response = await _apiService.get("/users");
    List<UserUsernameDto> users = [];
    List jsonResponse = json.decode(response.body);

    if (response.statusCode == 200) {
      if (query.isNotEmpty) {
        users = jsonResponse
            .map((u) => new UserUsernameDto.fromJson(u))
            .where((e) => e.username.contains(query))
            .toList();
      } else {
        users = [];
      }
      return users;
    } else {
      throw Exception(response.body);
    }
  }

  Future<UserUsernameDto> findUserByQuery() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString('token');
    http.Response response =
        await _apiService.get("/users/find?token=${token}");
    print("FINDDDDDDDDDDDDDDDDDD");
    print(response.body);
    return UserUsernameDto.fromJson(jsonDecode(response.body));
  }

  void doFollow(String userToFollow) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString('token');
    http.Response response =
        await _apiService.get("/profile/${userToFollow}?token=${token}");
  }

  Future<void> addBookmark(int id) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString('token');
    Map<String, dynamic> jsonMap = {
      'token': token,
    };
    http.Response response =
        await _apiService.post("/bookmark/add-event/$id", jsonMap);
  }

  Future<String> checkBookmark(int id) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString('token');
    Map<String, dynamic> jsonMap = {
      'token': token,
    };
    http.Response response =
        await _apiService.post("/bookmark/check/$id", jsonMap);

    return response.body;
  }

  void removeBookmark(id) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString('token');
    Map<String, dynamic> jsonMap = {
      'token': token,
    };
    http.Response response =
        await _apiService.delete("/bookmark/$id/delete", jsonMap);
  }

  Future<UserProfileDto> getProfile(String username) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = username != "" ? username : pref.getString('username');
    http.Response response = await _apiService.get("/profile?username=$token");

    return UserProfileDto.fromJson(jsonDecode(response.body));
  }

  Future<bool> checkIsFollowing(String username) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString('username');
    Map<String, dynamic> jsonMap = {'token': token, 'username': username};

    http.Response response =
        await _apiService.post("/profile/isFollowing", jsonMap);

    return response.body.startsWith("t");
  }

  Future changePassword(
      String oldPass, String newPass, String rPass, String username) async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    Map<String, dynamic> jsonMap = {
      'token': pref.getString('token'),
      'oldPassword': oldPass,
      'newPassword': newPass,
      'repeatedPassword': rPass
    };
    http.Response response =
        await _apiService.post("/auth/change-password", jsonMap);

    if (response.statusCode != 200) {
      return response.body;
    }
    login(username, newPass);
  }

  Future changeEmail(String email, String password, String verifyCode) async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    Map<String, dynamic> jsonMap = {
      'token': pref.getString('token'),
      'newEmail': email,
      'password': password,
      'verifyCode': verifyCode
    };
    http.Response response =
        await _apiService.post("/auth/change-email", jsonMap);
    print(response.body);
    if (response.statusCode != 200) {
      return response.body;
    }
  }

  Future changeUsername(String pass, String newUsername) async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    Map<String, dynamic> jsonMap = {
      'token': pref.getString('token'),
      'password': pass,
      'newUsername': newUsername,
    };
    http.Response response =
        await _apiService.post("/auth/change-username", jsonMap);

    if (response.statusCode != 200) {
      return response.body;
    }
    login(newUsername, pass);
  }

  void logout() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.clear();
    RefreshTokenDB.instance.deleteTable();
  }

  follow(String username) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString('token');
    NotificationInfoDto dto = NotificationInfoDto(
        to: username, from: token!, title: username, message: "");
    http.Response response =
        await _apiService.post("/profile/follow", dto.toJson());

    if (response.statusCode != 200) {
      return response.body;
    }
  }

  unfollow(String username) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    Map<String, dynamic> jsonMap = {
      'token': pref.getString('token'),
      'username': username,
    };
    http.Response response =
        await _apiService.post("/profile/unfollow", jsonMap);

    if (response.statusCode != 200) {
      return response.body;
    }
  }

  Future<File> _createFileFromString(String s) async {
    Uint8List bytes = base64.decode(s);
    String dir = (await getApplicationDocumentsDirectory()).path;
    File file = File(
        "$dir/" + DateTime.now().millisecondsSinceEpoch.toString() + ".png");
    await file.writeAsBytes(bytes);
    return file;
  }

  void addProfileImage(String base64encode) async {
    var request = http.MultipartRequest(
        'POST', Uri.parse(_apiService.baseUrl + "/users/add/profile-image"));

    SharedPreferences pref = await SharedPreferences.getInstance();
    request.fields['token'] = pref.getString('token')!;

    File f = await _createFileFromString(base64encode);
    var streamCover = http.ByteStream(DelegatingStream.typed(f.openRead()));
    var imageCover = http.MultipartFile(
        "profileImage", streamCover, await f.length(),
        filename: f.path);
    request.files.add(imageCover);

    await request.send().then((response) async {
      // listen for response
      response.stream.transform(utf8.decoder).listen((value) {});
    }).catchError((e) {});
  }

  void removeProfileImage() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    Map<String, dynamic> jsonMap = {
      'token': pref.getString('token'),
    };
    http.Response response =
        await _apiService.post("/users/remove/profile-image", jsonMap);
  }

  sendVerification(String? email) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    print(pref.getString('token'));
    Map<String, dynamic> jsonMap = {
      'token': pref.getString('token'),
      'email': email!.isEmpty ? null : email,
    };
    http.Response response =
        await _apiService.post("/users/verification-code", jsonMap);

    if (response.statusCode != 200) {
      return response.body;
    }
  }

  forgotPassword(String email, String password, String repeatPassword,
      String verifyCode) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    print(email);
    Map<String, dynamic> jsonMap = {
      'token': pref.getString('token'),
      'email': email,
      "newPassword": password,
      "repeatedPassword": repeatPassword,
      "verifyCode": verifyCode
    };
    http.Response response =
        await _apiService.post("/auth/forgot-password", jsonMap);
    print(response.body);
    if (response.statusCode != 200) {
      return response.body;
    }
  }

  void updateProfile(String fullName, String bio) async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    Map<String, dynamic> jsonMap = {
      'token': pref.getString('token'),
      'fullName': fullName,
      "bio": bio,
    };
    http.Response response = await _apiService.post("/profile/edit", jsonMap);
    print(response.body);
  }

  void deleteAccount() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    Map<String, dynamic> jsonMap = {
      'token': pref.getString('token'),
    };
    http.Response response =
        await _apiService.post("/users/delete-account", jsonMap);
    print(response.body);
  }

  Future<List<String>> myFollowing() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    Map<String, dynamic> jsonMap = {
      'token': pref.getString('token'),
    };
    http.Response response =
        await _apiService.post("/users/my-following", jsonMap);
    List<String> list = [];
    List jsonResponse = json.decode(response.body);
    jsonResponse.map((e) => list.add(e));
    return list;
  }

  Future<List<String>> myFollowers() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    Map<String, dynamic> jsonMap = {
      'token': pref.getString('token'),
    };
    http.Response response =
        await _apiService.post("/users/my-followers", jsonMap);
    List<String> list = [];
    List jsonResponse = json.decode(response.body);
    jsonResponse.map((e) => list.add(e));
    return list;
  }

  Future<List<UserUsernameDto>> getAllMyFollowing() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString('token');
    http.Response response =
        await _apiService.get("/profile/my-following?token=${token}");
    List jsonResponse = json.decode(response.body);

    return jsonResponse.map((u) => UserUsernameDto.fromJson(u)).toList();
  }

  Future<List<UserUsernameDto>> getAllMyFollowers() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString('token');
    http.Response response =
        await _apiService.get("/profile/my-followers?token=${token}");
    List jsonResponse = json.decode(response.body);

    return jsonResponse.map((u) => UserUsernameDto.fromJson(u)).toList();
  }
}
