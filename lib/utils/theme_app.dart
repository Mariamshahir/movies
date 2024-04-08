import 'package:flutter/material.dart';
import 'package:test_movies/utils/colors_app.dart';

abstract class AppTheme {
  static const TextStyle title = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    color: AppColors.white,
  );
  static const TextStyle tagline = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w400,
    color: AppColors.white,
  );
  static const TextStyle movieTitle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    color: AppColors.white,
  );
  static const TextStyle titleName = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w400,
    color: AppColors.white,
  );
  static const TextStyle watchList = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w400,
    color: AppColors.white,
  );
  static const TextStyle time = TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w400,
    color: AppColors.gray,
  );

  static ThemeData lightTheme = ThemeData(
      primaryColor: Colors.black,
      appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
          centerTitle: true,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30)))),
      textTheme: const TextTheme(
        titleLarge: TextStyle(
            fontSize: 15, fontWeight: FontWeight.w400, color: AppColors.white),
        titleMedium: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.normal,
            color: AppColors.white),
        titleSmall: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w400,
            color: AppColors.gray),
      ));
}
