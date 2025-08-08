import 'package:english_mate/generated/fonts.gen.dart';
import 'package:flutter/material.dart';

class AppThemes {
  AppThemes._();

  static const _lightColorScheme = ColorScheme(
    brightness: Brightness.light,
    // màu nền chính
    primary: Colors.white,
    // màu phụ (màu mờ)
    secondary: Color.fromARGB(255, 120, 120, 120),
    onSecondary: Colors.white,
    // màu nền (card, btn, border)
    surface: Color.fromARGB(255, 0, 169, 157),
    // màu chữ trên nền primary
    onPrimary: Colors.black,
    // màu chữ trên nền surface
    onSurface: Colors.white,
    // màu lỗi
    error: Colors.red,
    // màu chữ trên nền error
    onError: Colors.white,
    // màu hightlight, màu của tùy chọn
    tertiary: Color.fromARGB(255, 0, 169, 157),
    onTertiary: Colors.white,

    //màu của phần flash card
    //màu đã biết
    primaryContainer: Colors.orange,
    //màu chưa biết
    secondaryContainer: Colors.green,
  );
  static ThemeData lightTheme = ThemeData(
    fontFamily: FontFamily.sFProDisplay,
    colorScheme: _lightColorScheme,
    scaffoldBackgroundColor: _lightColorScheme.primary,
    textTheme: TextTheme(
      bodySmall: TextStyle(fontSize: 14, color: _lightColorScheme.onPrimary),
      bodyMedium: TextStyle(fontSize: 18, color: _lightColorScheme.onPrimary),
      bodyLarge: TextStyle(fontSize: 22, color: _lightColorScheme.onPrimary),
      titleLarge: TextStyle(
        fontSize: 22,
        color: _lightColorScheme.onPrimary,
        fontWeight: FontWeight.bold,
      ),
      // chữ cho các cái nhãn bị mờ "privacy", ...
      labelSmall: TextStyle(
        fontSize: 14,
        color: _lightColorScheme.onPrimary,
        fontWeight: FontWeight.bold,
      ),
      labelMedium: TextStyle(
        fontSize: 18,
        color: _lightColorScheme.onPrimary,
        fontWeight: FontWeight.bold,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: _lightColorScheme.surface,
        textStyle: TextStyle(
          fontSize: 16,
          color: _lightColorScheme.onSurface,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: _lightColorScheme.onPrimary,
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        splashFactory: NoSplash.splashFactory,
        overlayColor: Colors.transparent,
      ),
    ),
    textSelectionTheme: TextSelectionThemeData(
      // màu của thanh cursor
      cursorColor: _lightColorScheme.onPrimary,
    ),
    inputDecorationTheme: InputDecorationTheme(
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide(color: _lightColorScheme.onPrimary, width: 1),
      ),

      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide(color: _lightColorScheme.onPrimary, width: 1),
      ),

      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide(color: _lightColorScheme.surface, width: 1),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide(color: _lightColorScheme.error),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: _lightColorScheme.primary,
        side: BorderSide(color: _lightColorScheme.onPrimary, width: 1),
        textStyle: const TextStyle(fontSize: 16),
      ),
    ),
    iconButtonTheme: IconButtonThemeData(
      style: IconButton.styleFrom(backgroundColor: _lightColorScheme.primary),
    ),
    iconTheme: IconThemeData(color: _lightColorScheme.onPrimary),
    checkboxTheme: CheckboxThemeData(
      side: WidgetStateBorderSide.resolveWith(
        (states) => BorderSide(width: 1.0, color: _lightColorScheme.onPrimary),
      ),
      fillColor: WidgetStateProperty.all(_lightColorScheme.primary),
      checkColor: WidgetStateProperty.all(_lightColorScheme.onPrimary),
    ),
    cardTheme: CardThemeData(
      color: _lightColorScheme.primary,
      elevation: 0.3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(width: 0.2, color: _lightColorScheme.onPrimary),
      ),
    ),
    listTileTheme: ListTileThemeData(
      textColor: _lightColorScheme.onPrimary,
      iconColor: _lightColorScheme.onPrimary,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: _lightColorScheme.primary,
      elevation: 0,
      foregroundColor: _lightColorScheme.onPrimary,
      iconTheme: IconThemeData(color: _lightColorScheme.onPrimary),
      actionsIconTheme: IconThemeData(color: _lightColorScheme.onPrimary),
    ),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: _lightColorScheme.error,
      actionTextColor: _lightColorScheme.onError,
      contentTextStyle: TextStyle(
        color: _lightColorScheme.onError,
        fontSize: 16,
      ),
    ),
    dialogTheme: DialogThemeData(backgroundColor: _lightColorScheme.primary),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: _lightColorScheme.primary,

      selectedItemColor: _lightColorScheme.surface,
      unselectedItemColor: _lightColorScheme.secondary,
      selectedIconTheme: IconThemeData(color: _lightColorScheme.surface),
    ),
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return _lightColorScheme.onSurface;
        }
        return _lightColorScheme.onPrimary;
      }),
      trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return _lightColorScheme.surface;
        }
        return _lightColorScheme.primary;
      }),
      trackOutlineColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return _lightColorScheme.surface;
        }
        return _lightColorScheme.onPrimary;
      }),
    ),
  );
}
