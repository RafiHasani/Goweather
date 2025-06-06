import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SvgimageWidget extends StatelessWidget {
  const SvgimageWidget({
    super.key,
    required this.icon,
    this.height = 32,
    this.width = 32,
  });

  final String icon;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      icon,
      height: height,
      width: width,
      // colorFilter: const ColorFilter.mode(Colors.red, BlendMode.srcIn),
    );
  }
}
