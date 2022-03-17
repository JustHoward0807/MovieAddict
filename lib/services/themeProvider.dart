// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:movieaddict/styles/color.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.dark;

  bool get isDarkMode => themeMode == ThemeMode.dark;

  void toggleTheme(bool isOn) {
    themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}

class CustomThemes {
  static final darkTheme = ThemeData(
    scaffoldBackgroundColor: mainDarkColor, //screen bg color
    appBarTheme: const AppBarTheme(color: actionBarColor), //appbar theme
    secondaryHeaderColor: actionBarColor, // same as appbar color
    primaryColor: const Color(0xff2f89fc), // Btn Color ..
    splashColor: actionBarColor, // second color
    colorScheme: const ColorScheme.dark(),
    focusColor: const Color(0xffF9F9F9),
    errorColor: const Color(0xffF5F5F5), //icon color
    hintColor: const Color(0xff9B9B9B), //show all color
    hoverColor: Colors.yellow, //rating bar color
    cardColor: const Color(0xff9B9B9B), //Nav bar btn color
    scrollbarTheme: ScrollbarThemeData(
        trackColor: MaterialStateProperty.all(const Color(0xffFCA311)),
        thumbColor: MaterialStateProperty.all(const Color(0xff2f89fc))),
  );
  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: const Color(0xffFFFFFF), //screen bg color
    appBarTheme: const AppBarTheme(color: Color(0xffE5E5E5)), //appbar theme,
    secondaryHeaderColor: const Color(0xffE5E5E5), // same as appbar color
    primaryColor: const Color(0xffFCA311), // Btn Color ..
    splashColor: const Color(0xff14213D), // second color
    colorScheme: const ColorScheme.light(),
    focusColor: const Color(0xff000000), //appbar text color
    errorColor: const Color(0xffF5F5F5), //icon color
    hintColor: const Color(0xff9B9B9B), //show all color
    hoverColor: Colors.blue, //rating bar color
    cardColor: Colors.white, //Nav bar btn color
    scrollbarTheme: ScrollbarThemeData(
        trackColor: MaterialStateProperty.all(const Color(0xff2f89fc)),
        thumbColor: MaterialStateProperty.all(const Color(0xffFCA311))),
  );
}
