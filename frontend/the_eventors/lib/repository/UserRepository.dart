import 'package:the_eventors/models/dto/RegisterDto.dart';
import 'package:the_eventors/models/dto/UserUsernameDto.dart';
import 'package:the_eventors/services/ApiService.dart';

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_eventors/models/dto/UserDto.dart';
import 'package:the_eventors/ui/login_screen.dart';

import '../models/User.dart';
import '../models/dto/UserDto.dart';

class UserRepository {
  final APIService _apiService = APIService();

  Future login(String? username, String? password) async {
    UserDto userDto = new UserDto(username: username!, password: password!);
    http.Response response = await _apiService.post("/login", userDto.toJson());

    /*SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('username', response.body);*/
  }

  Future register(RegisterDto registerDto) async {
    http.Response response =
        await _apiService.post("/register", registerDto.toJson());

    /*SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('username', response.body);*/
  }

  Future<List<UserUsernameDto>> findUsersByQuery(String query) async {
    http.Response response = await _apiService.get("/users");
    List<UserUsernameDto> users = [];
    List jsonResponse = json.decode(response.body);
    print(jsonResponse);
    if (query.isNotEmpty) {
      users = jsonResponse
          .map((job) => new UserUsernameDto.fromJson(job))
          .where((e) => e.username.contains(query))
          .toList();
    } else {
      users = [];
    }
    return users;
  }
}
