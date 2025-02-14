import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tournament/pages/home.dart';
import 'package:tournament/pages/player.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _selectedIndex = 0;

  // Screens for navigation
  final List<Widget> _screens = [
    const HomePage(),
    const Center(
        child: Text('Teams Content', style: TextStyle(color: Colors.white))),
    const PlayerScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    // operation();
  }

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
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Tournament",
            style: TextStyle(
              color: Colors.white,
              backgroundColor: Colors.transparent,
              fontSize: 21,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          backgroundColor: const Color(0xFF212121),
        ),
        backgroundColor: const Color(0xFF212121),
        body: _screens[_selectedIndex], // Display selected screen
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          items: [
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/icons/home_24dp_E8EAED_FILL0_wght400_GRAD0_opsz24.svg',
                height: 29,
                width: 29,
                color: _selectedIndex == 0 ? Colors.yellow : Colors.white,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/icons/group_24dp_E8EAED_FILL0_wght400_GRAD0_opsz24.svg',
                height: 29,
                width: 29,
                color: _selectedIndex == 1 ? Colors.yellow : Colors.white,
              ),
              label: 'Teams',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/icons/person_24dp_E8EAED_FILL0_wght400_GRAD0_opsz24.svg',
                height: 29,
                width: 29,
                color: _selectedIndex == 2 ? Colors.yellow : Colors.white,
              ),
              label: 'Players',
            ),
          ],
          backgroundColor: const Color(0xFF212121),
          selectedItemColor: Colors.yellow,
          unselectedItemColor: Colors.white,
          type: BottomNavigationBarType.fixed,
        ),
      ),
    );
  }
}
