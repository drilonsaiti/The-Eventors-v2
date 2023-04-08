import 'package:flutter/material.dart';

import '../models/dto/ActivityOfEventDto.dart';
import '../services/EventRepository.dart';

class ActivityProvider extends ChangeNotifier {
  final EventRepository _eventCategory = EventRepository();
  ActivityOfEventDto activity = ActivityOfEventDto();

  getActivity(int id) async {
    activity = await _eventCategory.getActivity(id);
    print(activity.going);
    notifyListeners();
  }
}
