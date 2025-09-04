import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:threads_clone/providers/post_provider.dart';
import 'package:threads_clone/router.dart';

void main() {
  runApp(const ThreadsApp());
}

class ThreadsApp extends StatelessWidget {
  const ThreadsApp({super.key});

  @override
  Widget build(BuildContext context) {
    final brightness = MediaQuery.of(context).platformBrightness;
    final isDark = brightness == Brightness.dark;
    
    return ChangeNotifierProvider(
      create: (context) => PostProvider(),
      child: MaterialApp.router(
        title: 'Threads Clone',
        routerConfig: router,
        theme: ThemeData(
          brightness: Brightness.light,
          scaffoldBackgroundColor: Colors.white,
          textTheme: GoogleFonts.poppinsTextTheme(),
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white,
            elevation: 0,
            foregroundColor: Colors.black,
          ),
        ),
        darkTheme: ThemeData(
          brightness: Brightness.dark,
          scaffoldBackgroundColor: Colors.black,
          textTheme: GoogleFonts.poppinsTextTheme(ThemeData.dark().textTheme),
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.black,
            elevation: 0,
            foregroundColor: Colors.white,
          ),
        ),
        themeMode: ThemeMode.system,
      ),
    );
  }
}
