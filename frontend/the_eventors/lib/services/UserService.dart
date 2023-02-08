import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_eventors/models/dto/UserDto.dart';
import 'package:the_eventors/ui/login_screen.dart';

import '../models/User.dart';

class UserService {
  Map<String, String> headers = {
    "content-type": "application/json",
    "accept": "application/json",
  };

  Future login(String? username, String? password) async {
    UserDto userDto = new UserDto(username: username!, password: password!);
    //String workingStringInPostman = "http://192.168.1.12:8080/login?username=${username}&password=${password}";
    //var response = await http.post(Uri.parse(workingStringInPostman));

    Uri uri = Uri.parse("http://192.168.1.12:8080/login");
    String bodyString = json.encode(userDto.toJson());

    http.Response response =
        await http.post(uri, headers: headers, body: bodyString);
    /*SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('username', response.body);*/
  }
}
