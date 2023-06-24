import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:go_weather/data/models/api_response.dart';
import 'package:go_weather/data/models/locations_autocomplete_model.dart';
import 'package:go_weather/data/models/weather_forecast.dart';
import 'package:go_weather/data/repo/repo.dart';
import 'package:location/location.dart';

class LocationController extends GetxController {
  Repository repo = Repository();
  @override
  Future<void> onInit() async {
    super.onInit();
  }

  bool isLoading = false;

  List<Forecastday>? forecastList;
  WeatherForecast? weatherForecast;

  List<LocationsAutoCompletModel> locationsAutoCompleteList = [];

  Future<void> getWeatherForecast({int? days}) async {
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

  Future<void> searchLocation(String searchLocation) async {
    isLoading = true;
    update([isLoading]);

    try {
      ApiResponse response =
          await repo.getWeatherSearchLocation(searchLocation);

      if (response.statusCode == 200) {
        List<dynamic> list = response.data;
        list.forEach((element) {
          locationsAutoCompleteList
              .add(LocationsAutoCompletModel.fromJson(element));
        });

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
    } finally {
      isLoading = false;
    }
  }
}
