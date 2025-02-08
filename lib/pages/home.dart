import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tournament/pages/player.dart'; // Import the PlayerScreen

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  // Define a list of screens
  final List<Widget> _screens = [
    const Center(child: Text('Home Content', style: TextStyle(color: Colors.white))),
    const Center(child: Text('Teams Content', style: TextStyle(color: Colors.white))),
    const PlayerScreen(), // Add PlayerScreen here
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      backgroundColor: const Color(0xFF212121),
      body: _screens[_selectedIndex], // Show content based on the selected index
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
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: const Text(
        "Tournament",
        style: TextStyle(
          color: Colors.white,
          backgroundColor: Colors.transparent,
          fontSize: 21,
          fontWeight: FontWeight.bold,
        ),
      ),
      leading: Container(
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: const Color(0xFF212121),
          borderRadius: BorderRadius.circular(12),
        ),
        alignment: Alignment.center,
        child: SvgPicture.asset(
          'assets/icons/settings_24dp_E8EAED_FILL0_wght400_GRAD0_opsz24.svg',
          height: 29,
          width: 29,
        ),
      ),
      centerTitle: true,
      backgroundColor: const Color(0xFF212121),
    );
  }
}
