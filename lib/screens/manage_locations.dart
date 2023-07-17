import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:go_weather/config/app_config.dart';
import 'package:go_weather/config/router.dart';
import 'package:go_weather/controllers/location_controller.dart';
import 'package:go_weather/widgets/app_bar_widget.dart';

class ManageLocations extends StatelessWidget {
  ManageLocations({super.key}) {
    LocationController locationController = LocationController();
    Get.put(locationController);
    locationController.getLocationsForcast();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocationController>(builder: (locationController) {
      return Scaffold(
        backgroundColor: Colors.black54,
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppBarWidget(
                title: 'Manage locations',
                showActionList: true,
                actionList: [
                  IconButton(
                    onPressed: () {
                      Get.toNamed(Routes.addLocationScreen);
                    },
                    icon: Icon(
                      Icons.add_location_alt_outlined,
                      size: 16.h,
                    ),
                  ),
                ],
              ),
              16.verticalSpace,
              Expanded(
                child: ListView.builder(
                  itemCount:
                      locationController.locationsWeatherForcast?.length ?? 0,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: LocationWeatherWidget(
                        locationName: "Kabul",
                        locationCity: "Kabul",
                        locationCounty: "Afghanistan",
                        currentConditionIcon: "assets/weather/day/113.png",
                        degree: "31",
                        maxDegree: "31",
                        minDegree: "20",
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}

class LocationWeatherWidget extends StatelessWidget {
  final String locationName;
  final String locationCity;
  final String locationCounty;
  final String currentConditionIcon;
  final String degree;
  final String maxDegree;
  final String minDegree;

  LocationWeatherWidget({
    Key? key,
    required this.locationName,
    required this.locationCity,
    required this.locationCounty,
    required this.currentConditionIcon,
    required this.degree,
    required this.maxDegree,
    required this.minDegree,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.r),
      decoration: BoxDecoration(
        color: Colors.white54,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.fmd_good_sharp,
                      size: 16.h,
                    ),
                    8.horizontalSpace,
                    Text(
                      locationName,
                      style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    )
                  ],
                ),
                4.verticalSpace,
                Text(
                  "$locationCity , $locationCounty",
                  style: TextStyle(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.normal,
                    color: Colors.white70,
                  ),
                ),
                Text(
                  AppConfig.instance.dateFormat(DateTime.now()),
                  style: TextStyle(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.normal,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  children: [
                    Image.asset(
                      currentConditionIcon,
                      scale: 1.6,
                    ),
                    4.horizontalSpace,
                    Text(
                      degree,
                      style: TextStyle(
                        fontSize: 24.sp,
                        color: Colors.white,
                      ),
                    ),
                    Transform.translate(
                      offset: const Offset(1, -5),
                      child: Container(
                        height: 5.h,
                        width: 5.h,
                        decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.white),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Container(),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Text(
                          maxDegree,
                          style: TextStyle(color: Colors.white70),
                        ),
                        Transform.translate(
                          offset: const Offset(1, -5),
                          child: Container(
                            height: 3.h,
                            width: 3.h,
                            decoration: BoxDecoration(
                              border:
                                  Border.all(width: 1, color: Colors.white54),
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: Container(),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      " / ",
                      style: TextStyle(color: Colors.white),
                    ),
                    Row(
                      children: [
                        Text(
                          minDegree,
                          style: TextStyle(color: Colors.white70),
                        ),
                        Transform.translate(
                          offset: const Offset(1, -5),
                          child: Container(
                            height: 3.h,
                            width: 3.h,
                            decoration: BoxDecoration(
                              border:
                                  Border.all(width: 1, color: Colors.white54),
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: Container(),
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
