import "package:flutter/material.dart";

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  static MaterialScheme lightScheme() {
    return const MaterialScheme(
      brightness: Brightness.light,
      primary: Color(4287123968),
      surfaceTint: Color(4287123968),
      onPrimary: Color(4280424978),
      primaryContainer: Color(4294945865),
      onPrimaryContainer: Color(4282919168),
      secondary: Color(4285749824),
      onSecondary: Color(4280424978),
      secondaryContainer: Color(4294959557),
      onSecondaryContainer: Color(4284302893),
      tertiary: Color(4280707170),
      onTertiary: Color(4280424978),
      tertiaryContainer: Color(4289786345),
      onTertiaryContainer: Color(4278473549),
      error: Color(4289017679),
      onError: Color(4280424978),
      errorContainer: Color(4294936989),
      onErrorContainer: Color(4283170840),
      background: Color(4294965492),
      onBackground: Color(4280424978),
      surface: Color(4294965492),
      onSurface: Color(4280424978),
      surfaceVariant: Color(4294434504),
      onSurfaceVariant: Color(4283712564),
      outline: Color(4287067233),
      outlineVariant: Color(4292526765),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4281872165),
      inverseOnSurface: Color(4294962912),
      inversePrimary: Color(4294948969),
      primaryFixed: Color(4294958267),
      onPrimaryFixed: Color(4281079552),
      primaryFixedDim: Color(4294948969),
      onPrimaryFixedVariant: Color(4285021440),
      secondaryFixed: Color(4294958268),
      onSecondaryFixed: Color(4280883204),
      secondaryFixedDim: Color(4293050785),
      onSecondaryFixedVariant: Color(4284039722),
      tertiaryFixed: Color(4289654759),
      onTertiaryFixed: Color(4278198301),
      tertiaryFixedDim: Color(4287812299),
      onTertiaryFixedVariant: Color(4278210635),
      surfaceDim: Color(4293449673),
      surfaceBright: Color(4294965492),
      surfaceContainerLowest: Color(4294967295),
      surfaceContainerLow: Color(4294963687),
      surfaceContainer: Color(4294765533),
      surfaceContainerHigh: Color(4294370775),
      surfaceContainerHighest: Color(4293976273),
    );
  }

  ThemeData light() {
    return theme(lightScheme().toColorScheme());
  }

  static MaterialScheme lightMediumContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.light,
      primary: Color(4284627200),
      surfaceTint: Color(4287123968),
      onPrimary: Color(4294967295),
      primaryContainer: Color(4289160448),
      onPrimaryContainer: Color(4294967295),
      secondary: Color(4283776551),
      onSecondary: Color(4294967295),
      secondaryContainer: Color(4287328340),
      onSecondaryContainer: Color(4294967295),
      tertiary: Color(4278209606),
      onTertiary: Color(4294967295),
      tertiaryContainer: Color(4282351481),
      onTertiaryContainer: Color(4294967295),
      error: Color(4286585397),
      onError: Color(4294967295),
      errorContainer: Color(4290923877),
      onErrorContainer: Color(4294967295),
      background: Color(4294965492),
      onBackground: Color(4280424978),
      surface: Color(4294965492),
      onSurface: Color(4280424978),
      surfaceVariant: Color(4294434504),
      onSurfaceVariant: Color(4283449392),
      outline: Color(4285422667),
      outlineVariant: Color(4287330149),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4281872165),
      inverseOnSurface: Color(4294962912),
      inversePrimary: Color(4294948969),
      primaryFixed: Color(4289160448),
      onPrimaryFixed: Color(4294967295),
      primaryFixedDim: Color(4286926848),
      onPrimaryFixedVariant: Color(4294967295),
      secondaryFixed: Color(4287328340),
      onSecondaryFixed: Color(4294967295),
      secondaryFixedDim: Color(4285552446),
      onSecondaryFixedVariant: Color(4294967295),
      tertiaryFixed: Color(4282351481),
      onTertiaryFixed: Color(4294967295),
      tertiaryFixedDim: Color(4280510048),
      onTertiaryFixedVariant: Color(4294967295),
      surfaceDim: Color(4293449673),
      surfaceBright: Color(4294965492),
      surfaceContainerLowest: Color(4294967295),
      surfaceContainerLow: Color(4294963687),
      surfaceContainer: Color(4294765533),
      surfaceContainerHigh: Color(4294370775),
      surfaceContainerHighest: Color(4293976273),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme().toColorScheme());
  }

  static MaterialScheme lightHighContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.light,
      primary: Color(4281670912),
      surfaceTint: Color(4287123968),
      onPrimary: Color(4294967295),
      primaryContainer: Color(4284627200),
      onPrimaryContainer: Color(4294967295),
      secondary: Color(4281409033),
      onSecondary: Color(4294967295),
      secondaryContainer: Color(4283776551),
      onSecondaryContainer: Color(4294967295),
      tertiary: Color(4278200100),
      onTertiary: Color(4294967295),
      tertiaryContainer: Color(4278209606),
      onTertiaryContainer: Color(4294967295),
      error: Color(4283170840),
      onError: Color(4294967295),
      errorContainer: Color(4286585397),
      onErrorContainer: Color(4294967295),
      background: Color(4294965492),
      onBackground: Color(4280424978),
      surface: Color(4294965492),
      onSurface: Color(4278190080),
      surfaceVariant: Color(4294434504),
      onSurfaceVariant: Color(4281213203),
      outline: Color(4283449392),
      outlineVariant: Color(4283449392),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4281872165),
      inverseOnSurface: Color(4294967295),
      inversePrimary: Color(4294961364),
      primaryFixed: Color(4284627200),
      onPrimaryFixed: Color(4294967295),
      primaryFixedDim: Color(4282590720),
      onPrimaryFixedVariant: Color(4294967295),
      secondaryFixed: Color(4283776551),
      onSecondaryFixed: Color(4294967295),
      secondaryFixedDim: Color(4282198291),
      onSecondaryFixedVariant: Color(4294967295),
      tertiaryFixed: Color(4278209606),
      onTertiaryFixed: Color(4294967295),
      tertiaryFixedDim: Color(4278203183),
      onTertiaryFixedVariant: Color(4294967295),
      surfaceDim: Color(4293449673),
      surfaceBright: Color(4294965492),
      surfaceContainerLowest: Color(4294967295),
      surfaceContainerLow: Color(4294963687),
      surfaceContainer: Color(4294765533),
      surfaceContainerHigh: Color(4294370775),
      surfaceContainerHighest: Color(4293976273),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme().toColorScheme());
  }

  static MaterialScheme darkScheme() {
    return const MaterialScheme(
      brightness: Brightness.dark,
      primary: Color(4294954911),
      surfaceTint: Color(4294948969),
      onPrimary: Color(4282919168),
      primaryContainer: Color(4294482185),
      onPrimaryContainer: Color(4281802240),
      secondary: Color(4294967295),
      onSecondary: Color(4282461206),
      secondaryContainer: Color(4294037166),
      onSecondaryContainer: Color(4283513635),
      tertiary: Color(4294967295),
      onTertiary: Color(4278204211),
      tertiaryContainer: Color(4288733401),
      onTertiaryContainer: Color(4278208579),
      error: Color(4294947516),
      onError: Color(4284875300),
      errorContainer: Color(4294144907),
      onErrorContainer: Color(4280614920),
      background: Color(4279898634),
      onBackground: Color(4293976273),
      surface: Color(4279898634),
      onSurface: Color(4293976273),
      surfaceVariant: Color(4283712564),
      onSurfaceVariant: Color(4292526765),
      outline: Color(4288843130),
      outlineVariant: Color(4283712564),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4293976273),
      inverseOnSurface: Color(4281872165),
      inversePrimary: Color(4287123968),
      primaryFixed: Color(4294958267),
      onPrimaryFixed: Color(4281079552),
      primaryFixedDim: Color(4294948969),
      onPrimaryFixedVariant: Color(4285021440),
      secondaryFixed: Color(4294958268),
      onSecondaryFixed: Color(4280883204),
      secondaryFixedDim: Color(4293050785),
      onSecondaryFixedVariant: Color(4284039722),
      tertiaryFixed: Color(4289654759),
      onTertiaryFixed: Color(4278198301),
      tertiaryFixedDim: Color(4287812299),
      onTertiaryFixedVariant: Color(4278210635),
      surfaceDim: Color(4279898634),
      surfaceBright: Color(4282464046),
      surfaceContainerLowest: Color(4279504134),
      surfaceContainerLow: Color(4280424978),
      surfaceContainer: Color(4280753685),
      surfaceContainerHigh: Color(4281477151),
      surfaceContainerHighest: Color(4282200873),
    );
  }

  ThemeData dark() {
    return theme(darkScheme().toColorScheme());
  }

  static MaterialScheme darkMediumContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.dark,
      primary: Color(4294954911),
      surfaceTint: Color(4294948969),
      onPrimary: Color(4281670912),
      primaryContainer: Color(4294482185),
      onPrimaryContainer: Color(4278190080),
      secondary: Color(4294967295),
      onSecondary: Color(4282461206),
      secondaryContainer: Color(4294037166),
      onSecondaryContainer: Color(4281211911),
      tertiary: Color(4294967295),
      onTertiary: Color(4278204211),
      tertiaryContainer: Color(4288733401),
      onTertiaryContainer: Color(4278199329),
      error: Color(4294949057),
      onError: Color(4281729039),
      errorContainer: Color(4294144907),
      onErrorContainer: Color(4278190080),
      background: Color(4279898634),
      onBackground: Color(4293976273),
      surface: Color(4279898634),
      onSurface: Color(4294966008),
      surfaceVariant: Color(4283712564),
      onSurfaceVariant: Color(4292790193),
      outline: Color(4290092939),
      outlineVariant: Color(4287856749),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4293976273),
      inverseOnSurface: Color(4281477151),
      inversePrimary: Color(4285087232),
      primaryFixed: Color(4294958267),
      onPrimaryFixed: Color(4280093952),
      primaryFixedDim: Color(4294948969),
      onPrimaryFixedVariant: Color(4283444736),
      secondaryFixed: Color(4294958268),
      onSecondaryFixed: Color(4280093952),
      secondaryFixedDim: Color(4293050785),
      onSecondaryFixedVariant: Color(4282855963),
      tertiaryFixed: Color(4289654759),
      onTertiaryFixed: Color(4278195219),
      tertiaryFixedDim: Color(4287812299),
      onTertiaryFixedVariant: Color(4278206009),
      surfaceDim: Color(4279898634),
      surfaceBright: Color(4282464046),
      surfaceContainerLowest: Color(4279504134),
      surfaceContainerLow: Color(4280424978),
      surfaceContainer: Color(4280753685),
      surfaceContainerHigh: Color(4281477151),
      surfaceContainerHighest: Color(4282200873),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme().toColorScheme());
  }

  static MaterialScheme darkHighContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.dark,
      primary: Color(4294966008),
      surfaceTint: Color(4294948969),
      onPrimary: Color(4278190080),
      primaryContainer: Color(4294950519),
      onPrimaryContainer: Color(4278190080),
      secondary: Color(4294967295),
      onSecondary: Color(4278190080),
      secondaryContainer: Color(4294037166),
      onSecondaryContainer: Color(4278190080),
      tertiary: Color(4294967295),
      onTertiary: Color(4278190080),
      tertiaryContainer: Color(4288733401),
      onTertiaryContainer: Color(4278190080),
      error: Color(4294965753),
      onError: Color(4278190080),
      errorContainer: Color(4294949057),
      onErrorContainer: Color(4278190080),
      background: Color(4279898634),
      onBackground: Color(4293976273),
      surface: Color(4279898634),
      onSurface: Color(4294967295),
      surfaceVariant: Color(4283712564),
      onSurfaceVariant: Color(4294966008),
      outline: Color(4292790193),
      outlineVariant: Color(4292790193),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4293976273),
      inverseOnSurface: Color(4278190080),
      inversePrimary: Color(4282393344),
      primaryFixed: Color(4294959815),
      onPrimaryFixed: Color(4278190080),
      primaryFixedDim: Color(4294950519),
      onPrimaryFixedVariant: Color(4280553984),
      secondaryFixed: Color(4294959815),
      onSecondaryFixed: Color(4278190080),
      secondaryFixedDim: Color(4293313957),
      onSecondaryFixedVariant: Color(4280488706),
      tertiaryFixed: Color(4289917931),
      onTertiaryFixed: Color(4278190080),
      tertiaryFixedDim: Color(4288075727),
      onTertiaryFixedVariant: Color(4278196760),
      surfaceDim: Color(4279898634),
      surfaceBright: Color(4282464046),
      surfaceContainerLowest: Color(4279504134),
      surfaceContainerLow: Color(4280424978),
      surfaceContainer: Color(4280753685),
      surfaceContainerHigh: Color(4281477151),
      surfaceContainerHighest: Color(4282200873),
    );
  }

  ThemeData darkHighContrast() {
    return theme(darkHighContrastScheme().toColorScheme());
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
      );

  List<ExtendedColor> get extendedColors => [];
}

