import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';

class MySearchDelegate extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) => [
        // TODO: implement buildActions
        IconButton(
            onPressed: () {
              if (query.isEmpty) {
                close(context, null);
              } else {
                query = '';
              }
            },
            icon: Icon(Icons.clear))
      ];

  @override
  Widget? buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
        onPressed: () => close(context, null), icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) => Center(
        child: Text(
          query,
        ),
      );
  List<String> searchResults = [];

  Future<List<String>> getSuggestion(String query) async {
    final uuid = Uuid();
    final _sessionToken = uuid.v4();
    String api = "AIzaSyCJL6U_VH51jknp-Vs3ciddmoPX2_kH5Ak";
    String baseURL =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json';
    String request =
        '$baseURL?input=$query&key=$api&swssiontoke=$_sessionToken';

    var response = await http.get(Uri.parse(request));
    List<String> list = [];
    for (var i in jsonDecode(response.body)['predictions']) {
      list.add(i['description']);
    }
    if (response.statusCode == 200) {
      return list;
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget buildSuggestions(BuildContext context) => FutureBuilder<List<String>>(
        future: getSuggestion(query),
        builder: (context, AsyncSnapshot<List<String>> snapshot) {
          if (query.isEmpty) return Center(child: Text("No suggestions!"));
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(
                child: CircularProgressIndicator(
                  color: Color(0xFF007CC7),
                ),
              );
            default:
              if (snapshot.hasError || snapshot.data!.isEmpty) {
                return Center(child: Text("No suggestions!"));
              } else {
                return builSuggestionsSuccess(snapshot.data);
              }
          }
        },
      );

  Widget builSuggestionsSuccess(List<String>? suggestions) => ListView.builder(
        itemCount: suggestions!.length,
        itemBuilder: (context, index) {
          final suggestion = suggestions[index];

          return ListTile(
            title: Text(suggestion),
            onTap: () => close(context, suggestion),
          );
        },
      );
}
