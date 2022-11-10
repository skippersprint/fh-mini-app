import 'package:fh_mini_app/screens/authenticate/authenticate.dart';
import 'package:fh_mini_app/screens/home_screen.dart';
import 'package:fh_mini_app/screens/landing_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    //changes in auth are stored in 'user' variable
    final user = Provider.of<User?>(context);
    debugPrint(user.toString());

    //return either landingScreen or authenticate page
    if (user == null) {
      debugPrint("user value null reporting");
      return Authenticate();
    } else {
      return LandingScreen();
    }
  }
}
