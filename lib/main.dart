import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:go_weather/config/router.dart';
import 'package:go_weather/screens/add_location.dart';
import 'package:go_weather/screens/home.dart';
import 'package:go_weather/screens/manage_locations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_weather/config/get_binder.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          // You can use the library anywhere in the app even in theme
          theme: ThemeData(
            brightness: Brightness.dark,
            useMaterial3: true,
            textTheme: GoogleFonts.assistantTextTheme(
              Theme.of(context).textTheme.apply(
                    bodyColor: Colors.white38,
                  ),
            ),
            scaffoldBackgroundColor: const Color(0xFF282E45),
          ),
          initialBinding: WeatherBinding(),
          initialRoute: Routes.homeScreen,
          routes: {
            Routes.homeScreen: (context) => HomeScreen(),
            Routes.manageScreen: (context) => ManageLocations(),
            Routes.addLocationScreen: (context) => AddLocation(),
          },
        );
      },
    );
  }
}
