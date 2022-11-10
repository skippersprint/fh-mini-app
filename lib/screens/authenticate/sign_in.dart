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
    final Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: loading
          ? Loading()
          : Scaffold(
              resizeToAvoidBottomInset: false,
              body: Container(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
                  child: Form(
                    key: _formKey,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              SizedBox(
                                height: size.height * 0.06,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset("assets/images/botanix.png"),
                                    Text(
                                      'Botanix  ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 22),
                                    )
                                  ],
                                ),
                              ),
                              Text(' Food Unlimited Network !')
                            ],
                          ),
                          addVerticalSpace(20),
                          //Text('Your email address'),

                          Container(
                            child: Column(children: [
                              TextFormField(
                                decoration: textInputDecoration.copyWith(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 20),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                    borderSide: BorderSide(
                                        color: Color.fromARGB(255, 83, 83, 83),
                                        width: 1.6),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                    borderSide: BorderSide(
                                      color: Color.fromARGB(255, 83, 83, 83),
                                      width: 1.0,
                                    ),
                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                      borderSide: BorderSide(
                                          color:
                                              Color.fromARGB(255, 66, 66, 66),
                                          width: 5)),
                                ),
                                validator: (value) => value!.isEmpty
                                    ? 'Enter a valid email'
                                    : null,
                                onChanged: (val) {
                                  setState(() {
                                    email = val;
                                  });
                                },
                              ),
                              addVerticalSpace(20),
                              TextFormField(
                                decoration: textInputDecoration.copyWith(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 20),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                    borderSide: BorderSide(
                                        color: Color.fromARGB(255, 83, 83, 83),
                                        width: 1.6),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                    borderSide: BorderSide(
                                      color: Color.fromARGB(255, 83, 83, 83),
                                      width: 1.0,
                                    ),
                                  ),
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
                              SizedBox(
                                width: double.infinity,
                                height: size.height * 0.054,
                                child: ElevatedButton(
                                    style: ButtonStyle(
                                        elevation: MaterialStateProperty.all(3),
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Color.fromARGB(
                                                    255, 177, 245, 138)),
                                        shape: MaterialStateProperty.all<
                                                RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(28.0),
                                        ))),
                                    onPressed: () async {
                                      if (_formKey.currentState!.validate()) {
                                        setState(() {
                                          loading = true;
                                        });
                                        debugPrint('Sign in valid');
                                        dynamic result = await _auth
                                            .signInWithEmailAndPassword(
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
                                      style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 59, 59, 59)),
                                    )),
                              ),
                              addVerticalSpace(12),
                              Text(
                                error,
                                style: TextStyle(color: Colors.red),
                              ),

                              addVerticalSpace(12),

                              //Sign in Anonymously
                              // ElevatedButton(
                              //     onPressed: () async {
                              //       _auth.signInAnon();
                              //     },
                              //     child: Text('Anon')),
                              RichText(
                                  text: TextSpan(
                                      text: 'Not a member? ',
                                      style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 95, 95, 95)),
                                      children: <TextSpan>[
                                    TextSpan(
                                      text: 'Register',
                                      style: const TextStyle(
                                          color:
                                              Color.fromARGB(255, 34, 34, 34),
                                          fontWeight: FontWeight.w600),
                                      recognizer: gestureRecognizer,
                                    )
                                  ])),
                              addVerticalSpace(20),

                              Text('or'),
                              addVerticalSpace(22),

                              SizedBox(
                                width: double.infinity,
                                height: size.height * 0.054,
                                child: ElevatedButton(
                                    style: ButtonStyle(

                                        //elevation: MaterialStateProperty.all(3),
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Color.fromARGB(
                                                    255, 248, 248, 248)),
                                        shape: MaterialStateProperty.all<
                                                RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(28.0),
                                        ))),
                                    onPressed: () async {
                                      if (_formKey.currentState!.validate()) {
                                        setState(() {
                                          loading = true;
                                        });
                                        debugPrint('Sign in valid');
                                        dynamic result = await _auth
                                            .signInWithEmailAndPassword(
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
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(12.0),
                                          child: Image.asset(
                                              "assets/images/search.png"),
                                        ),
                                        Text(
                                          'Sign up with Google',
                                          style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 59, 59, 59)),
                                        ),
                                      ],
                                    )),
                              ),
                            ]),
                          ),

                          addVerticalSpace(100)
                        ]),
                  )),
            ),
    );
  }
}
