import 'package:fh_mini_app/config/theme.dart';
import 'package:fh_mini_app/screens/landing_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _firebaseApp = Firebase.initializeApp();
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Green Global Aggrovation',
        theme: myAppTheme,
        //darkTheme: ThemeData.dark(),

        home: FutureBuilder(
          future: _firebaseApp,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              debugPrint('Error occured with firebase app');
              return Text('Error with FBI');
            } else if (snapshot.hasData) {
              return LandingScreen();
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ));
  }
}
