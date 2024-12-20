import "package:flutter/material.dart";

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff00696e),
      surfaceTint: Color(0xff00696e),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff9cf0f6),
      onPrimaryContainer: Color(0xff002022),
      secondary: Color(0xff4a6364),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xffcce8e9),
      onSecondaryContainer: Color(0xff041f21),
      tertiary: Color(0xff4e5f7d),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xffd6e3ff),
      onTertiaryContainer: Color(0xff081c36),
      error: Color(0xffba1a1a),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffffdad6),
      onErrorContainer: Color(0xff410002),
      surface: Color(0xfff4fafa),
      onSurface: Color(0xff161d1d),
      onSurfaceVariant: Color(0xff3f4949),
      outline: Color(0xff6f7979),
      outlineVariant: Color(0xffbec8c9),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2b3232),
      inversePrimary: Color(0xff80d4da),
      primaryFixed: Color(0xff9cf0f6),
      onPrimaryFixed: Color(0xff002022),
      primaryFixedDim: Color(0xff80d4da),
      onPrimaryFixedVariant: Color(0xff004f53),
      secondaryFixed: Color(0xffcce8e9),
      onSecondaryFixed: Color(0xff041f21),
      secondaryFixedDim: Color(0xffb1cccd),
      onSecondaryFixedVariant: Color(0xff324b4d),
      tertiaryFixed: Color(0xffd6e3ff),
      onTertiaryFixed: Color(0xff081c36),
      tertiaryFixedDim: Color(0xffb6c7e9),
      onTertiaryFixedVariant: Color(0xff374764),
      surfaceDim: Color(0xffd5dbdb),
      surfaceBright: Color(0xfff4fafa),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xffeff5f5),
      surfaceContainer: Color(0xffe9efef),
      surfaceContainerHigh: Color(0xffe3e9e9),
      surfaceContainerHighest: Color(0xffdde4e4),
    );
  }

  ThemeData light() {
    return theme(lightScheme());
  }

  static ColorScheme lightMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff004b4f),
      surfaceTint: Color(0xff00696e),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff238086),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff2e4749),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff60797b),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff334360),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff647594),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff8c0009),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffda342e),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfff4fafa),
      onSurface: Color(0xff161d1d),
      onSurfaceVariant: Color(0xff3b4545),
      outline: Color(0xff576161),
      outlineVariant: Color(0xff737d7d),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2b3232),
      inversePrimary: Color(0xff80d4da),
      primaryFixed: Color(0xff238086),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff00666b),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff60797b),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff476062),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff647594),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff4c5c7a),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffd5dbdb),
      surfaceBright: Color(0xfff4fafa),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xffeff5f5),
      surfaceContainer: Color(0xffe9efef),
      surfaceContainerHigh: Color(0xffe3e9e9),
      surfaceContainerHighest: Color(0xffdde4e4),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme());
  }

  static ColorScheme lightHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff002729),
      surfaceTint: Color(0xff00696e),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff004b4f),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff0c2628),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff2e4749),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff10223d),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff334360),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff4e0002),
      onError: Color(0xffffffff),
      errorContainer: Color(0xff8c0009),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfff4fafa),
      onSurface: Color(0xff000000),
      onSurfaceVariant: Color(0xff1c2626),
      outline: Color(0xff3b4545),
      outlineVariant: Color(0xff3b4545),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2b3232),
      inversePrimary: Color(0xffaafaff),
      primaryFixed: Color(0xff004b4f),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff003235),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff2e4749),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff173132),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff334360),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff1c2d48),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffd5dbdb),
      surfaceBright: Color(0xfff4fafa),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xffeff5f5),
      surfaceContainer: Color(0xffe9efef),
      surfaceContainerHigh: Color(0xffe3e9e9),
      surfaceContainerHighest: Color(0xffdde4e4),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme());
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xff80d4da),
      surfaceTint: Color(0xff80d4da),
      onPrimary: Color(0xff003739),
      primaryContainer: Color(0xff004f53),
      onPrimaryContainer: Color(0xff9cf0f6),
      secondary: Color(0xffb1cccd),
      onSecondary: Color(0xff1b3436),
      secondaryContainer: Color(0xff324b4d),
      onSecondaryContainer: Color(0xffcce8e9),
      tertiary: Color(0xffb6c7e9),
      onTertiary: Color(0xff20314c),
      tertiaryContainer: Color(0xff374764),
      onTertiaryContainer: Color(0xffd6e3ff),
      error: Color(0xffffb4ab),
      onError: Color(0xff690005),
      errorContainer: Color(0xff93000a),
      onErrorContainer: Color(0xffffdad6),
      surface: Color(0xff0e1415),
      onSurface: Color(0xffdde4e4),
      onSurfaceVariant: Color(0xffbec8c9),
      outline: Color(0xff899393),
      outlineVariant: Color(0xff3f4949),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffdde4e4),
      inversePrimary: Color(0xff00696e),
      primaryFixed: Color(0xff9cf0f6),
      onPrimaryFixed: Color(0xff002022),
      primaryFixedDim: Color(0xff80d4da),
      onPrimaryFixedVariant: Color(0xff004f53),
      secondaryFixed: Color(0xffcce8e9),
      onSecondaryFixed: Color(0xff041f21),
      secondaryFixedDim: Color(0xffb1cccd),
      onSecondaryFixedVariant: Color(0xff324b4d),
      tertiaryFixed: Color(0xffd6e3ff),
      onTertiaryFixed: Color(0xff081c36),
      tertiaryFixedDim: Color(0xffb6c7e9),
      onTertiaryFixedVariant: Color(0xff374764),
      surfaceDim: Color(0xff0e1415),
      surfaceBright: Color(0xff343a3b),
      surfaceContainerLowest: Color(0xff090f10),
      surfaceContainerLow: Color(0xff161d1d),
      surfaceContainer: Color(0xff1a2121),
      surfaceContainerHigh: Color(0xff252b2b),
      surfaceContainerHighest: Color(0xff303636),
    );
  }

  ThemeData dark() {
    return theme(darkScheme());
  }

  static ColorScheme darkMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xff84d8de),
      surfaceTint: Color(0xff80d4da),
      onPrimary: Color(0xff001a1c),
      primaryContainer: Color(0xff479da3),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xffb5d0d1),
      onSecondary: Color(0xff001a1b),
      secondaryContainer: Color(0xff7b9597),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xffbacbee),
      onTertiary: Color(0xff031630),
      tertiaryContainer: Color(0xff8091b1),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xffffbab1),
      onError: Color(0xff370001),
      errorContainer: Color(0xffff5449),
      onErrorContainer: Color(0xff000000),
      surface: Color(0xff0e1415),
      onSurface: Color(0xfff6fcfc),
      onSurfaceVariant: Color(0xffc3cdcd),
      outline: Color(0xff9ba5a5),
      outlineVariant: Color(0xff7b8585),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffdde4e4),
      inversePrimary: Color(0xff005054),
      primaryFixed: Color(0xff9cf0f6),
      onPrimaryFixed: Color(0xff001416),
      primaryFixedDim: Color(0xff80d4da),
      onPrimaryFixedVariant: Color(0xff003d40),
      secondaryFixed: Color(0xffcce8e9),
      onSecondaryFixed: Color(0xff001416),
      secondaryFixedDim: Color(0xffb1cccd),
      onSecondaryFixedVariant: Color(0xff213a3c),
      tertiaryFixed: Color(0xffd6e3ff),
      onTertiaryFixed: Color(0xff00112a),
      tertiaryFixedDim: Color(0xffb6c7e9),
      onTertiaryFixedVariant: Color(0xff263652),
      surfaceDim: Color(0xff0e1415),
      surfaceBright: Color(0xff343a3b),
      surfaceContainerLowest: Color(0xff090f10),
      surfaceContainerLow: Color(0xff161d1d),
      surfaceContainer: Color(0xff1a2121),
      surfaceContainerHigh: Color(0xff252b2b),
      surfaceContainerHighest: Color(0xff303636),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme());
  }

  static ColorScheme darkHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffedfeff),
      surfaceTint: Color(0xff80d4da),
      onPrimary: Color(0xff000000),
      primaryContainer: Color(0xff84d8de),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xffedfeff),
      onSecondary: Color(0xff000000),
      secondaryContainer: Color(0xffb5d0d1),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xfffbfaff),
      onTertiary: Color(0xff000000),
      tertiaryContainer: Color(0xffbacbee),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xfffff9f9),
      onError: Color(0xff000000),
      errorContainer: Color(0xffffbab1),
      onErrorContainer: Color(0xff000000),
      surface: Color(0xff0e1415),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xfff3fdfd),
      outline: Color(0xffc3cdcd),
      outlineVariant: Color(0xffc3cdcd),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffdde4e4),
      inversePrimary: Color(0xff003032),
      primaryFixed: Color(0xffa1f5fb),
      onPrimaryFixed: Color(0xff000000),
      primaryFixedDim: Color(0xff84d8de),
      onPrimaryFixedVariant: Color(0xff001a1c),
      secondaryFixed: Color(0xffd1ecee),
      onSecondaryFixed: Color(0xff000000),
      secondaryFixedDim: Color(0xffb5d0d1),
      onSecondaryFixedVariant: Color(0xff001a1b),
      tertiaryFixed: Color(0xffdde7ff),
      onTertiaryFixed: Color(0xff000000),
      tertiaryFixedDim: Color(0xffbacbee),
      onTertiaryFixedVariant: Color(0xff031630),
      surfaceDim: Color(0xff0e1415),
      surfaceBright: Color(0xff343a3b),
      surfaceContainerLowest: Color(0xff090f10),
      surfaceContainerLow: Color(0xff161d1d),
      surfaceContainer: Color(0xff1a2121),
      surfaceContainerHigh: Color(0xff252b2b),
      surfaceContainerHighest: Color(0xff303636),
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
        scaffoldBackgroundColor: colorScheme.surface,
        canvasColor: colorScheme.surface,
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
