import 'dart:convert';

Report newsModelFromJson(String str) => Report.fromJson(json.decode(str));

String newsModelToJson(Report data) => json.encode(data.toJson());

class Report {
  String name;

  Report({
    required this.name,
  });

  //List<String> following;

  //List<String> followers;
  //List<Bookmakrs> bookmarks;

  factory Report.fromJson(Map<String, dynamic> json) => Report(
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
      };
}
