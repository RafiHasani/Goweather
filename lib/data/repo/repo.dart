import 'package:go_weather/config/app_config.dart';
import 'package:go_weather/data/http_provider/http_provider.dart';
import 'package:go_weather/data/models/api_response.dart';
import 'package:go_weather/data/repo/end_points.dart';

class Repository {
  Future<ApiResponse> getCurrentWeatherByCoordinates(
      double lat, double lng) async {
    final response = await HttpProvider().getRequest(
        url:
            "${EndPoint.baseUrl}/current.json?q=$lat,$lng&key=${AppConfig.instance.apiKey}");

    return response;
  }

  Future<ApiResponse> getWeatherForecastByCoordinates(
      {int? days = 14, required double lat, required double lng}) async {
    final response = await HttpProvider().getRequest(
      url:
          "${EndPoint.baseUrl}/forecast.json?q=$lat,$lng&days=14&key=${AppConfig.instance.apiKey}",
    );
    return response;
  }

  Future<ApiResponse> getWeatherSearchLocation(String? locationName) async =>
      await HttpProvider().getRequest(
          url:
              "${EndPoint.baseUrl}/search.json?key=${AppConfig.instance.apiKey}&q=$locationName");
}
