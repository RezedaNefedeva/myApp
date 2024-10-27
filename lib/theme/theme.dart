import 'package:flutter/material.dart';

final theme = ThemeData(
  textTheme: const TextTheme(
    displayLarge: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w900,
      color: Colors.white
    ),
    displayMedium: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w900,
        color: Colors.white
    ),
    displaySmall: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w900,
        color: Colors.white
    ),
    bodyLarge: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w500,
        color: Colors.black
    ),
      bodyMedium: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w500,
          color: Colors.black
      ),
      bodySmall: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: Colors.black
      ),
  )
);