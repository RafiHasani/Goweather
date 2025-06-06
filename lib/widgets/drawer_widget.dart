import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:go_weather/config/router.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({
    super.key,
    required this.navigationDrawarkey,
  });

  final GlobalKey<ScaffoldState> navigationDrawarkey;

  @override
  Widget build(BuildContext context) {
    return Drawer(
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
        margin: EdgeInsetsDirectional.only(top: 60.h, bottom: 0.h, end: 30.w),
        child: ListView(
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
    );
  }
}
