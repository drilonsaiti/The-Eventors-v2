import 'package:flutter/cupertino.dart';

import '../models/Report.dart';
import '../services/ReportRepository.dart';

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
