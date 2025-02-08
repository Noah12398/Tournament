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
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Quicksand',
        cardColor: Colors.black,
        splashColor: const Color(0xFF212121),
        highlightColor: Colors.transparent,
      ),
      home: const HomePage(),
    );
  }
}
