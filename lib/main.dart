import 'package:fh_mini_app/config/custom_theme.dart';
import 'package:fh_mini_app/models/ui_mode.dart';
import 'package:fh_mini_app/screens/authenticate/authenticate.dart';
import 'package:fh_mini_app/screens/wrapper.dart';
import 'package:fh_mini_app/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Future<FirebaseApp> _firebaseApp = Firebase.initializeApp();

  

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => UIModeModel()..initialize(),
        builder: (context, _) {
          //will be refering to UiModeModel with uiTheme
          final uiTheme = Provider.of<UIModeModel>(context);
          debugPrint("Your mode value is : ${uiTheme.getModeValue}");
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Green Global Aggrovation',
              theme: uiTheme.getModeValue
                  ? CustomTheme.darkTheme
                  : CustomTheme.lightTheme,
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
                        child: Wrapper());
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ));
        });
  }
}