class MaterialScheme {
  const MaterialScheme({
    required this.brightness,
    required this.primary,
    required this.surfaceTint,
    required this.onPrimary,
    required this.primaryContainer,
    required this.onPrimaryContainer,
    required this.secondary,
    required this.onSecondary,
    required this.secondaryContainer,
    required this.onSecondaryContainer,
    required this.tertiary,
    required this.onTertiary,
    required this.tertiaryContainer,
    required this.onTertiaryContainer,
    required this.error,
    required this.onError,
    required this.errorContainer,
    required this.onErrorContainer,
    required this.background,
    required this.onBackground,
    required this.surface,
    required this.onSurface,
    required this.surfaceVariant,
    required this.onSurfaceVariant,
    required this.outline,
    required this.outlineVariant,
    required this.shadow,
    required this.scrim,
    required this.inverseSurface,
    required this.inverseOnSurface,
    required this.inversePrimary,
    required this.primaryFixed,
    required this.onPrimaryFixed,
    required this.primaryFixedDim,
    required this.onPrimaryFixedVariant,
    required this.secondaryFixed,
    required this.onSecondaryFixed,
    required this.secondaryFixedDim,
    required this.onSecondaryFixedVariant,
    required this.tertiaryFixed,
    required this.onTertiaryFixed,
    required this.tertiaryFixedDim,
    required this.onTertiaryFixedVariant,
    required this.surfaceDim,
    required this.surfaceBright,
    required this.surfaceContainerLowest,
    required this.surfaceContainerLow,
    required this.surfaceContainer,
    required this.surfaceContainerHigh,
    required this.surfaceContainerHighest,
  });

