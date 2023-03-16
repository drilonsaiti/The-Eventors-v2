import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../db/RefreshTokenDB.dart';
import 'ApiService.dart';

class Auth {
  final APIService _apiService = APIService();

  Future<bool> checkRefresh() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String token = "";
    bool isExpired = true;
    if (pref.getString("token") != null) {
      token = pref.getString("token")!;
      print("TRUE");
      Map<String, dynamic> jsonMap = {
        'token': token,
      };
      http.Response response =
          await _apiService.post("/users/token/expired", jsonMap);
      isExpired = response.body.contains("false") ? false : true;
      print(token);
      print(response.body);
    }

    if (token.isEmpty) {
      final user = await RefreshTokenDB.instance.readRefreshToken();

      if (user == null || user.refreshToken.isEmpty) {
        return false;
      } else {
        String refreshToken = user.refreshToken;
        Map<String, String> headers = {
          "content-type": "application/json",
          "accept": "application/json",
          'Authorization': 'Bearer $refreshToken',
        };
        Uri uri = Uri.parse(_apiService.baseUrl + "/users/token/refresh");
        http.Response response = await http.get(uri, headers: headers);
        print(response.body);
        if (!response.body.startsWith("Refresh") &&
            !response.body.startsWith("No auth")) {
          Map<String, dynamic> jsonMap = {
            'token': response.body,
          };
          http.Response response2 =
              await _apiService.post("/auth/extract-username", jsonMap);
          pref.setString('username', response2.body);
          pref.setString('token', response.body);
          print("AUTH HERE 2");
          print(pref.get('username'));
          if (response2.statusCode == 200 && response.statusCode == 200) {
            return true;
          } else {
            return false;
          }
        }

        return false;
      }
    } else {
      if (!isExpired) {
        print("IN LAST");
        Map<String, dynamic> jsonMap = {
          'token': pref.get('token')!,
        };
        http.Response response2 =
            await _apiService.post("/auth/extract-username", jsonMap);
        pref.setString('username', response2.body);
        if (response2.statusCode == 200) {
          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    }
  }
}
