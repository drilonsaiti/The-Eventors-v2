import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:http/http.dart';
import 'package:path_provider/path_provider.dart';
import 'package:the_eventors/models/dto/CommentResponseDto.dart';
import 'package:the_eventors/models/dto/EventForSearchDto.dart';
import 'package:the_eventors/models/dto/ListingAllEventRepsonseDto.dart';
import 'package:the_eventors/models/dto/ListingTopEventRepsonseDto.dart';
import 'package:the_eventors/models/dto/MyEventResponseDto.dart';
import 'package:the_eventors/models/dto/NearEventForMapDto.dart';
import 'package:the_eventors/services/ApiService.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:async/async.dart';
import '../models/Events.dart';
import '../models/dto/ActivityOfEventDto.dart';
import '../models/dto/ListingEventNearRepsonseDto.dart';
import '../models/dto/ListingEventRepsonseDto.dart';
import '../models/dto/NotificationInfoDto.dart';
import '../services/Auth.dart';
import '../services/GetLocation.dart';

class EventRepository {
  final APIService _apiService = APIService();

  Future<List<Events>> getEvents() async {
    http.Response response = await _apiService.get("/events");
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((e) => Events.fromJson(e)).toList();
  }

  Future<List<MyEventResponseDto>> getMyEvents() async {
    http.Response response = await _apiService.get("/events/my-events");
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((e) => MyEventResponseDto.fromJson(e)).toList();
  }

  Future<List<MyEventResponseDto>> getMyGoingEvents() async {
    http.Response response = await _apiService.get("/events/my-going");
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((e) => MyEventResponseDto.fromJson(e)).toList();
  }

  Future<List<MyEventResponseDto>> getMyInterestedEvents() async {
    http.Response response = await _apiService.get("/events/my-going");
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((e) => MyEventResponseDto.fromJson(e)).toList();
  }

  Future<Events?> getEventById(int id) async {
    print("Detail called");
    /* SharedPreferences pref = await SharedPreferences.getInstance();
    String token = pref.get('token').toString();
    String ip = "";
    /*if (token.isEmpty) {
      for (var interface in await NetworkInterface.list()) {
        for (var addr in interface.addresses) {
          ip = addr.address;
          print("IP");
          print(ip);
        }
      }
    }*/

    http.Response response = token.isNotEmpty
        ? await _apiService.get("/events/$id/details")
        : await _apiService.get("/events/$id/details");*/
    http.Response response = await _apiService.get("/events/details/$id");
    print(response.body);
    if (response.statusCode == 200) {
      return Events.fromJson(jsonDecode(response.body));
    } else {
      return null;
    }
  }

  Future<ActivityOfEventDto> getActivity(int id) async {
    http.Response response = await _apiService.get("/activity/$id");

    return ActivityOfEventDto.fromJson(jsonDecode(response.body));
  }

  Future<List<ListingEventDto>> getFeed() async {
    print("FEED CALLED");
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString('token');
    http.Response response = await _apiService.get("/events/feed?token=$token");
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((e) => ListingEventDto.fromJson(e)).toList();
  }

  Future<List<ListingEventNearDto>> getNearEvents(int id) async {
    Map<String, String> address = await GetLocation.getUserLocation();
    http.Response response =
        await _apiService.post("/events/all-near/$id", address);
    List jsonResponse = json.decode(response.body);
    print(response.body);
    List<ListingEventNearDto> list =
        jsonResponse.map((e) => ListingEventNearDto.fromJson(e)).toList();
    list.sort((a, b) => a.distance.compareTo(b.distance));
    return list;
  }

  Future<List<ListingAllEventDto>> getAllEvents(int id) async {
    http.Response response = await _apiService.get("/events/all-events/$id");
    List jsonResponse = json.decode(response.body);
    print("ALL EVETNS");
    print(response.body);
    return jsonResponse.map((e) => ListingAllEventDto.fromJson(e)).toList();
  }

  Future<List<ListingEventNearDto>> getAllNearEvents() async {
    print("ALL NEAR EVENT");
    print(await GetLocation.getUserLocation());
    var address = await GetLocation.getUserLocation();

    print("IN DELAY");
    print("END DELAY");

    print(address);
    http.Response response = await _apiService.post("/events/near", address);
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((e) => ListingEventNearDto.fromJson(e)).toList();
  }

  Future<List<NearEventForMapDto>> getAllNearEventsForMap() async {
    Map<String, String> address = await GetLocation.getUserLocation();
    http.Response response =
        await _apiService.post("/events/near-map", address);
    List jsonResponse = json.decode(response.body);

    return jsonResponse.map((e) => NearEventForMapDto.fromJson(e)).toList();
  }

  Future<List<ListingTopEventDto>> getAllTopEvents() async {
    http.Response response = await _apiService.get("/events/top");
    List jsonResponse = json.decode(response.body);

    return jsonResponse.map((e) => ListingTopEventDto.fromJson(e)).toList();
  }

  Future<List<ListingTopEventDto>> getTopEvents(int id) async {
    http.Response response = await _apiService.get("/events/all-top/$id");
    List jsonResponse = json.decode(response.body);
    print(response.body);
    return jsonResponse.map((e) => ListingTopEventDto.fromJson(e)).toList();
  }

