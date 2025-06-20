import 'package:flutter/material.dart';
import 'package:go_weather/config/app_config.dart';

class LoadingOverlay extends StatelessWidget {
  final Widget child;
  final bool isLoading;

  const LoadingOverlay({
    super.key,
    required this.isLoading,
    required this.child,
  });
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AbsorbPointer(
          absorbing: isLoading,
          child: child,
        ),
        if (isLoading)
          Center(
            child: CircularProgressIndicator(
              valueColor:
                  AlwaysStoppedAnimation<Color>(AppConfig.instance.kGreenColor),
            ),
          ),
      ],
    );
  }
}
