import 'package:flutter/material.dart';

// A utility class to hold and manage screen size information.
class SizeConfig {
  static MediaQueryData _mediaQueryData = const MediaQueryData();
  static double screenWidth = 0;
  static double screenHeight = 0;

  // Method to initialize the SizeConfig with the current context.
  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
  }
}

// Function to get the proportionate height as per screen size.
double getProportionateScreenHeight(double inputHeight) {
  double screenHeight = SizeConfig.screenHeight;
  // 932 is the layout height of iPhone 15 Pro Max used for development.
  return (inputHeight / 932.0) * screenHeight;
}

// Function to get the proportionate width as per screen size.
double getProportionateScreenWidth(double inputWidth) {
  double screenWidth = SizeConfig.screenWidth;
  // 430 is the layout width of iPhone 15 Pro Max used for development.
  return (inputWidth / 430.0) * screenWidth;
}
