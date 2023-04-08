import 'package:flutter/material.dart';
import 'package:the_eventors/models/dto/MyEventResponseDto.dart';

import '../models/dto/MyCommentsResponseDto.dart';
import '../services/MyActivityRepository.dart';

class MyActivityProvider extends ChangeNotifier {
  final MyActivityRepository _repository = MyActivityRepository();

  List<MyEventResponseDto> myEvents = [];
  List<MyEventResponseDto> myGoing = [];
  List<MyEventResponseDto> myInterested = [];
  List<MyEventResponseDto> myBookmarks = [];
  List<MyEventResponseDto> activityProfile = [];
  List<int> check = [];
  bool notifications = false;

  List<MyCommentsResponseDto> myComments = [];
  String checkGoingBt = "false";

  getMyEvents() async {
    myEvents = await _repository.getMyEvents();
    notifyListeners();
  }

  addBookmark(int id) {
    check.add(id);
    notifyListeners();
  }

  removeBookmark(int id) {
    check.remove(id);
    notifyListeners();
  }

  getMyEventsByUser(String username) async {
    myEvents = await _repository.getMyEventsByUser(username);
    notifyListeners();
  }

  getMyGoingEvents() async {
    myGoing = await _repository.getMyGoingEvents();
    notifyListeners();
  }

  getMyInterestedEvents() async {
    myInterested = await _repository.getMyInterestedEvents();
    notifyListeners();
  }

  getActivityProfile() async {
    activityProfile = await _repository.activityProfile();
    notifyListeners();
  }

  getActivityProfileByUser(String username) async {
    activityProfile = await _repository.activityProfileByUser(username);
    notifyListeners();
  }

  getMyBookmarks() async {
    myBookmarks = await _repository.getMyBookmarks();
    notifyListeners();
  }

  getCheckBookmarks() async {
    check = await _repository.getCheckBookmarks();
    notifyListeners();
  }

  getMyComments() async {
    myComments = await _repository.getMyComments();
    print("MY COMMENTs");
    print(myComments);
  }

  checkGoing(int id) async {
    checkGoingBt = await _repository.checkGoing(id);
    notifyListeners();
  }

  addGoing(MyEventResponseDto dto) async {
    myGoing.add(dto);
    notifyListeners();
  }

  removeGoing(int id) async {
    myGoing.removeWhere((element) => element.id == id);
    notifyListeners();
  }

  /*void readNotifications() {
    _repository.readNotification();
  }*/

  notificationsStatus() async {
    notifications = await _repository.checkNoReadNotifications();
    // _repository.getNotificatons();
  }
}