  final Brightness brightness;
  final Color primary;
  final Color surfaceTint;
  final Color onPrimary;
  final Color primaryContainer;
  final Color onPrimaryContainer;
  final Color secondary;
  final Color onSecondary;
  final Color secondaryContainer;
  final Color onSecondaryContainer;
  final Color tertiary;
  final Color onTertiary;
  final Color tertiaryContainer;
  final Color onTertiaryContainer;
  final Color error;
  final Color onError;
  final Color errorContainer;
  final Color onErrorContainer;
  final Color background;
  final Color onBackground;
  final Color surface;
  final Color onSurface;
  final Color surfaceVariant;
  final Color onSurfaceVariant;
  final Color outline;
  final Color outlineVariant;
  final Color shadow;
  final Color scrim;
  final Color inverseSurface;
  final Color inverseOnSurface;
  final Color inversePrimary;
  final Color primaryFixed;
  final Color onPrimaryFixed;
  final Color primaryFixedDim;
  final Color onPrimaryFixedVariant;
  final Color secondaryFixed;
  final Color onSecondaryFixed;
  final Color secondaryFixedDim;
  final Color onSecondaryFixedVariant;
  final Color tertiaryFixed;
  final Color onTertiaryFixed;
  final Color tertiaryFixedDim;
  final Color onTertiaryFixedVariant;
  final Color surfaceDim;
  final Color surfaceBright;
  final Color surfaceContainerLowest;
  final Color surfaceContainerLow;
  final Color surfaceContainer;
  final Color surfaceContainerHigh;
  final Color surfaceContainerHighest;
}

extension MaterialSchemeUtils on MaterialScheme {
  ColorScheme toColorScheme() {
    return ColorScheme(
      brightness: brightness,
      primary: primary,
      onPrimary: onPrimary,
      primaryContainer: primaryContainer,
      onPrimaryContainer: onPrimaryContainer,
      secondary: secondary,
      onSecondary: onSecondary,
      secondaryContainer: secondaryContainer,
      onSecondaryContainer: onSecondaryContainer,
      tertiary: tertiary,
      onTertiary: onTertiary,
      tertiaryContainer: tertiaryContainer,
      onTertiaryContainer: onTertiaryContainer,
      error: error,
      onError: onError,
      errorContainer: errorContainer,
      onErrorContainer: onErrorContainer,
      background: background,
      onBackground: onBackground,
      surface: surface,
      onSurface: onSurface,
      surfaceVariant: surfaceVariant,
      onSurfaceVariant: onSurfaceVariant,
      outline: outline,
      outlineVariant: outlineVariant,
      shadow: shadow,
      scrim: scrim,
      inverseSurface: inverseSurface,
      onInverseSurface: inverseOnSurface,
      inversePrimary: inversePrimary,
    );
  }
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
