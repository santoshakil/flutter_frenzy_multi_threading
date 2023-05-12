import 'package:flutter/material.dart';
import '../constants/colors/colors.dart';

final lightColorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: blue400,
  onPrimary: white,
  primaryContainer: const Color(0xFFD5E3FF),
  onPrimaryContainer: const Color(0xFF001B3C),
  secondary: teal400,
  onSecondary: black87,
  secondaryContainer: const Color(0xFF79F8DC),
  onSecondaryContainer: white,
  tertiary: white, //* done
  onTertiary: black87, //* done
  tertiaryContainer: const Color(0xFFFFDAD9),
  onTertiaryContainer: const Color(0xFF410009),
  error: const Color(0xFFBA1A1A),
  errorContainer: const Color(0xFFFFDAD6),
  onError: const Color(0xFFFFFFFF),
  onErrorContainer: const Color(0xFF410002),
  background: white, //* done
  onBackground: black87, //* done
  surface: const Color(0xFFFFFBFF),
  onSurface: const Color(0xFF030865),
  surfaceVariant: const Color(0xFFE0E2EC),
  onSurfaceVariant: const Color(0xFF43474E),
  outline: const Color(0xFF74777F),
  onInverseSurface: const Color(0xFFF1EFFF),
  inverseSurface: const Color(0xFF1E2578),
  inversePrimary: const Color(0xFFA7C8FF),
  shadow: black87, //* done
  surfaceTint: grey,
  outlineVariant: const Color(0xFFC4C6CF),
  scrim: const Color(0xFF000000),
);

final darkColorScheme = ColorScheme(
  brightness: Brightness.dark,
  primary: blue400,
  onPrimary: white,
  primaryContainer: const Color(0xFF004689),
  onPrimaryContainer: const Color(0xFFD5E3FF),
  secondary: teal400,
  onSecondary: white,
  secondaryContainer: const Color(0xFF005144),
  onSecondaryContainer: const Color(0xFF79F8DC),
  tertiary: blueGrey800, //* done
  onTertiary: white, //* done
  tertiaryContainer: const Color(0xFF920020),
  onTertiaryContainer: const Color(0xFFFFDAD9),
  error: const Color(0xFFFFB4AB),
  errorContainer: const Color(0xFF93000A),
  onError: const Color(0xFF690005),
  onErrorContainer: const Color(0xFFFFDAD6),
  background: blueGrey900, //* done
  onBackground: white, //* done
  surface: const Color(0xFF030865),
  onSurface: const Color(0xFFE0E0FF),
  surfaceVariant: const Color(0xFF43474E),
  onSurfaceVariant: const Color(0xFFC4C6CF),
  outline: const Color(0xFF8E9199),
  onInverseSurface: const Color(0xFF030865),
  inverseSurface: const Color(0xFFE0E0FF),
  inversePrimary: const Color(0xFF005EB3),
  shadow: black87, //* done
  surfaceTint: grey,
  outlineVariant: const Color(0xFF43474E),
  scrim: const Color(0xFF000000),
);
