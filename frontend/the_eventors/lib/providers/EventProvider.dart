import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:the_eventors/repository/CategoryRepository.dart';
import 'package:the_eventors/repository/EventRepository.dart';

import '../models/Category.dart';
import '../models/Events.dart';

class EventProvider extends ChangeNotifier {
  final EventRepository _eventCategory = EventRepository();
  List<Events> events = [];
  List<Events> findEvents = [];

  getEvents() async {
    events = await _eventCategory.getEvents();
    notifyListeners();
  }

  findEventsByQuery(String query) async {
    findEvents = await _eventCategory.findEventsByQuery(query);

    notifyListeners();
  }

  addEvent(
      String title,
      String description,
      String location,
      File coverImage,
      List<File> images,
      String guest,
      String startDateTime,
      String duration,
      String category) async {
    print(guest);
    await _eventCategory.addEvent(title, description, location, coverImage,
        images, guest, startDateTime, duration, category);
    notifyListeners();
  }
}
