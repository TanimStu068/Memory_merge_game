import 'package:flutter/material.dart';
import 'package:memory_match_game/constants/colors.dart';
import 'package:memory_match_game/screens/splash_screen.dart';

class MemoryMatchApp extends StatelessWidget {
  const MemoryMatchApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Memory Match Game',
      theme: ThemeData(
        primaryColor: MainColor.primaryColor,
        scaffoldBackgroundColor: MainColor.backgroundColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const SplashScreen(),
    );
  }
}
