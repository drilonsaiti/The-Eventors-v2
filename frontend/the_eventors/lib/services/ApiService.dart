import 'dart:convert';
import 'package:http/http.dart' as http;

class APIService {
  final String baseUrl = "http://192.168.1.6:8080/api";

  Map<String, String> headers = {
    "content-type": "application/json",
    "accept": "application/json",
  };

  Future<http.Response> get(String url) async {
    try {
      Uri uri = Uri.parse(baseUrl + url);
      http.Response response = await http.get(uri, headers: headers);
      return response;
    } catch (e) {
      return http.Response({"message": e}.toString(), 400);
    }
  }

  Future<http.Response> getWithBody(String url, String token) async {
    try {
      final queryParameters = {
        'token': token,
      };
      Uri uri = Uri.http(baseUrl, url, queryParameters);
      http.Response response = await http.get(
        uri,
        headers: headers,
      );
      return response;
    } catch (e) {
      return http.Response({"message": e}.toString(), 400);
    }
  }

  Future<http.Response> post(String url, Map<String, dynamic> body) async {
    try {
      Uri uri = Uri.parse(baseUrl + url);
      String bodyString = json.encode(body);
      http.Response response =
          await http.post(uri, headers: headers, body: bodyString);
      return response;
    } catch (e) {
      return http.Response({"message": e}.toString(), 400);
    }
  }

  Future<http.Response> put(String url, Map<String, dynamic> body) async {
    try {
      Uri uri = Uri.parse(baseUrl + url);
      String bodyString = json.encode(body);
      http.Response response =
          await http.put(uri, headers: headers, body: bodyString);
      return response;
    } catch (e) {
      return http.Response({"message": e}.toString(), 400);
    }
  }

  Future<http.Response> delete(String url, Map<String, dynamic> body) async {
    try {
      Uri uri = Uri.parse(baseUrl + url);
      String bodyString = json.encode(body);
      http.Response response =
          await http.delete(uri, headers: headers, body: bodyString);
      return response;
    } catch (e) {
      return http.Response({"message": e}.toString(), 400);
    }
  }
}
