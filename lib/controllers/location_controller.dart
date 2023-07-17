import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:go_weather/config/app_config.dart';
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
  List<WeatherForecast>? locationsWeatherForcast;

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
        locationsAutoCompleteList.clear();
        List<dynamic> list = response.data;
        for (var element in list) {
          locationsAutoCompleteList
              .add(LocationsAutoCompletModel.fromJson(element));
        }

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

  Future<ApiResponse?> getLocationsListForcast(double lat, double lng) async {
    try {
      ApiResponse response = await repo.getWeatherForecastByCoordinates(
          lat: lat, lng: lng, days: 1);

      if (response.statusCode == 200) {
        // weatherForecast = WeatherForecast.fromJson(response.data);
        // forecastList = weatherForecast?.forecast?.forecastday;

        return response;
      } else {
        if (kDebugMode) {
          print(response.message);
        }
        return null;
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      return null;
    }
  }

  getLocationsForcast() async {
    List<ApiResponse> responseList = [];
    if (AppConfig.instance.listofLocations != null) {
      AppConfig.instance.listofLocations?.forEach((element) async {
        ApiResponse? response =
            await getLocationsListForcast(element.lat!, element.lon!);
        if (response != null) {
          responseList.add(response);
        }
      });
    } else {
      return;
    }

    for (var element in responseList) {
      WeatherForecast weatherForecast = WeatherForecast.fromJson(element.data);
      locationsWeatherForcast?.add(weatherForecast);
    }
  }
}
