import 'package:flutter/material.dart';

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff236a4b),
      surfaceTint: Color(0xff236a4b),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xffaaf2ca),
      onPrimaryContainer: Color(0xff005235),
      secondary: Color(0xff4d6356),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xffd0e8d8),
      onSecondaryContainer: Color(0xff364b3f),
      tertiary: Color(0xff3c6472),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xffc0e9fa),
      onTertiaryContainer: Color(0xff234c5a),
      error: Color(0xffba1a1a),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffffdad6),
      onErrorContainer: Color(0xff93000a),
      surface: Color(0xfff5fbf4),
      onSurface: Color(0xff171d19),
      onSurfaceVariant: Color(0xff404943),
      outline: Color(0xff707973),
      outlineVariant: Color(0xffc0c9c1),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2c322e),
      inversePrimary: Color(0xff8fd5af),
      primaryFixed: Color(0xffaaf2ca),
      onPrimaryFixed: Color(0xff002113),
      primaryFixedDim: Color(0xff8fd5af),
      onPrimaryFixedVariant: Color(0xff005235),
      secondaryFixed: Color(0xffd0e8d8),
      onSecondaryFixed: Color(0xff0a1f15),
      secondaryFixedDim: Color(0xffb4ccbc),
      onSecondaryFixedVariant: Color(0xff364b3f),
      tertiaryFixed: Color(0xffc0e9fa),
      onTertiaryFixed: Color(0xff001f28),
      tertiaryFixedDim: Color(0xffa4cddd),
      onTertiaryFixedVariant: Color(0xff234c5a),
      surfaceDim: Color(0xffd6dbd5),
      surfaceBright: Color(0xfff5fbf4),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff0f5ef),
      surfaceContainer: Color(0xffeaefe9),
      surfaceContainerHigh: Color(0xffe4eae3),
      surfaceContainerHighest: Color(0xffdee4de),
    );
  }

  ThemeData light() {
    return theme(lightScheme());
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xff8fd5af),
      surfaceTint: Color(0xff8fd5af),
      onPrimary: Color(0xff003824),
      primaryContainer: Color(0xff005235),
      onPrimaryContainer: Color(0xffaaf2ca),
      secondary: Color(0xffb4ccbc),
      onSecondary: Color(0xff203529),
      secondaryContainer: Color(0xff364b3f),
      onSecondaryContainer: Color(0xffd0e8d8),
      tertiary: Color(0xffa4cddd),
      onTertiary: Color(0xff063542),
      tertiaryContainer: Color(0xff234c5a),
      onTertiaryContainer: Color(0xffc0e9fa),
      error: Color(0xffffb4ab),
      onError: Color(0xff690005),
      errorContainer: Color(0xff93000a),
      onErrorContainer: Color(0xffffdad6),
      surface: Color(0xff0f1511),
      onSurface: Color(0xffdee4de),
      onSurfaceVariant: Color(0xffc0c9c1),
      outline: Color(0xff8a938c),
      outlineVariant: Color(0xff404943),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffdee4de),
      inversePrimary: Color(0xff236a4b),
      primaryFixed: Color(0xffaaf2ca),
      onPrimaryFixed: Color(0xff002113),
      primaryFixedDim: Color(0xff8fd5af),
      onPrimaryFixedVariant: Color(0xff005235),
      secondaryFixed: Color(0xffd0e8d8),
      onSecondaryFixed: Color(0xff0a1f15),
      secondaryFixedDim: Color(0xffb4ccbc),
      onSecondaryFixedVariant: Color(0xff364b3f),
      tertiaryFixed: Color(0xffc0e9fa),
      onTertiaryFixed: Color(0xff001f28),
      tertiaryFixedDim: Color(0xffa4cddd),
      onTertiaryFixedVariant: Color(0xff234c5a),
      surfaceDim: Color(0xff0f1511),
      surfaceBright: Color(0xff353b36),
      surfaceContainerLowest: Color(0xff0a0f0c),
      surfaceContainerLow: Color(0xff171d19),
      surfaceContainer: Color(0xff1b211d),
      surfaceContainerHigh: Color(0xff262b27),
      surfaceContainerHighest: Color(0xff303632),
    );
  }

  ThemeData dark() {
    return theme(darkScheme());
  }

  ThemeData theme(ColorScheme colorScheme) => ThemeData(
    useMaterial3: true,
    brightness: colorScheme.brightness,
    colorScheme: colorScheme,
    textTheme: textTheme.apply(
      bodyColor: colorScheme.onSurface,
      displayColor: colorScheme.onSurface,
    ),
    scaffoldBackgroundColor: colorScheme.surface,
    canvasColor: colorScheme.surface,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
      ),
    ),
  );

  List<ExtendedColor> get extendedColors => [];
}

class ExtendedColor {
  final Color seed, value;
  final ColorFamily light;
  final ColorFamily lightHighContrast;
  final ColorFamily lightMediumContrast;
  final ColorFamily dark;
  final ColorFamily darkHighContrast;
  final ColorFamily darkMediumContrast;

  const ExtendedColor({
    required this.seed,
    required this.value,
    required this.light,
    required this.lightHighContrast,
    required this.lightMediumContrast,
    required this.dark,
    required this.darkHighContrast,
    required this.darkMediumContrast,
  });
}

class ColorFamily {
  const ColorFamily({
    required this.color,
    required this.onColor,
    required this.colorContainer,
    required this.onColorContainer,
  });

  final Color color;
  final Color onColor;
  final Color colorContainer;
  final Color onColorContainer;
}
