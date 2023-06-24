import 'package:go_weather/config/app_config.dart';
import 'package:go_weather/data/http_provider/http_provider.dart';
import 'package:go_weather/data/models/api_response.dart';
import 'package:go_weather/data/repo/end_points.dart';

class Repository {
  Future<ApiResponse> getCurrentWeatherByCoordinates(
          double lat, double lng) async =>
      await HttpProvider().getRequest(
          url:
              "${EndPoint.baseUrl}/current.json?key=${AppConfig().apiKey}&q=$lat,$lng");

  Future<ApiResponse> getWeatherForecastByCoordinates(
          double lat, double lng) async =>
      await HttpProvider().getRequest(
          url:
              "${EndPoint.baseUrl}/forecast.json?key=${AppConfig().apiKey}&q=$lat,$lng&days=14&aqi=yes");

  Future<ApiResponse> getWeatherSearchLocation(String locationName) async =>
      await HttpProvider().getRequest(
          url:
              "${EndPoint.baseUrl}/search.json?key=${AppConfig().apiKey}&q=$locationName");
}
