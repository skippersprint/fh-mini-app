import 'package:fh_mini_app/screens/landing_screen.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    //return either landingScreen or authenticate page
    return LandingScreen();
  }
}