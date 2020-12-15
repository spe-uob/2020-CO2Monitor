import 'package:flutter/material.dart';

IconThemeData iconTheme = IconThemeData(color: Colors.black);

ThemeData appTheme = ThemeData(
    primaryColor: Colors.white,
    accentColor: Colors.green,
    textTheme: Typography.blackCupertino,
    iconTheme: iconTheme,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedItemColor: Colors.green, unselectedIconTheme: iconTheme));
