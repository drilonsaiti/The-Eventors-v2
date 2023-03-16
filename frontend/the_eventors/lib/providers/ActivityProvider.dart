import 'package:flutter/material.dart';
import 'package:the_eventors/repository/EventRepository.dart';

import '../models/dto/ActivityOfEventDto.dart';

class ActivityProvider extends ChangeNotifier {
  final EventRepository _eventCategory = EventRepository();
  ActivityOfEventDto activity = ActivityOfEventDto();

  getActivity(int id) async {
    activity = await _eventCategory.getActivity(id);
    print(activity.going);
    notifyListeners();
  }
}
