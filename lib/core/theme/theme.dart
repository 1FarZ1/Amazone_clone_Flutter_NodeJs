import 'package:amazon_clone/core/constant/constants.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData customTheme = ThemeData(
    scaffoldBackgroundColor: AppConsts.backgroundColor,
    colorScheme: const ColorScheme.dark(
      primary: AppConsts.secondaryColor,
    ),
    appBarTheme: const AppBarTheme(
      elevation: 0,
      iconTheme: IconThemeData(
        color: Colors.black,
      ),
    ),
    useMaterial3: true, // can remove this line
  );
}
