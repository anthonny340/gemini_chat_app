import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const seedColor = Color(0xFF1E1C36);

class AppTheme {
  final bool isDarkMode;

  AppTheme({required this.isDarkMode});

  ThemeData getTheme() {
    final brightness = isDarkMode ? Brightness.dark : Brightness.light;

    final backgroundColor =
        isDarkMode ? const Color(0xFF121212) : const Color(0xFFFDFDFD);

    final textColor = isDarkMode ? Colors.white : const Color(0xFF1E1C36);
    final iconColor = isDarkMode ? Colors.white : const Color(0xFF1E1C36);

    final colorScheme = ColorScheme.fromSeed(
      seedColor: seedColor,
      brightness: brightness,
    ).copyWith(
      surface: backgroundColor,
      onSurface: textColor,
      primary: seedColor,
      onPrimary: Colors.white,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: backgroundColor,
      appBarTheme: const AppBarTheme(
        backgroundColor: seedColor,
        foregroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.white),
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
      iconTheme: IconThemeData(
        color: iconColor,
      ),
      listTileTheme: ListTileThemeData(
        iconColor: iconColor,
        textColor: textColor,
        titleTextStyle: TextStyle(
          color: textColor,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        subtitleTextStyle: TextStyle(
          color: isDarkMode ? Colors.white70 : Colors.black54,
          fontSize: 14,
        ),
      ),
      textTheme: ThemeData(brightness: brightness).textTheme.apply(
            bodyColor: textColor,
            displayColor: textColor,
          ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: backgroundColor,
        selectedItemColor: isDarkMode ? Colors.white : seedColor,
        unselectedItemColor: isDarkMode ? Colors.white60 : Colors.black54,
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: seedColor,
        foregroundColor: Colors.white,
      ),
    );
  }

  static void setSystemUIOverlayStyle({required bool isDarkMode}) {
    final iconBrightness = isDarkMode ? Brightness.light : Brightness.dark;

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor:
            isDarkMode ? const Color(0xFF121212) : const Color(0xFFFDFDFD),
        statusBarIconBrightness: iconBrightness,
        systemNavigationBarIconBrightness: iconBrightness,
        statusBarBrightness: isDarkMode ? Brightness.dark : Brightness.light,
      ),
    );
  }
}
