import 'dart:io';

import 'package:nada_dco/utilities/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

int language = 0;

class Constant {
  static var deviceType = Platform.isAndroid ? 'android' : 'ios';
  static const double paddingBottom = 25;
  static const TextStyle buttomSheetTextStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: Color(0xffA6A4A4),
  );

  static const TextStyle appBarCenterTitleStyle = TextStyle(
    fontSize: 19,
    color: Colors.black,
    fontWeight: FontWeight.w600,
  );
  static const TextStyle textFilledStyle = TextStyle(
      color: AppColor.texfilledColor,
      fontSize: 15,
      fontWeight: FontWeight.w500);
  static const TextStyle homeTextStyle =
      TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 16);

  static const SystemUiOverlayStyle systemUiOverlayStyle =
      SystemUiOverlayStyle(statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark, 

);
}

class SuccessClass {
  @required
  final String screenName;
  final String title;
  final String message;

  SuccessClass(
      {required this.screenName, required this.title, required this.message});
}

enum MenuState { notification, home, profile }
