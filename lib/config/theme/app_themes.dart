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
  static const _darkColorScheme = ColorScheme(
    brightness: Brightness.dark,
    // màu nền chính
    primary: Colors.black,
    // màu chữ trên nền primary
    onPrimary: Colors.white,
    // màu phụ (màu mờ)
    secondary: Color.fromARGB(255, 180, 180, 180),
    onSecondary: Colors.black,
    // màu nền (card, btn, border)
    surface: Color.fromARGB(255, 30, 30, 30),
    // màu chữ trên nền surface
    onSurface: Colors.white,
    // màu lỗi
    error: Colors.redAccent,
    // màu chữ trên nền error
    onError: Colors.white,
    // màu hightlight, màu của tùy chọn
    tertiary: Color.fromARGB(255, 0, 169, 157),
    onTertiary: Colors.white,

    //màu của phần flash card
    //màu đã biết
    primaryContainer: Colors.orangeAccent,
    //màu chưa biết
    secondaryContainer: Colors.green,
  );
  static const _pinkColorScheme = ColorScheme(
    brightness: Brightness.light,
    // màu nền chính
    primary: Color(0xFFFFF0F5), // Lavender Blush
    // màu chữ trên nền primary
    onPrimary: Colors.black,
    // màu phụ (màu mờ)
    secondary: Color(0xFF8B6B6B), // Rosy Brown
    onSecondary: Colors.white,
    // màu nền (card, btn, border)
    surface: Color(0xFFFF69B4), // Hot Pink
    // màu chữ trên nền surface
    onSurface: Colors.white,
    // màu lỗi
    error: Colors.red,
    // màu chữ trên nền error
    onError: Colors.white,
    // màu hightlight, màu của tùy chọn
    tertiary: Color(0xFFDB7093), // Pale Violet Red
    onTertiary: Colors.white,

    //màu của phần flash card
    //màu đã biết
    primaryContainer: Colors.orange,
    //màu chưa biết
    secondaryContainer: Color(0xFF3CB371), // Medium Sea Green
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
      style: IconButton.styleFrom(backgroundColor: Colors.transparent),
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

    datePickerTheme: DatePickerThemeData(
      backgroundColor: _lightColorScheme.surface,
      surfaceTintColor: _lightColorScheme.primary,
      headerBackgroundColor: _lightColorScheme.primary,
      headerForegroundColor: _lightColorScheme.onPrimary,
      dayForegroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return _lightColorScheme.surface;
        }
        if (states.contains(WidgetState.disabled)) {
          return _lightColorScheme.secondary; // màu chữ cho disabled
        }
        return _lightColorScheme.onSurface;
      }),

      dayBackgroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return _lightColorScheme.onSurface; // Nền xanh khi được chọn
        }

        return Colors.transparent;
      }),
      todayBorder: BorderSide(color: _lightColorScheme.surface, width: 0.2),
      todayForegroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return _lightColorScheme.surface;
        }

        return _lightColorScheme.onSurface;
      }),

      weekdayStyle: TextStyle(color: _lightColorScheme.onSurface),
      todayBackgroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return _lightColorScheme.onSurface;
        }

        return Colors.transparent;
      }),
      yearStyle: TextStyle(color: _lightColorScheme.onPrimary),
      yearBackgroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return _lightColorScheme.onSurface;
        }

        return Colors.transparent;
      }),
      yearForegroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return _lightColorScheme.surface;
        }

        return _lightColorScheme.onSurface;
      }),

      confirmButtonStyle: TextButton.styleFrom(
        foregroundColor: _lightColorScheme.onSurface,
      ),

      cancelButtonStyle: TextButton.styleFrom(
        foregroundColor: _lightColorScheme.secondary,
      ),
    ),
    tabBarTheme: TabBarThemeData(
      labelColor: _lightColorScheme.onSurface,
      unselectedLabelColor: _lightColorScheme.secondary,
      labelStyle: const TextStyle(fontSize: 14),
      unselectedLabelStyle: const TextStyle(fontSize: 14),
      indicator: BoxDecoration(
        color: _lightColorScheme.surface,
        borderRadius: BorderRadius.circular(12),
      ),
      indicatorSize: TabBarIndicatorSize.tab,
    ),
  );

  static ThemeData darkTheme = ThemeData(
    fontFamily: FontFamily.sFProDisplay,
    colorScheme: _darkColorScheme,
    scaffoldBackgroundColor: _darkColorScheme.primary,
    textTheme: TextTheme(
      bodySmall: TextStyle(fontSize: 14, color: _darkColorScheme.onPrimary),
      bodyMedium: TextStyle(fontSize: 18, color: _darkColorScheme.onPrimary),
      bodyLarge: TextStyle(fontSize: 22, color: _darkColorScheme.onPrimary),
      titleLarge: TextStyle(
        fontSize: 22,
        color: _darkColorScheme.onPrimary,
        fontWeight: FontWeight.bold,
      ),
      // chữ cho các cái nhãn bị mờ "privacy", ...
      labelSmall: TextStyle(
        fontSize: 14,
        color: _darkColorScheme.onPrimary,
        fontWeight: FontWeight.bold,
      ),
      labelMedium: TextStyle(
        fontSize: 18,
        color: _darkColorScheme.onPrimary,
        fontWeight: FontWeight.bold,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: _darkColorScheme.surface,
        textStyle: TextStyle(
          fontSize: 16,
          color: _darkColorScheme.onSurface,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: _darkColorScheme.onPrimary,
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        splashFactory: NoSplash.splashFactory,
        overlayColor: Colors.transparent,
      ),
    ),
    textSelectionTheme: TextSelectionThemeData(
      // màu của thanh cursor
      cursorColor: _darkColorScheme.onPrimary,
    ),
    inputDecorationTheme: InputDecorationTheme(
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide(color: _darkColorScheme.onPrimary, width: 1),
      ),

      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide(color: _darkColorScheme.onPrimary, width: 1),
      ),

      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide(color: _darkColorScheme.surface, width: 1),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide(color: _darkColorScheme.error),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: _darkColorScheme.primary,
        side: BorderSide(color: _darkColorScheme.onPrimary, width: 1),
        textStyle: const TextStyle(fontSize: 16),
      ),
    ),
    iconButtonTheme: IconButtonThemeData(
      style: IconButton.styleFrom(backgroundColor: Colors.transparent),
    ),
    iconTheme: IconThemeData(color: _darkColorScheme.onPrimary),
    checkboxTheme: CheckboxThemeData(
      side: WidgetStateBorderSide.resolveWith(
        (states) => BorderSide(width: 1.0, color: _darkColorScheme.onPrimary),
      ),
      fillColor: WidgetStateProperty.all(_darkColorScheme.primary),
      checkColor: WidgetStateProperty.all(_darkColorScheme.onPrimary),
    ),
    cardTheme: CardThemeData(
      color: _darkColorScheme.primary,
      elevation: 0.3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(width: 0.2, color: _darkColorScheme.onPrimary),
      ),
    ),
    listTileTheme: ListTileThemeData(
      textColor: _darkColorScheme.onPrimary,
      iconColor: _darkColorScheme.onPrimary,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: _darkColorScheme.primary,
      elevation: 0,
      foregroundColor: _darkColorScheme.onPrimary,
      iconTheme: IconThemeData(color: _darkColorScheme.onPrimary),
      actionsIconTheme: IconThemeData(color: _darkColorScheme.onPrimary),
    ),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: _darkColorScheme.error,
      actionTextColor: _darkColorScheme.onError,
      contentTextStyle: TextStyle(
        color: _darkColorScheme.onError,
        fontSize: 16,
      ),
    ),
    dialogTheme: DialogThemeData(backgroundColor: _darkColorScheme.primary),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: _darkColorScheme.primary,

      selectedItemColor: _darkColorScheme.surface,
      unselectedItemColor: _darkColorScheme.secondary,
      selectedIconTheme: IconThemeData(color: _darkColorScheme.surface),
    ),
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return _darkColorScheme.onSurface;
        }
        return _darkColorScheme.onPrimary;
      }),
      trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return _darkColorScheme.surface;
        }
        return _darkColorScheme.primary;
      }),
      trackOutlineColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return _darkColorScheme.surface;
        }
        return _darkColorScheme.onPrimary;
      }),
    ),

    datePickerTheme: DatePickerThemeData(
      backgroundColor: _darkColorScheme.surface,
      surfaceTintColor: _darkColorScheme.primary,
      headerBackgroundColor: _darkColorScheme.primary,
      headerForegroundColor: _darkColorScheme.onPrimary,
      dayForegroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return _darkColorScheme.surface;
        }
        if (states.contains(WidgetState.disabled)) {
          return _darkColorScheme.secondary; // màu chữ cho disabled
        }
        return _darkColorScheme.onSurface;
      }),

      dayBackgroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return _darkColorScheme.onSurface; // Nền xanh khi được chọn
        }

        return Colors.transparent;
      }),
      todayBorder: BorderSide(color: _darkColorScheme.surface, width: 0.2),
      todayForegroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return _darkColorScheme.surface;
        }

        return _darkColorScheme.onSurface;
      }),

      weekdayStyle: TextStyle(color: _darkColorScheme.onSurface),
      todayBackgroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return _darkColorScheme.onSurface;
        }

        return Colors.transparent;
      }),
      yearStyle: TextStyle(color: _darkColorScheme.onPrimary),
      yearBackgroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return _darkColorScheme.onSurface;
        }

        return Colors.transparent;
      }),
      yearForegroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return _darkColorScheme.surface;
        }

        return _darkColorScheme.onSurface;
      }),

      confirmButtonStyle: TextButton.styleFrom(
        foregroundColor: _darkColorScheme.onSurface,
      ),

      cancelButtonStyle: TextButton.styleFrom(
        foregroundColor: _darkColorScheme.secondary,
      ),
    ),
    tabBarTheme: TabBarThemeData(
      labelColor: _darkColorScheme.surface,
      unselectedLabelColor: _darkColorScheme.secondary,
      labelStyle: const TextStyle(fontSize: 14),
      unselectedLabelStyle: const TextStyle(fontSize: 14),
      indicator: BoxDecoration(
        color: _darkColorScheme.surface,
        borderRadius: BorderRadius.circular(12),
      ),
      indicatorSize: TabBarIndicatorSize.tab,
    ),
  );

  static ThemeData pinkTheme = ThemeData(
    fontFamily: FontFamily.sFProDisplay,
    colorScheme: _pinkColorScheme,
    scaffoldBackgroundColor: _pinkColorScheme.primary,
    textTheme: TextTheme(
      bodySmall: TextStyle(fontSize: 14, color: _pinkColorScheme.onPrimary),
      bodyMedium: TextStyle(fontSize: 18, color: _pinkColorScheme.onPrimary),
      bodyLarge: TextStyle(fontSize: 22, color: _pinkColorScheme.onPrimary),
      titleLarge: TextStyle(
        fontSize: 22,
        color: _pinkColorScheme.onPrimary,
        fontWeight: FontWeight.bold,
      ),
      // chữ cho các cái nhãn bị mờ "privacy", ...
      labelSmall: TextStyle(
        fontSize: 14,
        color: _pinkColorScheme.onPrimary,
        fontWeight: FontWeight.bold,
      ),
      labelMedium: TextStyle(
        fontSize: 18,
        color: _pinkColorScheme.onPrimary,
        fontWeight: FontWeight.bold,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: _pinkColorScheme.surface,
        textStyle: TextStyle(
          fontSize: 16,
          color: _pinkColorScheme.onSurface,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: _pinkColorScheme.onPrimary,
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        splashFactory: NoSplash.splashFactory,
        overlayColor: Colors.transparent,
      ),
    ),
    textSelectionTheme: TextSelectionThemeData(
      // màu của thanh cursor
      cursorColor: _pinkColorScheme.onPrimary,
    ),
    inputDecorationTheme: InputDecorationTheme(
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide(color: _pinkColorScheme.onPrimary, width: 1),
      ),

      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide(color: _pinkColorScheme.onPrimary, width: 1),
      ),

      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide(color: _pinkColorScheme.surface, width: 1),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide(color: _pinkColorScheme.error),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: _pinkColorScheme.primary,
        side: BorderSide(color: _pinkColorScheme.onPrimary, width: 1),
        textStyle: const TextStyle(fontSize: 16),
      ),
    ),
    iconButtonTheme: IconButtonThemeData(
      style: IconButton.styleFrom(backgroundColor: Colors.transparent),
    ),
    iconTheme: IconThemeData(color: _pinkColorScheme.onPrimary),
    checkboxTheme: CheckboxThemeData(
      side: WidgetStateBorderSide.resolveWith(
        (states) => BorderSide(width: 1.0, color: _pinkColorScheme.onPrimary),
      ),
      fillColor: WidgetStateProperty.all(_pinkColorScheme.primary),
      checkColor: WidgetStateProperty.all(_pinkColorScheme.onPrimary),
    ),
    cardTheme: CardThemeData(
      color: _pinkColorScheme.primary,
      elevation: 0.3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(width: 0.2, color: _pinkColorScheme.onPrimary),
      ),
    ),
    listTileTheme: ListTileThemeData(
      textColor: _pinkColorScheme.onPrimary,
      iconColor: _pinkColorScheme.onPrimary,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: _pinkColorScheme.primary,
      elevation: 0,
      foregroundColor: _pinkColorScheme.onPrimary,
      iconTheme: IconThemeData(color: _pinkColorScheme.onPrimary),
      actionsIconTheme: IconThemeData(color: _pinkColorScheme.onPrimary),
    ),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: _pinkColorScheme.error,
      actionTextColor: _pinkColorScheme.onError,
      contentTextStyle: TextStyle(
        color: _pinkColorScheme.onError,
        fontSize: 16,
      ),
    ),
    dialogTheme: DialogThemeData(backgroundColor: _pinkColorScheme.primary),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: _pinkColorScheme.primary,

      selectedItemColor: _pinkColorScheme.surface,
      unselectedItemColor: _pinkColorScheme.secondary,
      selectedIconTheme: IconThemeData(color: _pinkColorScheme.surface),
    ),
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return _pinkColorScheme.onSurface;
        }
        return _pinkColorScheme.onPrimary;
      }),
      trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return _pinkColorScheme.surface;
        }
        return _pinkColorScheme.primary;
      }),
      trackOutlineColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return _pinkColorScheme.surface;
        }
        return _pinkColorScheme.onPrimary;
      }),
    ),

    datePickerTheme: DatePickerThemeData(
      backgroundColor: _pinkColorScheme.surface,
      surfaceTintColor: _pinkColorScheme.primary,
      headerBackgroundColor: _pinkColorScheme.primary,
      headerForegroundColor: _pinkColorScheme.onPrimary,
      dayForegroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return _pinkColorScheme.surface;
        }
        if (states.contains(WidgetState.disabled)) {
          return _pinkColorScheme.secondary; // màu chữ cho disabled
        }
        return _pinkColorScheme.onSurface;
      }),

      dayBackgroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return _pinkColorScheme.onSurface; // Nền xanh khi được chọn
        }

        return Colors.transparent;
      }),
      todayBorder: BorderSide(color: _pinkColorScheme.surface, width: 0.2),
      todayForegroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return _pinkColorScheme.surface;
        }

        return _pinkColorScheme.onSurface;
      }),

      weekdayStyle: TextStyle(color: _pinkColorScheme.onSurface),
      todayBackgroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return _pinkColorScheme.onSurface;
        }

        return Colors.transparent;
      }),
      yearStyle: TextStyle(color: _pinkColorScheme.onPrimary),
      yearBackgroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return _pinkColorScheme.onSurface;
        }

        return Colors.transparent;
      }),
      yearForegroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return _pinkColorScheme.surface;
        }

        return _pinkColorScheme.onSurface;
      }),

      confirmButtonStyle: TextButton.styleFrom(
        foregroundColor: _pinkColorScheme.onSurface,
      ),

      cancelButtonStyle: TextButton.styleFrom(
        foregroundColor: _pinkColorScheme.secondary,
      ),
    ),
    tabBarTheme: TabBarThemeData(
      labelColor: _pinkColorScheme.surface,
      unselectedLabelColor: _pinkColorScheme.secondary,
      labelStyle: const TextStyle(fontSize: 14),
      unselectedLabelStyle: const TextStyle(fontSize: 14),
      indicator: BoxDecoration(
        color: _pinkColorScheme.surface,
        borderRadius: BorderRadius.circular(12),
      ),
      indicatorSize: TabBarIndicatorSize.tab,
    ),
  );
}
