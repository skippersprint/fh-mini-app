import 'package:fh_mini_app/screens/landing_page.dart';
import 'package:fh_mini_app/screens/pod_screen.dart.dart';
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

    //return either PodScreen or LandingPage
    if (user == null) {
      debugPrint("user value nulla reporting");
      return LandingPage();
    } else {
      debugPrint("user value not null reporting");
      return PodScreen();
    }
  }
}
