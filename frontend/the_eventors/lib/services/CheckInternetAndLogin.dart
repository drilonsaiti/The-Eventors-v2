import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';

class CheckInternet {
  static void showTopSnackBar(
    BuildContext context,
    String message,
  ) =>
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: const Color(0xFFEEFBFB),
          content: Row(
            children: [
              Icon(Icons.signal_wifi_connected_no_internet_4,
                  color: Color(0xFF12232E)),
              SizedBox(
                width: 5,
              ),
              Text(
                message,
                style: TextStyle(color: Color(0xFF12232E), fontSize: 14),
              ),
            ],
          )));
}
