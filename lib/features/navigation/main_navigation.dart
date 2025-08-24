import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:threads_clone/features/home/home_screen.dart';
import 'package:threads_clone/features/navigation/placeholder_screen.dart';
import 'package:threads_clone/features/write/write_screen.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const PlaceholderScreen(title: 'Search'),
    const PlaceholderScreen(title: 'Write Thread'),
    const PlaceholderScreen(title: 'Liked Threads'),
    const PlaceholderScreen(title: 'Profile'),
  ];

  void _showWriteScreen() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (context) => const WriteScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: _screens.asMap().entries.map((entry) {
          return Offstage(
            offstage: entry.key != _selectedIndex,
            child: entry.value,
          );
        }).toList(),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: Colors.grey.shade200, width: 0.5),
          ),
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedIndex,
          onTap: (index) {
            if (index == 2) {
              _showWriteScreen();
            } else {
              setState(() {
                _selectedIndex = index;
              });
            }
          },
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.grey.shade500,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          backgroundColor: Colors.white,
          elevation: 0,
          items: const [
            BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.house, size: 24),
              activeIcon: FaIcon(FontAwesomeIcons.house, size: 24),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.magnifyingGlass, size: 24),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.penToSquare, size: 24),
              label: 'Write Thread',
            ),
            BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.heart, size: 24),
              activeIcon: FaIcon(FontAwesomeIcons.solidHeart, size: 24),
              label: 'Liked Threads',
            ),
            BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.user, size: 24),
              activeIcon: FaIcon(FontAwesomeIcons.solidUser, size: 24),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
