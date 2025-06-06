import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ForecastWidget extends StatelessWidget {
  final String dayicon;
  final String day;
  final String max;
  final String nighticon;
  final String min;

  const ForecastWidget({
    super.key,
    required this.dayicon,
    required this.max,
    required this.day,
    required this.nighticon,
    required this.min,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 140.h,
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
                const Divider(
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
