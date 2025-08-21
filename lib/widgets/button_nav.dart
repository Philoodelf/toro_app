import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:toro_app/const/colors.dart';
import 'package:toro_app/screens/home_screen.dart';
import 'package:toro_app/screens/settings_screen.dart';

class ButtonNav extends StatefulWidget {
  const ButtonNav({super.key});

  @override
  State<ButtonNav> createState() => _ButtonNavState();
}

class _ButtonNavState extends State<ButtonNav> {
  final List<Widget> _screens = const [HomeScreen(), SettingsScreen()];

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: AppColors.mainAppColor,
      body: _screens[_selectedIndex],
      bottomNavigationBar: CurvedNavigationBar(
        color: Color.fromARGB(255, 234, 145, 20),
        backgroundColor: Colors.transparent,
        index: _selectedIndex,
        items: const [
          Icon(Icons.home, size: 35),
          Icon(Icons.settings, size: 35),
        ],
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
