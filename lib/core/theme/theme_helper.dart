import 'dart:ui';
import 'package:flutter/material.dart';
export 'package:kontena_pos/core/app_export.dart';

String _appTheme = "primary";

/// Helper class for managing themes and colors.
class ThemeHelper {
  // A map of custom color themes supported by the app
  Map<String, PrimaryColors> _supportedCustomColor = {
    'primary': PrimaryColors()
  };

// A map of color schemes supported by the app
  Map<String, ColorScheme> _supportedColorScheme = {
    'primary': ColorSchemes.primaryColorScheme
  };

  /// Changes the app theme to [_newTheme].
  void changeTheme(String _newTheme) {
    _appTheme = _newTheme;
  }

  /// Returns the primary colors for the current theme.
  PrimaryColors _getThemeColors() {
    //throw exception to notify given theme is not found or not generated by the generator
    if (!_supportedCustomColor.containsKey(_appTheme)) {
      throw Exception(
          "$_appTheme is not found.Make sure you have added this theme class in JSON Try running flutter pub run build_runner");
    }
    //return theme from map

    return _supportedCustomColor[_appTheme] ?? PrimaryColors();
  }

  /// Returns the current theme data.
  ThemeData _getThemeData() {
    //throw exception to notify given theme is not found or not generated by the generator
    if (!_supportedColorScheme.containsKey(_appTheme)) {
      throw Exception(
          "$_appTheme is not found.Make sure you have added this theme class in JSON Try running flutter pub run build_runner");
    }
    //return theme from map

    var colorScheme =
        _supportedColorScheme[_appTheme] ?? ColorSchemes.primaryColorScheme;
    return ThemeData(
      visualDensity: VisualDensity.standard,
      colorScheme: colorScheme,
      textTheme: TextThemes.textTheme(colorScheme),
      scaffoldBackgroundColor: colorScheme.primaryContainer,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          visualDensity: const VisualDensity(
            vertical: -4,
            horizontal: -4,
          ),
          padding: EdgeInsets.zero,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          backgroundColor: Colors.transparent,
          side: BorderSide(
            color: appTheme.orange600,
            width: 1.0,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          visualDensity: const VisualDensity(
            vertical: -4,
            horizontal: -4,
          ),
          padding: EdgeInsets.zero,
        ),
      ),
      dividerTheme: DividerThemeData(
        thickness: 1,
        space: 1,
        color: appTheme.gray200,
      ),
    );
  }

  /// Returns the primary colors for the current theme.
  PrimaryColors themeColor() => _getThemeColors();

  /// Returns the current theme data.
  ThemeData themeData() => _getThemeData();
}

/// Class containing the supported text theme styles.
class TextThemes {
  static TextTheme textTheme(ColorScheme colorScheme) => TextTheme(
        bodyMedium: TextStyle(
          color: colorScheme.onPrimary,
          fontSize: 14.0,
          fontFamily: 'Urbanist',
          fontWeight: FontWeight.w400,
        ),
        bodySmall: TextStyle(
          color: colorScheme.onPrimary,
          fontSize: 12.0,
          fontFamily: 'Lato',
          fontWeight: FontWeight.w400,
        ),
        headlineLarge: TextStyle(
          color: colorScheme.primaryContainer,
          fontSize: 32.0,
          fontFamily: 'Lato',
          fontWeight: FontWeight.w700,
        ),
        headlineSmall: TextStyle(
          color: colorScheme.onPrimary,
          fontSize: 24.0,
          fontFamily: 'Urbanist',
          fontWeight: FontWeight.w700,
        ),
        labelLarge: TextStyle(
          color: appTheme.gray500,
          fontSize: 16.0,
          fontFamily: 'Urbanist',
          fontWeight: FontWeight.w600,
        ),
        labelMedium: TextStyle(
          color: appTheme.gray500,
          fontSize: 14.0,
          fontFamily: 'Urbanist',
          fontWeight: FontWeight.w700,
        ),
        labelSmall: TextStyle(
          color: appTheme.gray500,
          fontSize: 12.0,
          fontFamily: 'Urbanist',
          fontWeight: FontWeight.w700,
        ),
        titleLarge: TextStyle(
          color: colorScheme.onPrimary,
          fontSize: 20.0,
          fontFamily: 'Lato',
          fontWeight: FontWeight.w700,
        ),
        titleMedium: TextStyle(
          color: colorScheme.onPrimary,
          fontSize: 16.0,
          fontFamily: 'Lato',
          fontWeight: FontWeight.w700,
        ),
        titleSmall: TextStyle(
          color: colorScheme.primaryContainer,
          fontSize: 14.0,
          fontFamily: 'Lato',
          fontWeight: FontWeight.w700,
        ),
      );
}

/// Class containing the supported color schemes.
class ColorSchemes {
  static const primaryColorScheme = ColorScheme.light(
    // Primary colors
    primary: Color(0xFF079dd4),
    secondary: Color(0xFF393E46),
    primaryContainer: Color(0XFFFFFFFF),
    secondaryContainer: Color(0XFFE6F5FB),

    background: Color(0xFFEEEEEE),

    surface: Color(0xFFE3E6EA),

    // Error colors
    onError: Color(0XFFF81E01),

    // On colors(text colors)
    onPrimary: Color(0XFF222831),
    onPrimaryContainer: Color(0XFFF81E01),
    outline: Color(0XFF9E9E9E),
  );
}

/// Class containing custom colors for a primary theme.
class PrimaryColors {
  Color get primary => const Color(0xFF079dd4);
  Color get secondary => const Color(0xFF00ADB5);

  Color get black => const Color.fromARGB(255, 11, 12, 23);

  // Blue
  Color get blue100 => const Color.fromARGB(255, 190, 217, 241);

  // BlueGray
  Color get blueGray100 => const Color(0xFFA4A5B0);
  Color get blueGray300 => const Color(0XFFA4A5B0);
  Color get blueGray30001 => const Color(0XFF78A9C6);
  Color get blueGray50 => const Color(0XFFEDEDF2);

  // DeepOrange
  Color get deepOrange300 => const Color(0XFFFB7967);

  // DeepPurple
  Color get deepPurple300 => const Color(0XFFA178C6);

  // Gray
  Color get gray200 => const Color(0XFFEDEDEF);
  Color get gray300 => const Color(0XFFE0E0E0);
  Color get gray30001 => const Color(0XFFE0D2EC);
  Color get gray30002 => const Color(0XFFDBEBE5);
  Color get gray500 => const Color(0XFF9E9E9E);
  Color get gray600 => const Color(0XFF6D6D74);

  // Green
  Color get green600 => const Color(0XFF4A9D4D);

  // Orange
  Color get orange300 => const Color(0XFFFEB866);
  Color get orange600 => const Color(0XFFFE8800);

  // Pink
  Color get pink50 => const Color(0XFFFAD2F4);

  // Purple
  Color get purple300 => const Color(0XFFDD49C7);

  // Red
  Color get red100 => const Color(0XFFFED2CC);
  Color get red200 => const Color(0XFFCC9194);
  Color get red => const Color.fromARGB(255, 251, 120, 103);

  // Yellow
  Color get yellow100 => const Color(0XFFFFE7CC);
  Color get yellow400 => const Color(0XFFFCDE67);
}

PrimaryColors get appTheme => ThemeHelper().themeColor();
ThemeData get theme => ThemeHelper().themeData();
