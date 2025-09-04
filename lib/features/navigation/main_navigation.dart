import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:threads_clone/features/write/write_screen.dart';

class MainNavigation extends StatefulWidget {
  final Widget child;
  const MainNavigation({super.key, required this.child});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _selectedIndex = 0;

  void _showWriteScreen() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (context) => const WriteScreen(),
    );
  }

  void _onTap(int index) {
    switch (index) {
      case 0:
        context.go('/');
        break;
      case 1:
        context.go('/search');
        break;
      case 2:
        _showWriteScreen();
        return;
      case 3:
        context.go('/activity');
        break;
      case 4:
        context.go('/profile');
        break;
    }
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final location = GoRouterState.of(context).location;
    switch (location) {
      case '/':
        _selectedIndex = 0;
        break;
      case '/search':
        _selectedIndex = 1;
        break;
      case '/activity':
        _selectedIndex = 3;
        break;
      case '/profile':
        _selectedIndex = 4;
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Theme.of(context).brightness == Brightness.dark 
                ? Colors.grey.shade800 
                : Colors.grey.shade200, 
              width: 0.5
            ),
          ),
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedIndex,
          onTap: _onTap,
          selectedItemColor: Theme.of(context).brightness == Brightness.dark 
            ? Colors.white 
            : Colors.black,
          unselectedItemColor: Colors.grey.shade500,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
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
