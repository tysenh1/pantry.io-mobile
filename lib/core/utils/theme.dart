import "package:flutter/material.dart";

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff4e644b),
      surfaceTint: Color(0xff4e644b),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xffa4bd9f),
      onPrimaryContainer: Color(0xff374d35),
      secondary: Color(0xff586155),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xffd9e3d3),
      onSecondaryContainer: Color(0xff5c6559),
      tertiary: Color(0xff43636d),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff9abcc7),
      onTertiaryContainer: Color(0xff2b4c56),
      error: Color(0xffba1a1a),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffffdad6),
      onErrorContainer: Color(0xff93000a),
      surface: Color(0xfffbf9f5),
      onSurface: Color(0xff1b1c1a),
      onSurfaceVariant: Color(0xff434841),
      outline: Color(0xff747970),
      outlineVariant: Color(0xffc3c8bf),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff30312e),
      inversePrimary: Color(0xffb4cdaf),
      primaryFixed: Color(0xffd0eaca),
      onPrimaryFixed: Color(0xff0b200c),
      primaryFixedDim: Color(0xffb4cdaf),
      onPrimaryFixedVariant: Color(0xff364c35),
      secondaryFixed: Color(0xffdce5d6),
      onSecondaryFixed: Color(0xff151e14),
      secondaryFixedDim: Color(0xffc0c9bb),
      onSecondaryFixedVariant: Color(0xff40493e),
      tertiaryFixed: Color(0xffc5e8f4),
      onTertiaryFixed: Color(0xff001f26),
      tertiaryFixedDim: Color(0xffaaccd7),
      onTertiaryFixedVariant: Color(0xff2a4b55),
      surfaceDim: Color(0xffdbdad6),
      surfaceBright: Color(0xfffbf9f5),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff5f3ef),
      surfaceContainer: Color(0xffefeeea),
      surfaceContainerHigh: Color(0xffe9e8e4),
      surfaceContainerHighest: Color(0xffe3e2df),
    );
  }

  ThemeData light() {
    return theme(lightScheme());
  }

  static ColorScheme lightMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff263b25),
      surfaceTint: Color(0xff4e644b),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff5c7359),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff30392e),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff667063),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff183b44),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff51727c),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff740006),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffcf2c27),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfffbf9f5),
      onSurface: Color(0xff10110f),
      onSurfaceVariant: Color(0xff333831),
      outline: Color(0xff4f544d),
      outlineVariant: Color(0xff696e67),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff30312e),
      inversePrimary: Color(0xffb4cdaf),
      primaryFixed: Color(0xff5c7359),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff445a42),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff667063),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff4e574c),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff51727c),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff395a63),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffc7c6c3),
      surfaceBright: Color(0xfffbf9f5),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff5f3ef),
      surfaceContainer: Color(0xffe9e8e4),
      surfaceContainerHigh: Color(0xffdeddd9),
      surfaceContainerHighest: Color(0xffd2d2ce),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme());
  }

  static ColorScheme lightHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff1c311c),
      surfaceTint: Color(0xff4e644b),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff394f37),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff262e24),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff434c40),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff0c3039),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff2d4e57),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff600004),
      onError: Color(0xffffffff),
      errorContainer: Color(0xff98000a),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfffbf9f5),
      onSurface: Color(0xff000000),
      onSurfaceVariant: Color(0xff000000),
      outline: Color(0xff292d27),
      outlineVariant: Color(0xff464b43),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff30312e),
      inversePrimary: Color(0xffb4cdaf),
      primaryFixed: Color(0xff394f37),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff233822),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff434c40),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff2c352b),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff2d4e57),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff143740),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffb9b9b5),
      surfaceBright: Color(0xfffbf9f5),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff2f1ed),
      surfaceContainer: Color(0xffe3e2df),
      surfaceContainerHigh: Color(0xffd5d4d1),
      surfaceContainerHighest: Color(0xffc7c6c3),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme());
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffbfd9ba),
      surfaceTint: Color(0xffb4cdaf),
      onPrimary: Color(0xff203520),
      primaryContainer: Color(0xffa4bd9f),
      onPrimaryContainer: Color(0xff374d35),
      secondary: Color(0xffc0c9bb),
      onSecondary: Color(0xff2a3328),
      secondaryContainer: Color(0xff454e42),
      onSecondaryContainer: Color(0xffb5bfb0),
      tertiary: Color(0xffb5d8e3),
      onTertiary: Color(0xff12353e),
      tertiaryContainer: Color(0xff9abcc7),
      onTertiaryContainer: Color(0xff2b4c56),
      error: Color(0xffffb4ab),
      onError: Color(0xff690005),
      errorContainer: Color(0xff93000a),
      onErrorContainer: Color(0xffffdad6),
      surface: Color(0xff121412),
      onSurface: Color(0xffe3e2df),
      onSurfaceVariant: Color(0xffc3c8bf),
      outline: Color(0xff8d928a),
      outlineVariant: Color(0xff434841),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe3e2df),
      inversePrimary: Color(0xff4e644b),
      primaryFixed: Color(0xffd0eaca),
      onPrimaryFixed: Color(0xff0b200c),
      primaryFixedDim: Color(0xffb4cdaf),
      onPrimaryFixedVariant: Color(0xff364c35),
      secondaryFixed: Color(0xffdce5d6),
      onSecondaryFixed: Color(0xff151e14),
      secondaryFixedDim: Color(0xffc0c9bb),
      onSecondaryFixedVariant: Color(0xff40493e),
      tertiaryFixed: Color(0xffc5e8f4),
      onTertiaryFixed: Color(0xff001f26),
      tertiaryFixedDim: Color(0xffaaccd7),
      onTertiaryFixedVariant: Color(0xff2a4b55),
      surfaceDim: Color(0xff121412),
      surfaceBright: Color(0xff383937),
      surfaceContainerLowest: Color(0xff0d0f0d),
      surfaceContainerLow: Color(0xff1b1c1a),
      surfaceContainer: Color(0xff1f201e),
      surfaceContainerHigh: Color(0xff292a28),
      surfaceContainerHighest: Color(0xff343533),
    );
  }

  ThemeData dark() {
    return theme(darkScheme());
  }

  static ColorScheme darkMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffcae3c4),
      surfaceTint: Color(0xffb4cdaf),
      onPrimary: Color(0xff162a16),
      primaryContainer: Color(0xffa4bd9f),
      onPrimaryContainer: Color(0xff1a2f1a),
      secondary: Color(0xffd5dfd0),
      onSecondary: Color(0xff1f281e),
      secondaryContainer: Color(0xff8a9386),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xffbfe2ed),
      onTertiary: Color(0xff032a33),
      tertiaryContainer: Color(0xff9abcc7),
      onTertiaryContainer: Color(0xff092f37),
      error: Color(0xffffd2cc),
      onError: Color(0xff540003),
      errorContainer: Color(0xffff5449),
      onErrorContainer: Color(0xff000000),
      surface: Color(0xff121412),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xffd9ded4),
      outline: Color(0xffafb3aa),
      outlineVariant: Color(0xff8d9289),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe3e2df),
      inversePrimary: Color(0xff384d36),
      primaryFixed: Color(0xffd0eaca),
      onPrimaryFixed: Color(0xff031504),
      primaryFixedDim: Color(0xffb4cdaf),
      onPrimaryFixedVariant: Color(0xff263b25),
      secondaryFixed: Color(0xffdce5d6),
      onSecondaryFixed: Color(0xff0b130a),
      secondaryFixedDim: Color(0xffc0c9bb),
      onSecondaryFixedVariant: Color(0xff30392e),
      tertiaryFixed: Color(0xffc5e8f4),
      onTertiaryFixed: Color(0xff001419),
      tertiaryFixedDim: Color(0xffaaccd7),
      onTertiaryFixedVariant: Color(0xff183b44),
      surfaceDim: Color(0xff121412),
      surfaceBright: Color(0xff444542),
      surfaceContainerLowest: Color(0xff070806),
      surfaceContainerLow: Color(0xff1d1e1c),
      surfaceContainer: Color(0xff272826),
      surfaceContainerHigh: Color(0xff323330),
      surfaceContainerHighest: Color(0xff3d3e3b),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme());
  }

  static ColorScheme darkHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffddf7d7),
      surfaceTint: Color(0xffb4cdaf),
      onPrimary: Color(0xff000000),
      primaryContainer: Color(0xffb0caab),
      onPrimaryContainer: Color(0xff000f01),
      secondary: Color(0xffe9f3e3),
      onSecondary: Color(0xff000000),
      secondaryContainer: Color(0xffbcc5b7),
      onSecondaryContainer: Color(0xff060d06),
      tertiary: Color(0xffd7f5ff),
      onTertiary: Color(0xff000000),
      tertiaryContainer: Color(0xffa6c8d3),
      onTertiaryContainer: Color(0xff000d12),
      error: Color(0xffffece9),
      onError: Color(0xff000000),
      errorContainer: Color(0xffffaea4),
      onErrorContainer: Color(0xff220001),
      surface: Color(0xff121412),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xffffffff),
      outline: Color(0xffedf1e8),
      outlineVariant: Color(0xffbfc4bb),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe3e2df),
      inversePrimary: Color(0xff384d36),
      primaryFixed: Color(0xffd0eaca),
      onPrimaryFixed: Color(0xff000000),
      primaryFixedDim: Color(0xffb4cdaf),
      onPrimaryFixedVariant: Color(0xff031504),
      secondaryFixed: Color(0xffdce5d6),
      onSecondaryFixed: Color(0xff000000),
      secondaryFixedDim: Color(0xffc0c9bb),
      onSecondaryFixedVariant: Color(0xff0b130a),
      tertiaryFixed: Color(0xffc5e8f4),
      onTertiaryFixed: Color(0xff000000),
      tertiaryFixedDim: Color(0xffaaccd7),
      onTertiaryFixedVariant: Color(0xff001419),
      surfaceDim: Color(0xff121412),
      surfaceBright: Color(0xff50504e),
      surfaceContainerLowest: Color(0xff000000),
      surfaceContainerLow: Color(0xff1f201e),
      surfaceContainer: Color(0xff30312e),
      surfaceContainerHigh: Color(0xff3b3c39),
      surfaceContainerHighest: Color(0xff464744),
    );
  }

  ThemeData darkHighContrast() {
    return theme(darkHighContrastScheme());
  }


  ThemeData theme(ColorScheme colorScheme) => ThemeData(
    useMaterial3: true,
    brightness: colorScheme.brightness,
    colorScheme: colorScheme,
    textTheme: textTheme.apply(
      bodyColor: colorScheme.onSurface,
      displayColor: colorScheme.onSurface,
    ),
    scaffoldBackgroundColor: colorScheme.background,
    canvasColor: colorScheme.surface,
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: colorScheme.surfaceContainerLow,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(24),
        borderSide: BorderSide.none
      ),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 10
      ),
      hintStyle: TextStyle(
        color: colorScheme.secondary,
        fontFamily: 'Inter',
        fontSize: 16,
      )
    )
  );


  List<ExtendedColor> get extendedColors => [
  ];
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
