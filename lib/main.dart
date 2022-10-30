import 'package:fh_mini_app/config/theme.dart';
import 'package:fh_mini_app/screens/home_screen.dart';
import 'package:fh_mini_app/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

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
              return StreamProvider<User?>.value(
                  value: AuthService().userStream,
                  initialData: null,
                  catchError: null,
                  child: HomePage());
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ));
  }
}
