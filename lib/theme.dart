import 'package:flutter/material.dart';

IconThemeData iconTheme = IconThemeData(color: Colors.black);

ThemeData appTheme = ThemeData(
    backgroundColor: Colors.white,
    primaryColor: Colors.green,
    accentColor: Colors.green[800],
    // textTheme: Typography.blackCupertino,
    iconTheme: iconTheme,
    bottomNavigationBarTheme:
        BottomNavigationBarThemeData(selectedItemColor: Colors.green),
    textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all(Colors.green))));
