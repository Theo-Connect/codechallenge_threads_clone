import 'package:flutter/material.dart';
import 'package:threads_clone/features/home/home_screen.dart';
import 'package:threads_clone/features/navigation/placeholder_screen.dart';

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
            setState(() {
              _selectedIndex = index;
            });
          },
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.grey.shade500,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          backgroundColor: Colors.white,
          elevation: 0,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined, size: 28),
              activeIcon: Icon(Icons.home, size: 28),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search, size: 28),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.edit_square, size: 28),
              label: 'Write Thread',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite_border, size: 28),
              activeIcon: Icon(Icons.favorite, size: 28),
              label: 'Liked Threads',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline, size: 28),
              activeIcon: Icon(Icons.person, size: 28),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
