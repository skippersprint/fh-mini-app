import 'package:fh_mini_app/services/auth.dart';
import 'package:fh_mini_app/utils/widget_functions.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key, required this.toggleView});

  final Function toggleView;

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  // instantiate AuthService
  final AuthService _auth = AuthService();

  late TapGestureRecognizer gestureRecognizer = TapGestureRecognizer()
    ..onTap = () {
      widget.toggleView();
      debugPrint('Register please');
    };

  //text field state
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.brown[100],
          appBar: AppBar(
            backgroundColor: Colors.brown[400],
            elevation: 0.0,
            title: Text('Sign in to FarmHouse'),
          ),
          body: Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
              child: Form(
                child: Column(children: [
                  addVerticalSpace(20),
                  TextFormField(
                    onChanged: (val) {
                      setState(() {
                        email = val;
                      });
                    },
                  ),
                  addVerticalSpace(20),
                  TextFormField(
                    obscureText: true,
                    onChanged: (val) {
                      setState(() {
                        password = val;
                      });
                    },
                  ),
                  addVerticalSpace(20),
                  ElevatedButton(
                      onPressed: () async {
                        debugPrint(email);
                        debugPrint(password);
                      },
                      child: Text(
                        'Sign In',
                        style: TextStyle(color: Colors.white),
                      )),
                  addVerticalSpace(20),
                  ElevatedButton(
                      onPressed: () async {
                        _auth.signInAnon();
                      },
                      child: Text('Anon')),
                  RichText(
                      text: TextSpan(
                          text: 'Not a memeber? ',
                          style:
                              TextStyle(color: Color.fromARGB(255, 95, 95, 95)),
                          children: <TextSpan>[
                        TextSpan(
                          text: 'Register',
                          style: const TextStyle(
                              color: Color.fromARGB(255, 34, 34, 34),
                              fontWeight: FontWeight.w600),
                          recognizer: gestureRecognizer,
                        )
                      ]))
                ]),
              ))),
    );
  }
}
