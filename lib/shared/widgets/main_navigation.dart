import 'package:flutter/material.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/camera/presentation/pages/camera_page.dart';
import '../../features/maps/presentation/pages/maps_page.dart';
import '../../features/language/presentation/pages/language_page.dart';
import '../../features/profile/presentation/pages/profile_page.dart';
import 'custom_bottom_nav_bar.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _currentIndex = 0;

  List<Widget> get _pages => [
    const HomePage(),
    CameraPage(
      onBackPressed: () {
        setState(() {
          _currentIndex = 0; // Go back to home
        });
      },
    ),
    const MapsPage(),
    const LanguagePage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      // Hide bottom navigation bar when camera is active (index 1)
      bottomNavigationBar: _currentIndex == 1 
          ? null 
          : CustomBottomNavBar(
              currentIndex: _currentIndex,
              onTap: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
            ),
    );
  }
}
