import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:go_weather/data/models/locations_autocomplete_model.dart';
import 'package:intl/intl.dart';

class AppConfig {
  static AppConfig instance = AppConfig();
  AppConfig() {
    // readStorage();
  }

  readStorage() {
    var item = GetStorage().read(locationsKeyStorage);
    debugPrint(item);
  }

  String locationsKeyStorage = 'locations';

  List<LocationsAutoCompletModel>? listofLocations;

  String apiKey = "95df1309e697457fb83200235251304";

  Color kGreenColor = const Color(0xFF028a7c);

  String dateFormat(DateTime dateTime) {
    final DateFormat formatter = DateFormat('EEE MMMM dd');
    String time = DateFormat.jm().format(dateTime);

    return "${formatter.format(dateTime)}  $time";
  }

  addStorageEntry(String key, dynamic obj) {
    GetStorage().write(key, obj);
    if (kDebugMode) {
      print(GetStorage().read(key).toString());
    }
  }

  dynamic readStorageEntry(String key) {
    return GetStorage().read(key);
  }
}
