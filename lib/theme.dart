import 'package:flutter/material.dart';

ThemeData get darkTheme {
  return ThemeData(
    appBarTheme: AppBarTheme(
      titleTextStyle: TextStyle(fontSize: 17.0),
      backgroundColor: const Color(0xff2196f3),
      foregroundColor: Colors.black,
      centerTitle: true,
      elevation: 10.0,
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: Color(0xffe040fb),
      disabledColor: Color(0xff757575),
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Color(0xffffffff), fontSize: 16.0),
      bodyMedium: TextStyle(color: Color(0xffffffff), fontSize: 12.0),
      bodySmall: TextStyle(color: Color(0xffffffff), fontSize: 10.0),
    ),
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xff2196f3),
      primary: const Color(0xff2196f3),
      primaryContainer: const Color(0xff212121),
      surface: const Color(0xff212121)
    ),
    iconTheme: IconThemeData(color: Colors.white, weight: 400, size: 32.0),
    disabledColor: const Color(0xff757575),
    dividerColor: const Color(0xffbdbdbd),
    primaryColor: const Color(0xff2196f3),
    primaryColorDark: const Color(0xff1976d2),
    primaryColorLight: const Color(0xffbbdefb),
    splashColor: Color(0xffe040fb),
    useMaterial3: true,
  );
}

// https://www.materialpalette.com/indigo/deep-purple
ThemeData get lightTheme {
  return ThemeData(
    appBarTheme: AppBarTheme(
      titleTextStyle: TextStyle(fontSize: 17.0),
      backgroundColor: const Color(0xff303f9f),
      foregroundColor: Colors.white,
      centerTitle: true,
      elevation: 10.0,
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: Color(0xff7c4dff),
      disabledColor: Color(0xff757575),
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Color(0xff212121), fontSize: 16.0),
      bodyMedium: TextStyle(color: Color(0xff212121), fontSize: 12.0),
      bodySmall: TextStyle(color: Color(0xff212121), fontSize: 10.0),
    ),
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xff3f51b5),
      primary: const Color(0xff3f51b5),
      primaryContainer: const Color(0xffffffff),
      surface: const Color(0xffffffff)
    ),
    iconTheme: IconThemeData(color: Colors.white, weight: 400, size: 32.0),
    disabledColor: const Color(0xff757575),
    dividerColor: const Color(0xffbdbdbd),
    primaryColor: const Color(0xff3f51b5),
    primaryColorDark: const Color(0xff303f9f),
    primaryColorLight: const Color(0xffc5cae9),
    splashColor: Color(0xff7c4dff),
    useMaterial3: true,
  );
}

// Fixed colors for personalizing habits.
//  TODO  add and associate colors with labels such as "high priority" or "daily".
const habitColors = [
  const Color(0xff512da8),
  const Color(0xffffa000),
  const Color(0xffd32f2f),
  const Color(0xff388e3c),
  const Color(0xffe64a19),
  const Color(0xffc2185b),
];

const titleStyle = TextStyle(
  color: Color(0xff212121),
  fontWeight: FontWeight.w600,
  fontSize: 18.0,
);

const subtitleStyle = TextStyle(
  color: Color(0xff757575),
  fontWeight: FontWeight.w400,
  fontSize: 12.0,
);

class AppSizes {
  static EdgeInsets screenPadding = EdgeInsets.symmetric(
    vertical: 24.0,
    horizontal: 24.0,
  );
}
