import 'package:easy_autocomplete/easy_autocomplete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:go_weather/controllers/location_controller.dart';
import 'package:go_weather/widgets/app_bar_widget.dart';
import 'package:go_weather/widgets/overlay_widget.dart';

class AddLocation extends StatelessWidget {
  const AddLocation({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocationController>(builder: (xController) {
      return LoadingOverlay(
        isLoading: xController.isLoading,
        child: Scaffold(
          backgroundColor: Colors.black,
          body: SafeArea(
            child: Column(
              children: [
                const AppBarWidget(
                  title: 'Add location',
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white70),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        alignment: Alignment.center,
                        child: EasyAutocomplete(
                          suggestions: xController.locationsAutoCompleteList
                              .map((e) => e.url.toString())
                              .toList(),
                          onChanged: (value) {},
                          onSubmitted: (value) {
                            xController.searchLocation(value);
                          },
                          inputTextStyle: const TextStyle(
                            color: Colors.white,
                          ),
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Search city,zip/postal code",
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 16.w)),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
