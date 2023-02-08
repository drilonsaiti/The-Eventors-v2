import 'dart:io';

import 'package:http/http.dart';
import 'package:the_eventors/models/dto/RegisterDto.dart';
import 'package:the_eventors/services/ApiService.dart';

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_eventors/models/dto/UserDto.dart';
import 'package:the_eventors/ui/login_screen.dart';
import 'package:async/async.dart';
import '../models/Category.dart';
import '../models/Events.dart';
import '../models/User.dart';
import '../models/dto/UserDto.dart';

class EventRepository {
  final APIService _apiService = APIService();

  Future<List<Events>> getEvents() async {
    http.Response response = await _apiService.get("/events");
    List<Events> events = [];
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((job) => new Events.fromJson(job)).toList();
  }

  Future<List<Events>> findEventsByQuery(String query) async {
    http.Response response = await _apiService.get("/events");
    List<Events> events = [];
    List jsonResponse = json.decode(response.body);
    print("IN EN" + query);
    if (query.isNotEmpty) {
      events = jsonResponse
          .map((job) => new Events.fromJson(job))
          .where((e) => e.title.contains(query))
          .toList();
    } else {
      events = [];
    }
    return events;
  }

  Future<void> addEvent(
    String title,
    String description,
    String location,
    File coverImage,
    List<File> images,
    String guest,
    String startDateTime,
    String duration,
    String category,
  ) async {
    print(category);
    var request = http.MultipartRequest(
        'POST', Uri.parse("http://192.168.1.65:8080/api/events"));

    print("START TIME: " + startDateTime);
    print("GUEST: " + guest);
    request.fields['title'] = title;
    request.fields['description'] = description;
    request.fields['location'] = location;
    request.fields['guests'] = guest;
    request.fields['startTime'] = startDateTime;
    request.fields['duration'] = duration;
    request.fields['category'] = category;
    var streamCover =
        new http.ByteStream(DelegatingStream.typed(coverImage.openRead()));

    var imageCover = new http.MultipartFile(
        "coverImage", streamCover, await coverImage.length(),
        filename: coverImage.path);

    List<MultipartFile>? _images = [];
    for (int i = 0; i < images.length; i++) {
      var streamImages =
          new http.ByteStream(DelegatingStream.typed(images[i].openRead()));
      _images.add(new http.MultipartFile(
          "images", streamImages, await images[i].length(),
          filename: images[i].path));
    }
    request.files.add(imageCover);
    request.files.addAll(_images);

    await request.send().then((response) async {
      // listen for response
      response.stream.transform(utf8.decoder).listen((value) {
        print(value);
      });
    }).catchError((e) {
      print(e);
    });
  }
}
