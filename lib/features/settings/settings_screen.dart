import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        surfaceTintColor: Theme.of(context).scaffoldBackgroundColor,
        foregroundColor: Theme.of(context).brightness == Brightness.dark 
          ? Colors.white 
          : Colors.black,
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text('Privacy'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => context.push('/settings/privacy'),
          ),
        ],
      ),
    );
  }
}