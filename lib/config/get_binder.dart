import 'package:get/get.dart';
import 'package:go_weather/controllers/weather_controller.dart';

class WeatherBinding implements Bindings {
// default dependency
 @override
 void dependencies() {
   Get.lazyPut(() => WeatherController());
 }
}