import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_weather/config/app_config.dart';
import 'package:go_weather/config/router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 6), () {
      Get.offAndToNamed(Routes.homeScreen);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConfig.instance.kGreenColor,
      body: Center(
        child: textLiquidFilledWidget(),
      ),
    );
  }

  TextLiquidFill textLiquidFilledWidget() {
    return TextLiquidFill(
      text: 'Goweather',
      waveDuration: const Duration(seconds: 1),
      waveColor: Colors.white70,
      boxBackgroundColor: AppConfig.instance.kGreenColor,
      textStyle: const TextStyle(
        fontSize: 60.0,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    );
  }
}
