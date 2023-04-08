import 'package:the_eventors/models/dto/RegisterDto.dart';
import 'package:the_eventors/services/ApiService.dart';

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_eventors/models/dto/UserDto.dart';
import 'package:the_eventors/ui/login_screen.dart';

import '../models/Category.dart';
import '../models/User.dart';
import '../models/dto/UserDto.dart';

class CategoryRepository {
  final APIService _apiService = APIService();

  Future<List<Category>> getCategories() async {
    http.Response response = await _apiService.get("/categories");
    List<Category> categories = [];
    if (response.statusCode == 200) {
      for (var c in json.decode(response.body)) {
        categories.add(Category.fromJson(c));
      }
    }

    return categories;
  }
}
