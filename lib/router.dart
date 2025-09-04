import 'package:go_router/go_router.dart';
import 'package:threads_clone/features/activity/activity_screen.dart';
import 'package:threads_clone/features/home/home_screen.dart';
import 'package:threads_clone/features/navigation/main_navigation.dart';
import 'package:threads_clone/features/navigation/placeholder_screen.dart';
import 'package:threads_clone/features/search/search_screen.dart';
import 'package:threads_clone/features/settings/privacy_screen.dart';
import 'package:threads_clone/features/settings/settings_screen.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    ShellRoute(
      builder: (context, state, child) => MainNavigation(child: child),
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const HomeScreen(),
        ),
        GoRoute(
          path: '/search',
          builder: (context, state) => const SearchScreen(),
        ),
        GoRoute(
          path: '/activity',
          builder: (context, state) => const ActivityScreen(),
        ),
        GoRoute(
          path: '/profile',
          builder: (context, state) => const PlaceholderScreen(title: 'Profile'),
        ),
      ],
    ),
    GoRoute(
      path: '/settings',
      builder: (context, state) => const SettingsScreen(),
      routes: [
        GoRoute(
          path: 'privacy',
          builder: (context, state) => const PrivacyScreen(),
        ),
      ],
    ),
  ],
);