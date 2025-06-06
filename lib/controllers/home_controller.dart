import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:go_weather/data/models/api_response.dart';
import 'package:go_weather/data/models/weather_forecast.dart';
import 'package:go_weather/data/repo/repo.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';

class HomeController extends GetxController {
  Repository repo = Repository();
  @override
  Future<void> onInit() async {
    super.onInit();
    await getCurrentWeather();
    await getWeatherForecast(days: 14);
  }

  WeatherForecast? currentWeather;

  List<Forecastday>? forecastList;
  WeatherForecast? weatherForecast;

  Future<void> getCurrentWeather() async {
    try {
      Location location = Location();

      bool serviceEnabled;
      LocationData locationData;
      PermissionStatus permissionGranted;

      serviceEnabled = await location.serviceEnabled();
      if (!serviceEnabled) {
        serviceEnabled = await location.requestService();
        if (!serviceEnabled) {
          return;
        }
      }

      permissionGranted = await location.hasPermission();

      if (permissionGranted == PermissionStatus.denied) {
        permissionGranted = await location.requestPermission();
        if (permissionGranted != PermissionStatus.granted) {
          return;
        }
      }

      locationData = await location.getLocation();

      ApiResponse response = await repo.getCurrentWeatherByCoordinates(
          locationData.latitude ?? 48.8567, locationData.longitude ?? 2.3508);
      if (response.statusCode == 200) {
        currentWeather = WeatherForecast.fromJson(response.data);
        update();
      } else {
        if (kDebugMode) {
          print(response.message);
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  Future<void> getWeatherForecast({int? days = 14}) async {
    try {
      Location location = Location();

      bool serviceEnabled;
      LocationData locationData;
      PermissionStatus permissionGranted;

      serviceEnabled = await location.serviceEnabled();
      if (!serviceEnabled) {
        serviceEnabled = await location.requestService();
        if (!serviceEnabled) {
          return;
        }
      }

      permissionGranted = await location.hasPermission();
      if (permissionGranted == PermissionStatus.denied) {
        permissionGranted = await location.requestPermission();
        if (permissionGranted != PermissionStatus.granted) {
          return;
        }
      }

      locationData = await location.getLocation();

      ApiResponse response = await repo.getWeatherForecastByCoordinates(
          lat: locationData.latitude ?? 48.8567,
          lng: locationData.longitude ?? 2.3508,
          days: days);

      if (response.statusCode == 200) {
        weatherForecast = WeatherForecast.fromJson(response.data);
        forecastList = weatherForecast?.forecast?.forecastday;
        update();
      } else {
        if (kDebugMode) {
          print(response.message);
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  String getImageName(String imageUrl) {
    var namelist = imageUrl.split('/');
    final path = "/${namelist.elementAt(5)}/${namelist.elementAt(6)}";
    return path;
  }

  String getDateFormated(String dateTime) {
    try {
      DateTime date = DateTime.parse(dateTime);
      DateFormat dateFormat = DateFormat('yyyy-MM-dd');
      return "${dateFormat.format(date)}   ${DateFormat.jm().format(date)}";
    } catch (e) {
      debugPrint(e.toString());
      return "";
    }
  }

  String getDayOfWeek(String date) {
    String day = "";

    DateTime dateTime = DateTime.parse(date);

    day = DateFormat('EEEE').format(dateTime);

    return day;
  }
}
