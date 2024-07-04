import 'package:flutter/material.dart';
import 'package:musicapp/screens/splash_screen.dart'; 

void main() {
  runApp(const MyMusicPlayerApp());
}

class MyMusicPlayerApp extends StatelessWidget {
  const MyMusicPlayerApp({super.key}) ;

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home:  SplashScreen(),
    );
  }
}
