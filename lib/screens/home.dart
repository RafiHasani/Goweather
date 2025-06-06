import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:go_weather/config/app_config.dart';
import 'package:go_weather/controllers/home_controller.dart';
import 'package:go_weather/widgets/degree_widget.dart';
import 'package:go_weather/widgets/drawer_widget.dart';
import 'package:go_weather/widgets/forcast_widget.dart';
import 'package:go_weather/widgets/heading_widget.dart';
import 'package:go_weather/widgets/svgimage_widget.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final GlobalKey<ScaffoldState> navigationDrawarkey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (xController) {
      return Scaffold(
        key: navigationDrawarkey,
        backgroundColor: Colors.black,
        //Drawar
        drawer: DrawerWidget(navigationDrawarkey: navigationDrawarkey),
        body: CustomScrollView(
          physics: ClampingScrollPhysics(),
          slivers: [
            SliverAppBar(
              automaticallyImplyLeading: false,
              pinned: true,
              floating: true,
              backgroundColor: AppConfig.instance.kGreenColor,
              expandedHeight: 100.h,
              collapsedHeight: 100.h,
              flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.parallax,
                background: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    24.verticalSpace,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              xController.currentWeather?.location?.name ??
                                  "_ _",
                              style: TextStyle(
                                  fontSize: 24.sp, fontWeight: FontWeight.bold),
                            ),
                            Transform.translate(
                              offset: Offset(1.w, -2.h),
                              child: const Icon(
                                Icons.location_on,
                                color: Colors.white54,
                                size: 12,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        DegreeWidget(
                          degree: xController
                                  .currentWeather?.current?.feelslikeC
                                  .toString() ??
                              "0",
                          degreeIconSize: 8,
                          borderRadius: 8,
                          degreeFontSize: 42,
                          degreeFontWeigth: FontWeight.bold,
                          width: 3,
                          offset: const Offset(4, -20),
                          color: Colors.white54,
                        ),
                        const Text(
                          'C',
                          style: TextStyle(fontSize: 24, color: Colors.white),
                        ),
                      ],
                    ),
                    16.verticalSpace,
                  ],
                ),
              ),
            ),
            SliverAppBar(
              pinned: true,
              automaticallyImplyLeading: false,
              backgroundColor: AppConfig.instance.kGreenColor,
              expandedHeight: 350.0,
              flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.parallax,
                background: HeadingWidget(
                  xController: xController,
                  menuButtonCallback: () {
                    navigationDrawarkey.currentState!.openDrawer();
                  },
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 16.h),
                child: const DividerWidget(),
              ),
            ),
            SliverToBoxAdapter(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                  8.verticalSpace,
                  Center(
                    child: Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        spacing: 16,
                        runSpacing: 8,
                        children: [
                          WeatherDetailsWidget(
                            title: "Temperature",
                            degree: xController
                                .weatherForecast?.current?.feelslikeC
                                .toString(),
                            type: "C",
                            icon: 'assets/icons/wi_thermometer-celsius.svg',
                            showDegree: true,
                          ),
                          WeatherDetailsWidget(
                            title: "Wind",
                            degree: xController
                                .weatherForecast?.current?.windKph
                                .toString(),
                            type: "kmph",
                            icon: 'assets/icons/wi_wind.svg',
                          ),
                          WeatherDetailsWidget(
                            title: "Humidty",
                            degree: xController
                                .weatherForecast?.current?.humidity
                                .toString(),
                            type: "%",
                            icon: 'assets/icons/wi_humidity.svg',
                          ),
                          WeatherDetailsWidget(
                            title: "Cloudy",
                            degree: xController.weatherForecast?.current?.cloud
                                .toString(),
                            type: "",
                            icon: 'assets/icons/wi_cloudy.svg',
                          ),
                          WeatherDetailsWidget(
                            title: "Perciptation",
                            degree: xController
                                .weatherForecast?.current?.precipIn
                                .toString(),
                            type: "In",
                            icon: 'assets/icons/wi_rain.svg',
                          ),
                          WeatherDetailsWidget(
                            title: "Pressure",
                            degree: xController
                                .weatherForecast?.current?.precipIn
                                .toString(),
                            type: "In",
                            icon: 'assets/icons/wi_pressure-high.svg',
                          ),
                          WeatherDetailsWidget(
                            title: "Visibilty",
                            degree: xController.weatherForecast?.current?.visKm
                                .toString(),
                            type: "KM",
                            icon: 'assets/icons/wi_smoke.svg',
                          ),
                          WeatherDetailsWidget(
                            title: "uv",
                            degree: xController.weatherForecast?.current?.uv
                                .toString(),
                            type: "",
                            icon: 'assets/icons/wi_uv-index.svg',
                          ),
                        ]),
                  ),
                  8.verticalSpace,
                  const DividerWidget(),
                  8.verticalSpace,
                  Text(
                    "Forecast 3 days",
                    style: TextStyle(
                      fontSize: 10.sp,
                      color: Colors.white70,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.start,
                  ),
                  8.verticalSpace,
                  SizedBox(
                    height: 140.h,
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
            SliverFillRemaining()
          ],
        ),
      );
    });
  }
}

class WeatherDetailsWidget extends StatelessWidget {
  final String title;
  final String? degree;
  final String type;
  final String icon;
  final bool? showDegree;

  const WeatherDetailsWidget({
    super.key,
    required this.title,
    this.degree,
    required this.type,
    required this.icon,
    this.showDegree,
  });

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
          SvgimageWidget(icon: icon),
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
