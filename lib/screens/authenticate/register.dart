import 'package:fh_mini_app/shared/constants.dart';
import 'package:fh_mini_app/shared/loading.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../services/auth.dart';
import '../../utils/widget_functions.dart';

class Register extends StatefulWidget {
  const Register({super.key, required this.toggleView});

  final Function toggleView;
  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  // key to keeo track of our form's state
  final _formKey = GlobalKey<FormState>();
  // instantiate AuthService
  final AuthService _auth = AuthService();

  bool loading = false;

  late TapGestureRecognizer gestureRecognizer = TapGestureRecognizer()
    ..onTap = () {
      widget.toggleView();
    };

  //text field state
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: loading ? Loading() : Scaffold(
          backgroundColor: Colors.brown[100],
          appBar: AppBar(
            backgroundColor: Colors.brown[400],
            elevation: 0.0,
            title: Text('Register to FarmHouse'),
          ),
          body: Container(
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
                    decoration:
                        textInputDecoration.copyWith(hintText: 'Password'),
                    validator: (value) =>
                        value!.length < 6 ? 'Enter atleast 6 characters' : null,
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
                          dynamic result = await _auth
                              .registeredWithEmailAndPassword(email, password);
                          if (result == null) {
                            setState(() {
                              error = 'Please supply a valid email';
                              loading = false;
                            });
                          }
                        }
                      },
                      child: Text(
                        'Register',
                        style: TextStyle(color: Colors.white),
                      )),
                  addVerticalSpace(12),
                  Text(
                    error,
                    style: TextStyle(color: Colors.red),
                  ),
                  addVerticalSpace(20),
                  RichText(
                      text: TextSpan(
                          text: 'Existing memeber? ',
                          style:
                              TextStyle(color: Color.fromARGB(255, 95, 95, 95)),
                          children: <TextSpan>[
                        TextSpan(
                          text: 'Sign In',
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
