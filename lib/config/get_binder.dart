import 'package:get/get.dart';
import 'package:go_weather/controllers/home_controller.dart';
import 'package:go_weather/controllers/location_controller.dart';

class WeatherBinding implements Bindings {
// default dependency
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController());
    Get.lazyPut(() => LocationController());
  }
}
