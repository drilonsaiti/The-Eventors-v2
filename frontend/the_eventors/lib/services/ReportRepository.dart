import 'package:the_eventors/models/dto/RegisterDto.dart';
import 'package:the_eventors/services/ApiService.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


import '../models/Report.dart';


class ReportRepository {
  final APIService _apiService = APIService();

  Future<List<Report>> getReportTypes() async {
    http.Response response = await _apiService.get("/reports/types");
    List<String> categories = [];
    
    List<Report> reports = [];
    for (String c in jsonDecode(response.body)) {
      reports.add(Report(name: c));
    }

    return reports;
  }

  Future<void> addReportEvent(int id, String type) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString('token');
    Map<String, dynamic> jsonMap = {'token': token, 'type': type};
    
        await _apiService.post("/reports/event/$id", jsonMap);
  }
}
