import 'package:fh_mini_app/config/cutom_theme.dart';
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
        theme: CustomTheme.lightTheme,
        // darkTheme: ThemeData.dark().copyWith(
        //   colorScheme: const ColorScheme(
        //     primary: Color.fromARGB(255, 235, 235, 235),
        //     secondary: Color.fromARGB(255, 134, 134, 134),
        //     error: Color(0xb71c1cff),
        //     surface: Color.fromRGBO(255, 255, 255, 1.0),
        //     onPrimary: Color.fromRGBO(255, 255, 255, 1.0),
        //     background: Color.fromRGBO(198, 218, 231, 1.0),
        //     onSecondary: Color.fromRGBO(255, 255, 255, 1.0),
        //     onError: Color.fromRGBO(255, 255, 255, 1.0),
        //     brightness: Brightness.dark,
        //     onBackground: Color(0x000000FF),
        //     onSurface: Color(0x000000FF),
        //   ),
        //   textTheme: screenHeight < 1000 ? textThemeSmall : textThemeDefault,
        // ),
        //themeMode: ThemeMode.dark,
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
