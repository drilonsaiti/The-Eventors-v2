import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_eventors/models/dto/MyCommentsResponseDto.dart';
import '../models/Notifications.dart';
import '../models/dto/MyEventResponseDto.dart';
import '../services/ApiService.dart';

class MyActivityRepository {
  final APIService _apiService = APIService();

  Future<List<MyEventResponseDto>> getMyGoingEvents() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString('token');
    http.Response response =
        await _apiService.get("/my-activity/going?token=$token");
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((e) => MyEventResponseDto.fromJson(e)).toList();
    }
    {
      return [];
    }
  }

  Future<List<MyEventResponseDto>> getMyInterestedEvents() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString('token');
    http.Response response =
        await _apiService.get("/my-activity/interested?token=$token");
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((e) => MyEventResponseDto.fromJson(e)).toList();
    }
    {
      return [];
    }
  }

  Future<List<MyEventResponseDto>> getMyEvents() async {
    print("MY EVENTS");

    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString('token');
    http.Response response =
        await _apiService.get("/my-activity/my-events?token=$token");
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      print(response.body);

      return jsonResponse.map((e) => MyEventResponseDto.fromJson(e)).toList();
    }
    {
      return [];
    }
  }

  Future<List<MyEventResponseDto>> getMyEventsByUser(String username) async {
    http.Response response =
        await _apiService.get("/my-activity/my-events-user?username=$username");
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);

      return jsonResponse.map((e) => MyEventResponseDto.fromJson(e)).toList();
    }
    {
      return [];
    }
  }

  Future<List<MyEventResponseDto>> activityProfile() async {
    print("ACTIVITY PROFILE");
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString('token');
    http.Response response =
        await _apiService.get("/my-activity/activity-profile?token=$token");
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((e) => MyEventResponseDto.fromJson(e)).toList();
    }
    {
      return [];
    }
  }

  Future<List<MyEventResponseDto>> activityProfileByUser(
      String username) async {
    http.Response response = await _apiService
        .get("/my-activity/activity-profile-user?username=$username");
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      print(response.body);
      return jsonResponse.map((e) => MyEventResponseDto.fromJson(e)).toList();
    }
    {
      return [];
    }
  }

  Future<List<MyEventResponseDto>> getMyBookmarks() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString('token');
    http.Response response = await _apiService.get("/bookmark?token=$token");

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((e) => MyEventResponseDto.fromJson(e)).toList();
    }
    {
      return [];
    }
  }

  Future<List<int>> getCheckBookmarks() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString('token');
    http.Response response = await _apiService.get("/check?token=$token");
    List<int> list = [];
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      jsonResponse.map((e) => list.add(e));
      return list;
    }
    {
      return [];
    }
  }

  Future<List<MyCommentsResponseDto>> getMyComments() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString('token');
    http.Response response =
        await _apiService.get("/my-activity/my-comments?token=$token");

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);

      return jsonResponse
          .map((e) => MyCommentsResponseDto.fromJson(e))
          .toList();
    } else {
      return [];
    }
  }

  Future<String> checkGoing(int id) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString('token');
    Map<String, dynamic> body = {'token': token, 'id': id};
    http.Response response =
        await _apiService.post("/my-activity/check-interest", body);
    return response.body;
  }

  Future<String> check(int id) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString('token');
    Map<String, dynamic> body = {'token': token, 'id': id};
    http.Response response =
        await _apiService.post("/my-activity/check-interest", body);
    return response.body;
  }

  Future<List<Notifications>> getNotificatons() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString('token');
    Map<String, dynamic> body = {'token': token};
    http.Response response =
        await _apiService.post("/my-activity/notifications", body);
    List jsonResponse = json.decode(response.body);
    print("GET NOTIFICATIONS");
    print(response.body);
    return jsonResponse.map((e) => Notifications.fromJson(e)).toList();
  }

  Future<dynamic> checkNoReadNotifications() async {
    List<Notifications> list = await getNotificatons();

    if (list.isEmpty) return true;
    return list.where((e) => e.read == false).isEmpty;
  }

  void readNotification() async {
    print("READ NOTIFI");
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString('token');
    Map<String, dynamic> body = {'token': token};
    http.Response response =
        await _apiService.post("/my-activity/notifications/read", body);
  }
}
