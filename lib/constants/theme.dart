import 'package:flutter/material.dart';

ThemeData theme() {
  return ThemeData(
    primaryColor: Colors.white,
    scaffoldBackgroundColor: Color.fromARGB(64, 29, 29, 29),
    backgroundColor: Color(0xFFF4F4F4),
    fontFamily: 'Optima',
    textTheme: const TextTheme(
      headline1: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 36,
      ),
      headline2: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 24,
      ),
      headline3: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 18,
      ),
      headline4: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),
      headline5: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 14,
      ),
      headline6: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.normal,
        fontSize: 14,
      ),
      bodyText1: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.normal,
        fontSize: 12,
      ),
      bodyText2: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.normal,
        fontSize: 10,
      ),
    ),
    colorScheme: ColorScheme.fromSwatch()
        .copyWith(secondary: Color.fromARGB(255, 180, 69, 232)),
  );
}
