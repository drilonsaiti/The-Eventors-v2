import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:the_eventors/models/dto/CommentResponseDto.dart';
import 'package:the_eventors/models/dto/ListingAllEventRepsonseDto.dart';
import 'package:the_eventors/models/dto/ListingEventNearRepsonseDto.dart';
import 'package:the_eventors/models/dto/ListingTopEventRepsonseDto.dart';
import 'package:the_eventors/models/dto/MyEventResponseDto.dart';
import 'package:the_eventors/models/dto/NearEventForMapDto.dart';
import 'package:the_eventors/providers/MyActivityProvider.dart';

import '../models/Category.dart';
import '../models/Events.dart';
import '../models/dto/ActivityOfEventDto.dart';
import '../models/dto/EventForSearchDto.dart';
import '../models/dto/ListingEventRepsonseDto.dart';
import '../models/dto/NotificationInfoDto.dart';
import '../services/EventRepository.dart';

class EventProvider extends ChangeNotifier {
  final EventRepository _eventCategory = EventRepository();
  List<Events?> events = [];
  List<EventForSearchDto> findEvents = [];
  List<ListingEventDto> feed = [];
  List<ListingEventNearDto> near = [];
  List<ListingEventNearDto> allNear = [];
  List<NearEventForMapDto> allNearForMap = [];
  List<ListingAllEventDto> allEvents = [];

  List<ListingTopEventDto> top = [];
  List<ListingTopEventDto> allTop = [];

  Events event = Events(images: [], going: [], interested: [], guest: []);
  List<CommentResponseDto> comments = [];
  ActivityOfEventDto activity = ActivityOfEventDto();

  getEvents() async {
    events = await _eventCategory.getEvents();
    notifyListeners();
  }

  getNear(int id) async {
    near = await _eventCategory.getNearEvents(id);
    notifyListeners();
  }

  getAllEvents(int id) async {
    allEvents = await _eventCategory.getAllEvents(id);
  }

  getAllNear() async {
    allNear = await _eventCategory.getAllNearEvents();
  }

  getAllNearForMap() async {
    allNearForMap = await _eventCategory.getAllNearEventsForMap();
  }

  getAllTop() async {
    allTop = await _eventCategory.getAllTopEvents();
  }

  getTop(int id) async {
    top = await _eventCategory.getTopEvents(id);
    notifyListeners();
  }

  getFeed() async {
    feed = await _eventCategory.getFeed();
    notifyListeners();
  }

  getEventById(int id) async {
    event = (await _eventCategory.getEventById(id))!;
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
    await _eventCategory.addEvent(title, description, location, coverImage,
        images, guest, startDateTime, duration, category);
    notifyListeners();
  }

  updateEvent(
      int id,
      String title,
      String description,
      String location,
      String coverImage,
      List<String> images,
      String guest,
      String startDateTime,
      String duration,
      String category) async {
    await _eventCategory.updateEvent(id, title, description, location,
        coverImage, images, guest, startDateTime, duration, category);
    notifyListeners();
  }

  addGoing(int id, String to, String message) {
    _eventCategory.addGoing(id, to, message);
    notifyListeners();
  }

  addInterested(int id, String to, String message) {
    _eventCategory.addInterested(id, to, message);
    notifyListeners();
  }

  removeCheck(int id, String check) {
    _eventCategory.removeCheck(id, check);
    notifyListeners();
  }

  addComment(String message, int idEvent, String to) {
    _eventCategory.addComment(message, idEvent, to);
    notifyListeners();
  }

  addReply(String message, int idEvent, int idComment, String to) {
    _eventCategory.addReply(message, idEvent, idComment, to);
    notifyListeners();
  }

  getComments(int id) async {
    comments = await _eventCategory.getComment(id);
    notifyListeners();
  }

  getActivity(int id) async {
    activity = await _eventCategory.getActivity(id);
    notifyListeners();
  }

  void deleteEvent(int? id) {
    _eventCategory.deleteEvent(id);
    notifyListeners();
  }
}
