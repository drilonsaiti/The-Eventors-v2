import 'dart:convert';

import 'package:flutter/material.dart';

SettingsList newsModelFromJson(String str) =>
    SettingsList.fromJson(json.decode(str));

String newsModelToJson(SettingsList data) => json.encode(data.toJson());

class SettingsList {
  String name;
  Icon? icon;
  Widget? widget;

  SettingsList({
    required this.name,
    this.icon = null,
    this.widget,
  });

  //List<String> following;

  //List<String> followers;
  //List<Bookmakrs> bookmarks;

  factory SettingsList.fromJson(Map<String, dynamic> json) => SettingsList(
        name: json["name"],
        widget: json["widget"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "widget": widget,
      };
}
