import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:go_weather/config/app_config.dart';
import 'package:go_weather/controllers/location_controller.dart';
import 'package:go_weather/data/models/locations_autocomplete_model.dart';
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
                        width: 0.9.sw,
                        child: Autocomplete<LocationsAutoCompletModel>(
                            optionsBuilder:
                                (TextEditingValue textEditingValue) {
                              return xController.locationsAutoCompleteList;
                            },
                            displayStringForOption:
                                (LocationsAutoCompletModel option) =>
                                    "${option.name} (${option.country})",
                            fieldViewBuilder: (BuildContext context,
                                TextEditingController
                                    fieldTextEditingController,
                                FocusNode fieldFocusNode,
                                VoidCallback onFieldSubmitted) {
                              return TextField(
                                controller: fieldTextEditingController,
                                focusNode: fieldFocusNode,
                                onChanged: (value) {
                                  xController.searchLocation(value);
                                },
                                decoration: InputDecoration(
                                    isDense: true,
                                    border: InputBorder.none,
                                    prefixIcon: const Icon(
                                      Icons.search_rounded,
                                    ),
                                    contentPadding:
                                        EdgeInsets.symmetric(vertical: 16.h),
                                    hintText: "Search Location",
                                    hintStyle: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 12.sp)),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12.sp),
                              );
                            },
                            onSelected: (LocationsAutoCompletModel selection) {
                              addtoLocationList(selection);
                            },
                            optionsViewBuilder: (BuildContext context,
                                AutocompleteOnSelected<
                                        LocationsAutoCompletModel>
                                    onSelected,
                                Iterable<LocationsAutoCompletModel>? options) {
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  8.verticalSpace,
                                  Material(
                                    child: Align(
                                      alignment: AlignmentDirectional.topStart,
                                      child: Container(
                                        width: 0.9.sw,
                                        decoration: BoxDecoration(
                                          color: Colors.black54,
                                          border:
                                              Border.all(color: Colors.white70),
                                          borderRadius:
                                              BorderRadius.circular(8.r),
                                        ),
                                        child: ListView.builder(
                                          shrinkWrap: true,
                                          padding: EdgeInsets.zero,
                                          itemCount: options?.length ?? 0,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return GestureDetector(
                                              onTap: () {
                                                onSelected(
                                                    options!.elementAt(index));
                                              },
                                              child: ListTile(
                                                title: Text(
                                                  "${options?.elementAt(index).name} (${options?.elementAt(index).country})",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16.sp),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            }),
                      ),
                    )
                  ],
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: AppConfig.instance.listofLocations?.length ?? 0,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: LocationsWidget(
                          location:
                              AppConfig.instance.listofLocations!.elementAt(index),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  addtoLocationList(LocationsAutoCompletModel location) {
    if (AppConfig.instance.listofLocations != null) {
      if (AppConfig.instance
          .listofLocations!
          .any((element) => element.id == location.id)) {
        return;
      } else {
        AppConfig.instance.listofLocations?.add(location);
        AppConfig.instance.addStorageEntry(
            AppConfig.instance.locationsKeyStorage, AppConfig.instance.listofLocations);
      }
    } else {
      AppConfig.instance.listofLocations = [];
      AppConfig.instance.listofLocations?.add(location);
      AppConfig.instance.addStorageEntry(
          AppConfig.instance.locationsKeyStorage, AppConfig.instance.listofLocations);
    }
    Get.back();
  }
}

class LocationsWidget extends StatelessWidget {
  final LocationsAutoCompletModel location;
  const LocationsWidget({
    Key? key,
    required this.location,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: Colors.white54,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${location.name}",
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "${location.country}",
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
