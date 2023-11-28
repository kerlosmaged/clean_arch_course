import 'package:app/presentation/resource/color_manager.dart';
import 'package:app/presentation/resource/font_manager.dart';
import 'package:app/presentation/resource/styles_manager.dart';
import 'package:app/presentation/resource/values_manager.dart';
import 'package:flutter/material.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
    // main color
    primaryColor: ColorManager.primaryColor,
    primaryColorLight: ColorManager.lightPrimary,
    primaryColorDark: ColorManager.darkPrimary,
    disabledColor: ColorManager.gray1,
    splashColor: ColorManager.lightPrimary,
    //card theme
    cardTheme: CardTheme(
      color: ColorManager.white,
      shadowColor: ColorManager.grey,
      elevation: AppSizeManager.s4,
    ),
    // app bar theme
    appBarTheme: AppBarTheme(
      centerTitle: true,
      color: ColorManager.primaryColor,
      elevation: AppSizeManager.s4,
      shadowColor: ColorManager.lightPrimary,
      titleTextStyle: regularTextStyle(
        fontSize: FontSizeManager.s16,
        color: ColorManager.white,
      ),
    ),
    // button theme
    buttonTheme: ButtonThemeData(
      shape: const StadiumBorder(),
      disabledColor: ColorManager.gray1,
      buttonColor: ColorManager.primaryColor,
      splashColor: ColorManager.lightPrimary,
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: ColorManager.primaryColor,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: ColorManager.primaryColor,
        textStyle: regularTextStyle(
          color: Colors.white,
          fontSize: FontSizeManager.s17,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusDirectional.circular(AppSizeManager.s12),
        ),
      ),
    ),
    // text theme
    textTheme: TextTheme(
      displayLarge: boldTextStyle(
          fontSize: FontSizeManager.s22, color: ColorManager.white),
      displayMedium: mediumTextStyle(
          fontSize: FontSizeManager.s18, color: ColorManager.white),
      displaySmall: regularTextStyle(
          fontSize: FontSizeManager.s16, color: ColorManager.white),
      bodyLarge: semiBoldTextStyle(
          fontSize: FontSizeManager.s20, color: ColorManager.darkGrey),
      bodyMedium: regularTextStyle(
          fontSize: FontSizeManager.s16, color: ColorManager.darkGrey),
      bodySmall: boldTextStyle(
        fontSize: FontSizeManager.s20,
        color: ColorManager.primaryColor,
      ),
      headlineLarge: regularTextStyle(
          fontSize: FontSizeManager.s18, color: ColorManager.primaryColor),
      headlineMedium: boldTextStyle(
          fontSize: FontSizeManager.s16, color: ColorManager.primaryColor),
      headlineSmall: boldTextStyle(
          color: ColorManager.darkGrey, fontSize: FontSizeManager.s16),
    ),
    //decoration theme
    inputDecorationTheme: InputDecorationTheme(
      // content padding
      contentPadding: const EdgeInsets.all(AppPaddingManager.p8),
      // hint text style
      hintStyle: regularTextStyle(
          fontSize: FontSizeManager.s14, color: ColorManager.grey),
      // label text style
      labelStyle: mediumTextStyle(
          fontSize: FontSizeManager.s14, color: ColorManager.grey),
      // error text style
      errorStyle: regularTextStyle(
          fontSize: FontSizeManager.s12, color: ColorManager.error),
      // enabled Border Style
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSizeManager.s8),
        borderSide: BorderSide(
          color: ColorManager.grey,
          width: AppSizeManager.s1_5,
        ),
      ),
      //foucesed Border style
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSizeManager.s8),
        borderSide: BorderSide(
          color: ColorManager.primaryColor,
          width: AppSizeManager.s1_5,
        ),
      ),
      // error border style
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSizeManager.s8),
        borderSide: BorderSide(
          color: ColorManager.error,
          width: AppSizeManager.s1_5,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSizeManager.s8),
        borderSide: BorderSide(
          color: ColorManager.primaryColor,
          width: AppSizeManager.s1_5,
        ),
      ),
    ),
  );
}
