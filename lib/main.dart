import 'package:fh_mini_app/config/theme.dart';
import 'package:fh_mini_app/screens/landing_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Green Global Aggrovation',
        theme: myAppTheme,
        //darkTheme: ThemeData.dark(),

        home: LandingScreen());
  }
}
