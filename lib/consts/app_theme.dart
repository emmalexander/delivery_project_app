import 'package:delivery_project_app/consts/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum AppTheme { lightTheme, darkTheme }

class AppThemes {
  static final appThemeData = {
    AppTheme.lightTheme: ThemeData(
        tabBarTheme: TabBarTheme(
          labelStyle: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600),
          labelColor: Colors.black,
          labelPadding: EdgeInsets.symmetric(vertical: 10.h),
          indicatorColor: AppColors.mainColor,
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: AppColors.scaffoldBackgroundColor,
        ),
        useMaterial3: true,
        scaffoldBackgroundColor: AppColors.scaffoldBackgroundColor,
        fontFamily: 'SF-Pro-Rounded',
        primarySwatch: AppColors.mainColor,
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: AppColors.mainColor,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.mainColor,
          foregroundColor: Colors.white,
        )),
        inputDecorationTheme: InputDecorationTheme(
          enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black45)),
          activeIndicatorBorder: const BorderSide(color: Colors.black45),
          labelStyle: const TextStyle(color: Colors.black45),
          focusColor: AppColors.color,
          contentPadding: const EdgeInsets.symmetric(horizontal: 10),
        ),
        textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(22),
                ),
                backgroundColor: AppColors.color,
                foregroundColor: Colors.black)),
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Colors.blueAccent,
          selectionColor: Colors.blueAccent,
          selectionHandleColor: Colors.blueAccent,
        )),
    //
    AppTheme.darkTheme: ThemeData(
        tabBarTheme: TabBarTheme(
          labelStyle: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600),
          labelColor: Colors.black,
          labelPadding: EdgeInsets.symmetric(vertical: 10.h),
          indicatorColor: AppColors.mainColor,
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: AppColors.scaffoldBackgroundColorDark,
        ),
        useMaterial3: true,
        scaffoldBackgroundColor: AppColors.scaffoldBackgroundColorDark,
        fontFamily: 'SF-Pro-Rounded',
        primarySwatch: AppColors.mainColor,
        cardColor: Colors.white12,
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: AppColors.mainColor,
          brightness: Brightness.dark,
          cardColor: Colors.white12,
          backgroundColor: Colors.black,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.mainColor,
          foregroundColor: Colors.white,
        )),
        inputDecorationTheme: InputDecorationTheme(
          enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white)),
          activeIndicatorBorder: const BorderSide(color: Colors.white),
          labelStyle: const TextStyle(
            color: Colors.white,
          ),
          focusColor: AppColors.color,
          contentPadding: const EdgeInsets.symmetric(horizontal: 10),
        ),
        textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(22),
                ),
                backgroundColor: AppColors.mainColor,
                foregroundColor: Colors.white)),
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Colors.blueAccent,
          selectionColor: Colors.blueAccent,
          selectionHandleColor: Colors.blueAccent,
        )),
  };
}
