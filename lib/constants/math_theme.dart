// ignore_for_file: non_constant_identifier_names

import 'package:mathematics_ai/constants/color_theme.dart';
import 'package:mathematics_ai/constants/constant_exports.dart';

class MathTheme {
  MathTheme({
    MathColorTheme? ColorTheme,
    MathTextTheme? TextTheme,
  })  : _TextTheme = TextTheme ?? MathTextTheme(),
        _ColorTheme = ColorTheme ?? MathColorTheme();
  final MathColorTheme _ColorTheme;
  final MathTextTheme _TextTheme;

  ThemeData get data => ThemeData(
    primaryColor: _ColorTheme.green,
    fontFamily: _TextTheme.fontFamily,
    colorScheme: colorScheme,
    appBarTheme: appBarTheme,
    scaffoldBackgroundColor: Colors.white,
    textButtonTheme: textButtonThemeData,
    tabBarTheme: tabBarTheme,
    useMaterial3: true,
    textSelectionTheme:TextSelectionThemeData(
    cursorColor: MathColorTheme().green, // Cursor color
    selectionColor: MathColorTheme().green, // Text selection color (highlight)
    selectionHandleColor: MathColorTheme().green, // Handle color
  ));

  ColorScheme get colorScheme => const ColorScheme.light().copyWith(
    primary: _ColorTheme.green,
    secondary: _ColorTheme.primaryColorBlue,
    background: _ColorTheme.white,
    surface: _ColorTheme.white,
    surfaceTint: _ColorTheme.neutral100,
  );

  TextButtonThemeData get textButtonThemeData => TextButtonThemeData(
    style: ButtonStyle(
      overlayColor:
      MaterialStateProperty.all(const Color.fromARGB(18, 0, 0, 0)),
      shape: MaterialStateProperty.all(
        const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
      ),
    ),
  );

  AppBarTheme get appBarTheme => AppBarTheme(
    backgroundColor: _ColorTheme.green,
    foregroundColor: _ColorTheme.white,
    iconTheme: IconThemeData(
      color: MathColorTheme().white,
    ),
  );

  TabBarTheme get tabBarTheme => TabBarTheme(
    labelColor: MathColorTheme().white,
    unselectedLabelColor: Colors.black54,
    labelStyle: MathTextTheme().body.copyWith(
      fontWeight: FontWeights.bold,
    ),
    unselectedLabelStyle: MathTextTheme().body.copyWith(
      fontWeight: FontWeights.medium,
    ),
    indicatorColor: MathColorTheme().white,
    dividerColor: Colors.white,
  );
}
