import 'package:flutter/cupertino.dart';
import 'package:the_eventors/repository/CategoryRepository.dart';

import '../models/Report.dart';
import '../repository/ReportRepository.dart';

class ReportProvider extends ChangeNotifier {
  final ReportRepository _reportRepository = ReportRepository();
  List<Report> reports = [];
  getReportTypes() async {
    reports = await _reportRepository.getReportTypes();
    notifyListeners();
  }

  addReportEvent(int id, String type) {
    _reportRepository.addReportEvent(id, type);
    notifyListeners();
  }
}
