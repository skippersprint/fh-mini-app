import 'package:fh_mini_app/services/auth.dart';
import 'package:fh_mini_app/shared/constants.dart';
import 'package:fh_mini_app/utils/widget_functions.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../shared/loading.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key, required this.toggleView});

  final Function toggleView;

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  // key to keeo track of our form's state
  final _formKey = GlobalKey<FormState>();
  // instantiate AuthService
  final AuthService _auth = AuthService();

  bool loading = false;

  late TapGestureRecognizer gestureRecognizer = TapGestureRecognizer()
    ..onTap = () {
      widget.toggleView();
      debugPrint('Register please');
    };

  //text field state
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    
    return SafeArea(
      child: loading
          ? Loading()
          : Scaffold(
              body: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color.fromARGB(255, 164, 197, 175),
                      Color.fromARGB(255, 255, 255, 255),
                    ],
                  )),
                ),
                Container(
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
                    child: Form(
                      key: _formKey,
                      child: Column(children: [
                        addVerticalSpace(20),
                        TextFormField(
                          decoration: textInputDecoration,
                          validator: (value) =>
                              value!.isEmpty ? 'Enter a valid email' : null,
                          onChanged: (val) {
                            setState(() {
                              email = val;
                            });
                          },
                        ),
                        addVerticalSpace(20),
                        TextFormField(
                          decoration: textInputDecoration.copyWith(
                            hintText: 'Password',
                          ),
                          validator: (value) => value!.length < 6
                              ? 'Enter atleast 6 characters'
                              : null,
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
                              if (_formKey.currentState!.validate()) {
                                setState(() {
                                  loading = true;
                                });
                                debugPrint('Sign in valid');
                                dynamic result =
                                    await _auth.signInWithEmailAndPassword(
                                        email, password);
                                if (result == null) {
                                  setState(() {
                                    error =
                                        'Could not sign with those credentials';
                                    loading = false;
                                  });
                                }
                              }
                            },
                            child: Text(
                              'Sign In',
                              style: TextStyle(color: Colors.white),
                            )),
                        addVerticalSpace(12),
                        Text(
                          error,
                          style: TextStyle(color: Colors.red),
                        ),
                        addVerticalSpace(12),

                        //Sign in Anonymously
                        ElevatedButton(
                            onPressed: () async {
                              _auth.signInAnon();
                            },
                            child: Text('Anon')),
                        RichText(
                            text: TextSpan(
                                text: 'Not a memeber? ',
                                style: TextStyle(
                                    color: Color.fromARGB(255, 95, 95, 95)),
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
                    ))
              ],
            )),
    );
  }
}
