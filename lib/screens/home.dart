import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:go_weather/config/app_config.dart';
import 'package:go_weather/config/router.dart';
import 'package:go_weather/controllers/home_controller.dart';
import 'package:material_symbols_icons/symbols.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key}) {}

  final GlobalKey<ScaffoldState> navigationDrawarkey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (xController) {
      return Scaffold(
        key: navigationDrawarkey,
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: AppConfig().kGreenColor,
          leadingWidth: 80,
          leading: Expanded(
            flex: 1,
            child: IconButton(
              onPressed: () {
                navigationDrawarkey.currentState!.openDrawer();
              },
              icon: const Icon(Icons.menu_open_rounded),
            ),
          ),
        ),
        //Drawar
        drawer: Drawer(
          width: 0.8.sw,
          backgroundColor: const Color.fromARGB(100, 2, 138, 124),
          child: Container(
            decoration: BoxDecoration(
              color: const Color.fromARGB(180, 0, 0, 0),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(160.r),
                bottomRight: Radius.circular(10.r),
              ),
            ),
            margin:
                EdgeInsetsDirectional.only(top: 60.h, bottom: 0.h, end: 30.w),
            child: ListView(
              // Important: Remove any padding from the ListView.
              padding: EdgeInsets.zero,
              children: [
                100.verticalSpace,
                // ListTile(
                //   leading: const Icon(
                //     Icons.add_location_alt_outlined,
                //   ),
                //   title: const Text('Other locations'),
                //   onTap: () {
                //     Navigator.pop(context);
                //   },
                // ),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(100, 2, 138, 124),
                    ),
                    onPressed: () {
                      navigationDrawarkey.currentState?.closeDrawer();
                      Get.back();
                      Get.toNamed(Routes.manageScreen);
                    },
                    child: Text(
                      'Manage locations',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),

        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HeadingWidget(
              xController: xController,
            ),
            16.verticalSpace,
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.only(bottom: 42.h),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const DividerWidget(),
                      8.verticalSpace,
                      Text(
                        "Weather Details",
                        style: TextStyle(
                          fontSize: 10.sp,
                          color: Colors.white70,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.start,
                      ),
                      SizedBox(
                        height: 160.h,
                        width: 1.sw,
                        child: GridView(
                            physics: const NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.only(top: 8.h),
                            gridDelegate:
                                SliverGridDelegateWithMaxCrossAxisExtent(
                              crossAxisSpacing: 8.0,
                              mainAxisSpacing: 8.0,
                              maxCrossAxisExtent: 100.w,
                            ),
                            children: [
                              WeatherDetailsWidget(
                                title: "Temperature",
                                degree: xController
                                    .weatherForecast?.current?.feelslikeC
                                    .toString(),
                                type: "C",
                                icon: Icons.thermostat_sharp,
                                showDegree: true,
                              ),
                              WeatherDetailsWidget(
                                title: "Wind",
                                degree: xController
                                    .weatherForecast?.current?.windKph
                                    .toString(),
                                type: "kmph",
                                icon: Icons.wind_power_outlined,
                              ),
                              WeatherDetailsWidget(
                                title: "Humidty",
                                degree: xController
                                    .weatherForecast?.current?.humidity
                                    .toString(),
                                type: "%",
                                icon: Symbols.humidity_percentage,
                              ),
                              WeatherDetailsWidget(
                                title: "Cloudy",
                                degree: xController
                                    .weatherForecast?.current?.cloud
                                    .toString(),
                                type: "",
                                icon: Icons.wb_cloudy_outlined,
                              ),
                              WeatherDetailsWidget(
                                title: "Perciptation",
                                degree: xController
                                    .weatherForecast?.current?.precipIn
                                    .toString(),
                                type: "In",
                                icon: Symbols.rainy,
                              ),
                              WeatherDetailsWidget(
                                title: "Pressure",
                                degree: xController
                                    .weatherForecast?.current?.precipIn
                                    .toString(),
                                type: "In",
                                icon: Symbols.blood_pressure_sharp,
                              ),
                              WeatherDetailsWidget(
                                title: "Visibilty",
                                degree: xController
                                    .weatherForecast?.current?.visKm
                                    .toString(),
                                type: "KM",
                                icon: Icons.visibility,
                              ),
                              WeatherDetailsWidget(
                                title: "uv",
                                degree: xController.weatherForecast?.current?.uv
                                    .toString(),
                                type: "",
                                icon: Icons.light_mode,
                              ),
                            ]),
                      ),
                      const DividerWidget(),
                      8.verticalSpace,
                      Text(
                        "Forecast 14 days",
                        style: TextStyle(
                          fontSize: 10.sp,
                          color: Colors.white70,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.start,
                      ),
                      8.verticalSpace,
                      SizedBox(
                        height: 120.h,
                        width: 1.sw,
                        child: ListView.builder(
                          itemCount: xController.forecastList?.length ?? 0,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: ((context, index) {
                            return Padding(
                              padding: EdgeInsetsDirectional.only(end: 16.w),
                              child: ForecastWidget(
                                dayicon:
                                    "assets/weather${xController.getImageName(xController.forecastList?.elementAt(index).day?.condition?.icon ?? "113.png")}",
                                max: xController.forecastList
                                        ?.elementAt(index)
                                        .day
                                        ?.maxtempC
                                        .toString() ??
                                    "",
                                day: xController.getDayOfWeek(xController
                                        .forecastList!
                                        .elementAt(index)
                                        .date ??
                                    DateTime.now().toString()),
                                nighticon:
                                    "assets/weather${xController.getImageName(xController.forecastList?.elementAt(index).hour?.elementAt(0).condition?.icon ?? "113.png")}",
                                min: xController.forecastList
                                        ?.elementAt(index)
                                        .hour
                                        ?.elementAt(11)
                                        .feelslikeC
                                        .toString() ??
                                    "",
                              ),
                            );
                          }),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      );
    });
  }
}

class ForecastWidget extends StatelessWidget {
  final String dayicon;
  final String day;
  final String max;
  final String nighticon;
  final String min;

  ForecastWidget({
    Key? key,
    required this.dayicon,
    required this.max,
    required this.day,
    required this.nighticon,
    required this.min,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 120.h,
        width: 70.h,
        padding: EdgeInsets.all(10.r),
        decoration: BoxDecoration(
          border: Border.all(
            width: 2.w,
            color: Colors.white38,
          ),
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              day,
              style: TextStyle(
                fontSize: 10.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white60,
              ),
            ),
            4.verticalSpace,
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Image.asset(
                      dayicon,
                      color: Colors.white,
                      height: 24.h,
                      width: 24.h,
                    ),
                    4.verticalSpace,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          max,
                          style: TextStyle(
                            fontSize: 10.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white60,
                          ),
                        ),
                        Transform.translate(
                          offset: const Offset(1, -4),
                          child: Container(
                            height: 3.h,
                            width: 3.h,
                            decoration: BoxDecoration(
                              border:
                                  Border.all(width: 1, color: Colors.white38),
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: Container(),
                          ),
                        ),
                        Text(
                          "C",
                          style: TextStyle(
                            fontSize: 10.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white60,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Divider(
                  height: 1,
                ),
                Column(
                  children: [
                    Image.asset(
                      nighticon,
                      color: Colors.white,
                      height: 24.h,
                      width: 24.h,
                    ),
                    4.verticalSpace,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          min,
                          style: TextStyle(
                            fontSize: 10.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white60,
                          ),
                        ),
                        Transform.translate(
                          offset: const Offset(1, -4),
                          child: Container(
                            height: 3.h,
                            width: 3.h,
                            decoration: BoxDecoration(
                              border:
                                  Border.all(width: 1, color: Colors.white38),
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: Container(),
                          ),
                        ),
                        Text(
                          "C",
                          style: TextStyle(
                            fontSize: 10.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white60,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ));
  }
}

class WeatherDetailsWidget extends StatelessWidget {
  final String title;
  final String? degree;
  final String type;
  final IconData icon;
  final bool? showDegree;

  const WeatherDetailsWidget({
    Key? key,
    required this.title,
    this.degree,
    required this.type,
    required this.icon,
    this.showDegree,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80.h,
      width: 60.h,
      padding: EdgeInsets.all(10.r),
      decoration: BoxDecoration(
        border: Border.all(
          width: 2.w,
          color: Colors.white38,
        ),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            icon,
            color: Colors.white,
          ),
          4.verticalSpace,
          Text(
            title,
            style: TextStyle(
              fontSize: 6.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white60,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                degree ?? "- -",
                style: TextStyle(
                    fontSize: 8.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white60),
              ),
              2.horizontalSpace,
              if (showDegree ?? false)
                Transform.translate(
                  offset: const Offset(-2, -4),
                  child: Container(
                    height: 3.h,
                    width: 3.h,
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.white38),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Container(),
                  ),
                ),
              Text(
                type,
                style: TextStyle(
                    fontSize: 8.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white60),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class DividerWidget extends StatelessWidget {
  const DividerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        color: Colors.white24,
      ),
      child: SizedBox(
        height: 2.h,
        width: 1.sw,
      ),
    );
  }
}

class HeadingWidget extends StatelessWidget {
  final HomeController? xController;

  HeadingWidget({
    this.xController,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 0.35.sh,
      width: 1.sw,
      decoration: BoxDecoration(
        color: AppConfig().kGreenColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30.r),
          bottomRight: Radius.circular(30.r),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Text(
                    xController?.weatherForecast?.location?.name ?? "_ _",
                    style:
                        TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold),
                  ),
                  8.verticalSpace,
                  const Icon(
                    Icons.pin_drop,
                    color: Colors.white70,
                  ),
                ],
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              DegreeWidget(
                degree: xController?.weatherForecast?.current?.feelslikeC
                        .toString() ??
                    "0",
                degreeIconSize: 8,
                borderRadius: 8,
                degreeFontSize: 42,
                degreeFontWeigth: FontWeight.bold,
                width: 3,
                offset: const Offset(4, -20),
              ),
              16.verticalSpace,
              Text(
                "${xController?.weatherForecast?.location?.region ?? ""} ${xController?.weatherForecast?.location?.country ?? ""}",
                style: TextStyle(
                  fontSize: 10.sp,
                  color: Colors.white70,
                  fontWeight: FontWeight.bold,
                ),
              ),
              16.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  xController?.weatherForecast?.current?.condition != null
                      ? Image.asset(
                          "assets/weather${xController?.getImageName(xController!.weatherForecast!.current!.condition!.icon ?? "113.png")}",
                          color: Colors.white,
                          scale: 1.h,
                        )
                      : const Icon(
                          Icons.wb_cloudy_outlined,
                          color: Colors.white,
                          size: 28,
                        ),
                  Text(
                    xController?.weatherForecast?.current?.condition?.text ??
                        "",
                    style: TextStyle(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              16.verticalSpace,
              Text(
                xController?.getDateFormated(xController
                            ?.weatherForecast?.location?.localtime
                            .toString() ??
                        DateTime.now().toString()) ??
                    "",
                style: TextStyle(
                  fontSize: 10.sp,
                  color: Colors.white70,
                  fontWeight: FontWeight.bold,
                ),
              ),
              16.verticalSpace,
            ],
          ),
        ],
      ),
    );
  }
}

class DegreeWidget extends StatelessWidget {
  final Offset offset;
  final double degreeIconSize;
  final double width;
  final Color? color;
  final double borderRadius;
  final String degree;
  final Color? degreeColor;
  final double degreeFontSize;
  final FontWeight degreeFontWeigth;

  const DegreeWidget({
    super.key,
    required this.offset,
    required this.degreeIconSize,
    required this.width,
    required this.borderRadius,
    required this.degree,
    this.degreeColor,
    required this.degreeFontSize,
    required this.degreeFontWeigth,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          degree,
          style: TextStyle(
            fontSize: degreeFontSize.sp,
            color: degreeColor ?? Colors.white,
            fontWeight: degreeFontWeigth,
          ),
        ),
        Transform.translate(
          offset: offset,
          child: Container(
            height: degreeIconSize.h,
            width: degreeIconSize.h,
            decoration: BoxDecoration(
                border: Border.all(
                  width: width,
                  color: color ?? Colors.white,
                ),
                borderRadius: BorderRadius.circular(borderRadius.r)),
            child: Container(),
          ),
        ),
      ],
    );
  }
}
