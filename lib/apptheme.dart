import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    primaryColor: Color.fromRGBO(4, 121, 119, 1), // Change to your custom color
    scaffoldBackgroundColor: Colors.white,
    colorScheme: ColorScheme.light(
      primary: Color.fromRGBO(41, 81, 44, 1),
      secondary: Colors.black,
    ),
    
    appBarTheme: AppBarTheme(
      backgroundColor: Color.fromRGBO(4, 121, 119, 1),
      foregroundColor: Colors.white,
      elevation: 0,
    ),
    textTheme: TextTheme(
      bodyLarge: TextStyle(color: Colors.black),
      bodyMedium: TextStyle(color: Colors.black87),
    ),
  );

  
}
