import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
