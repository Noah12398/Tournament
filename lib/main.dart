import 'package:flutter/material.dart';
import 'package:tournament/pages/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
  theme: ThemeData.dark().copyWith(
    cardColor: Colors.black,
    splashColor: const Color(0xFF212121),
    highlightColor: Colors.transparent,
    scaffoldBackgroundColor: Colors.black,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.black,
      foregroundColor: Colors.white,
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.white),
      bodyMedium: TextStyle(color: Colors.white),
    ),
    sliderTheme: const SliderThemeData(
      activeTrackColor: Colors.amber,
      inactiveTrackColor: Colors.grey,
      thumbColor: Colors.amber,
    ),
  ),
  home: const HomePage(), // Ensure a valid home screen
  debugShowCheckedModeBanner: false, // Removes debug banner
);

  }
}
