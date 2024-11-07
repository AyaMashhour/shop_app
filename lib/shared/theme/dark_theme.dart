import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../colors.dart';

ThemeData darkTheme = ThemeData(
 // primarySwatch: defaultColor,
  scaffoldBackgroundColor:Color('333739' as int),
  appBarTheme: AppBarTheme(
    titleSpacing: 20.0,

    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Color('333739' as int),
      statusBarIconBrightness: Brightness.light,
    ),
    backgroundColor:Color('333739' as int),
    elevation: 0.0,
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
    ),
    iconTheme: IconThemeData(
      color: Colors.white,
    ),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: defaultColor,
    unselectedItemColor: Colors.grey,
    elevation: 20.0,
    backgroundColor: Color('333739' as int),
  ),
  textTheme: TextTheme(
    bodyMedium: TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
  ),
  fontFamily: 'hana',
);
