import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_weather/controllers/home_controller.dart';
import 'package:lottie/lottie.dart';

class HeadingWidget extends StatelessWidget {
  final HomeController? xController;
  Function() menuButtonCallback;

  HeadingWidget(
      {super.key, this.xController, required this.menuButtonCallback});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      double height = constraints.maxHeight;
      final currentCondition = xController?.weatherForecast?.current;
      final isDay = ((currentCondition?.isDay ?? 0) == 1) ? "day" : "night";
      return SizedBox(
        height: height,
        child: Opacity(
          opacity: ((height - 200) / 200).clamp(0.0, 1.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              40.verticalSpace,
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  16.verticalSpace,
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
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
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            xController?.weatherForecast?.current?.condition !=
                                    null
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
                              xController?.weatherForecast?.current?.condition
                                      ?.text ??
                                  "",
                              style: TextStyle(
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            Spacer(),
                            Lottie.asset(
                              'assets/lottie/${getImageLottieName(currentCondition?.condition?.text ?? "", isDay)}.json',
                              reverse: true,
                              width: 100.w,
                              height: 120.h,
                              fit: BoxFit.contain,
                            ),
                          ],
                        ),
                        16.verticalSpace,
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.center,
                        //   spacing: 16.w,
                        //   children: [
                        //     IconButton(
                        //         onPressed: () {
                        //           xController?.getCurrentWeather();
                        //         },
                        //         icon: Icon(Icons.refresh_rounded))
                        //   ],
                        // ),
                        // 16.verticalSpace,
                        // Text(
                        //   xController?.getDateFormated(xController
                        //               ?.weatherForecast?.location?.localtime
                        //               .toString() ??
                        //           DateTime.now().toString()) ??
                        //       "",
                        //   style: TextStyle(
                        //     fontSize: 10.sp,
                        //     color: Colors.white70,
                        //     fontWeight: FontWeight.bold,
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    });
  }

  String getImageLottieName(String text, String isDay) {
    var namelist = text.toLowerCase().replaceAll(' ', '-');
    final path = namelist;
    return '$path-$isDay';
  }
}
