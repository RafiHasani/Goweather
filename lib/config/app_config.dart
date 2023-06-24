import 'package:flutter/material.dart';

class AppConfig {
  static final AppConfig _singleton = AppConfig._internal();

  factory AppConfig() {
    return _singleton;
  }

  AppConfig._internal();

  String apiKey = "be7b2016c758473eb4f153604232006";

  Color kGreenColor = const Color(0xFF028a7c);

  
}
