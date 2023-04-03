import 'package:beneficiary_app/presentation/resources/color_manager.dart';
import 'package:beneficiary_app/presentation/resources/font_manager.dart';
import 'package:beneficiary_app/presentation/resources/styles_manager.dart';
import 'package:beneficiary_app/presentation/resources/values_manager.dart';
import 'package:beneficiary_app/presentation/widgets/responsive.dart';
import 'package:flutter/material.dart';

ThemeData getApplicationTheme(BuildContext context) {
  return ThemeData(
    //main colors of the app
    scaffoldBackgroundColor: ColorManager.background,
    accentColor: ColorManager.primary,
    primaryColor: ColorManager.primary,
    primaryColorLight: ColorManager.primaryOpacity70,
    primaryColorDark: ColorManager.dakPrimary,
    disabledColor: ColorManager
        .grey1, // will be used incase of disabled button for example
    splashColor: ColorManager.primaryOpacity70,
    cardTheme: CardTheme(
      color: ColorManager.white,
      shadowColor: ColorManager.grey,
      elevation: AppSize.s4,
    ),
    // card view theme
    appBarTheme: AppBarTheme(
      centerTitle: true,
      color: ColorManager.primary,
      elevation: AppSize.s4,
      titleTextStyle: getRegularStyle(
        color: ColorManager.white,
        fontSize: FontSize.s16,
      ),
    ),
    //App bar theme

    //Button theme
    buttonTheme: ButtonThemeData(
      shape: const StadiumBorder(),
      disabledColor: ColorManager.grey1,
      buttonColor: ColorManager.primary,
      splashColor: ColorManager.primaryOpacity70,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        textStyle: getRegularStyle(color: ColorManager.white),
        primary: ColorManager.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.s5),
        ),
      ),
    ),
    //Text theme
    textTheme: TextTheme(
      headline1: getSemiBoldStyle(
        color: ColorManager.darkGrey,
        fontSize: ResponsiveWidget.isLargeScreen(context)
            ? FontSize.s8
            : FontSize.s16,
      ),
      headline2: getBoldStyle(
        color: ColorManager.black,
        fontSize: ResponsiveWidget.isLargeScreen(context)
            ? FontSize.s8
            : FontSize.s14,
      ),
      headline4: getBoldStyle(
        color: ColorManager.darkGrey,
        fontSize: ResponsiveWidget.isLargeScreen(context)
            ? FontSize.s8
            : FontSize.s14,
      ),
      headline3: getRegularStyle(
        color: ColorManager.darkGrey,
        fontSize: ResponsiveWidget.isLargeScreen(context)
            ? FontSize.s8
            : FontSize.s14,
      ),
      labelMedium: getMediumStyle(
        color: ColorManager.white,
        fontSize: ResponsiveWidget.isLargeScreen(context)
            ? FontSize.s6
            : FontSize.s14,
      ),
      subtitle1: getMediumStyle(
        color: ColorManager.black,
        fontSize: ResponsiveWidget.isLargeScreen(context)
            ? FontSize.s8
            : FontSize.s14,
      ),
      subtitle2: getMediumStyle(
        color: ColorManager.primary,
        fontSize: ResponsiveWidget.isLargeScreen(context)
            ? FontSize.s8
            : FontSize.s14,
      ),
      caption: getRegularStyle(
        color: ColorManager.grey1,
        fontSize: ResponsiveWidget.isLargeScreen(context)
            ? FontSize.s8
            : FontSize.s12,
      ),
      bodyText1: getRegularStyle(
        color: ColorManager.black,
        fontSize: ResponsiveWidget.isLargeScreen(context)
            ? FontSize.s8
            : FontSize.s12,
      ),
      bodyText2: getMediumStyle(
        color: ColorManager.lightGrey,
        fontSize: ResponsiveWidget.isLargeScreen(context)
            ? FontSize.s8
            : FontSize.s12,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(
        AppPadding.p8,
      ),
      hintStyle: getRegularStyle(color: ColorManager.grey1),
      labelStyle: getMediumStyle(color: ColorManager.darkGrey),
      errorStyle: getRegularStyle(color: ColorManager.error),
      // focused error border
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorManager.primary,
          width: AppSize.s1_5,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(AppSize.s8),
        ),
      ),
      //error border
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorManager.error,
          width: AppSize.s1_5,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(AppSize.s8),
        ),
      ),
      //focused error border
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorManager.primary,
          width: AppSize.s1_5,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(AppSize.s8),
        ),
      ),
      // enabled border
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorManager.grey,
          width: AppSize.s1_5,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(AppSize.s8),
        ),
      ),
    ),

    //input decoration theme (text form field)
  );
}