  Future<List<CommentResponseDto>> getComment(int id) async {
    http.Response response = await _apiService.get("/comment/$id");
    List jsonData = json.decode(response.body);
    List<CommentResponseDto> comments = [];
    for (var c in jsonData) {
      List<CommentResponseDto> replies = [];
      for (var r in c['replies']) {
        replies.add(CommentResponseDto(
            id: r["id"],
            message: r["message"],
            createdAt: r["createdAt"],
            username: r["username"],
            profileImage: r["profileImage"],
            idEvent: r["idEvent"],
            replies: []));
      }
      comments.add(CommentResponseDto(
          id: c["id"],
          message: c["message"],
          createdAt: c["createdAt"],
          username: c["username"],
          profileImage: c["profileImage"],
          idEvent: c["idEvent"],
          replies: replies));
    }

    return comments;
  }

  Future<List<EventForSearchDto>> findEventsByQuery(String query) async {
    http.Response response = await _apiService.get("/events/search");
    List<EventForSearchDto> events = [];
    List jsonResponse = json.decode(response.body);
    if (query.isNotEmpty) {
      events = jsonResponse
          .map((e) => EventForSearchDto.fromJson(e))
          .where((e) => e.title.toLowerCase().contains(query.toLowerCase()))
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
    var request = http.MultipartRequest(
        'POST', Uri.parse(_apiService.baseUrl + "/events"));

    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString('token');

    request.fields['title'] = title;
    request.fields['description'] = description;
    request.fields['location'] = location;
    request.fields['createdBy'] = token!;
    request.fields['guests'] = guest;
    request.fields['startTime'] = startDateTime;
    request.fields['duration'] = duration;
    request.fields['category'] = category;
    var streamCover =
        http.ByteStream(DelegatingStream.typed(coverImage.openRead()));

    var imageCover = http.MultipartFile(
        "coverImage", streamCover, await coverImage.length(),
        filename: coverImage.path);

    List<MultipartFile>? _images = [];
    for (int i = 0; i < images.length; i++) {
      var streamImages =
          http.ByteStream(DelegatingStream.typed(images[i].openRead()));
      _images.add(http.MultipartFile(
          "images", streamImages, await images[i].length(),
          filename: images[i].path));
    }
    request.files.add(imageCover);
    request.files.addAll(_images);

    await request.send().then((response) async {
      // listen for response
      response.stream.transform(utf8.decoder).listen((value) {});
    }).catchError((e) {
      print(e);
    });
  }

  Future<File> _createFileFromString(String s) async {
    Uint8List bytes = base64.decode(s);
    String dir = (await getApplicationDocumentsDirectory()).path;
    File file = File(
        "$dir/" + DateTime.now().millisecondsSinceEpoch.toString() + ".png");
    await file.writeAsBytes(bytes);
    return await FlutterNativeImage.compressImage(
      file.path,
      quality: 50,
    );
  }

  Future<void> updateEvent(
    int id,
    String title,
    String description,
    String location,
    String coverImage,
    List<String> images,
    String guest,
    String startDateTime,
    String duration,
    String category,
  ) async {
    var request = http.MultipartRequest(
        'POST', Uri.parse(_apiService.baseUrl + "/events/$id"));

    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString('token');
    /* print("COVER PATH");
    print(coverImage.path);*/

    request.fields['title'] = title;
    request.fields['description'] = description;
    request.fields['location'] = location;
    request.fields['createdBy'] = token!;
    request.fields['guests'] = guest;
    request.fields['startTime'] = startDateTime;
    request.fields['duration'] = duration;
    request.fields['category'] = category;

    File f = await _createFileFromString(coverImage);
    var streamCover = http.ByteStream(DelegatingStream.typed(f.openRead()));
    var imageCover = http.MultipartFile(
        "coverImage", streamCover, await f.length(),
        filename: f.path);

    List<MultipartFile>? _images = [];
    for (int i = 0; i < images.length; i++) {
      File fs = await _createFileFromString(images[i]);
      var streamImages = http.ByteStream(DelegatingStream.typed(fs.openRead()));
      _images.add(http.MultipartFile("images", streamImages, await fs.length(),
          filename: fs.path));
    }
    request.files.add(imageCover);
    request.files.addAll(_images);

    await request.send().then((response) async {
      // listen for response
      response.stream.transform(utf8.decoder).listen((value) {});
    }).catchError((e) {});
  }

  Future<void> addGoing(int id, String to, String message) async {
    // Auth().checkRefresh();
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString('token');
    NotificationInfoDto dto =
        NotificationInfoDto(to: to, from: token!, title: to, message: message);

    http.Response response =
        await _apiService.post("/events/$id/going", dto.toJson());
  }

  Future<void> addInterested(int id, String to, String message) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString('token');
    NotificationInfoDto dto =
        NotificationInfoDto(to: to, from: token!, title: to, message: message);

    await _apiService.post("/events/$id/interested", dto.toJson());
  }

  Future<String> removeCheck(int id, String check) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString('token');
    Map<String, dynamic> body = {
      'token': token,
      'id': id,
      'goingOrInterested': check
    };
    http.Response response =
        await _apiService.post("/events/remove-interest", body);
    return response.body;
  }

  Future<void> addComment(String message, int idEvent, String to) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString('token');
    NotificationInfoDto dto =
        NotificationInfoDto(to: to, from: token!, title: to, message: message);

    await _apiService.post("/events/$idEvent/addComment", dto.toJson());
  }

  Future<void> addReply(
      String message, int idEvent, int idComment, String to) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString('token');
    NotificationInfoDto dto =
        NotificationInfoDto(to: to, from: token!, title: to, message: message);

    await _apiService.post(
        "/events/$idEvent/addReplies/$idComment", dto.toJson());
  }

  void deleteEvent(int? id) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString('token');
    Map<String, dynamic> jsonMap = {
      'token': token,
    };
    http.Response response = await _apiService.delete("/events/$id", jsonMap);
    print("DELETE");
    print(response.body);
  }
}
