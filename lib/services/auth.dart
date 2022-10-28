import 'package:fh_mini_app/models/custom_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //create user obj based on Firebase user
  CustomUser? _userFromFireBaseUser(User user) {
    return user != null ? CustomUser(uid: user.uid) : null;
  }

  // sign in anonymously
  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User user = result.user!;
      return _userFromFireBaseUser(user);
      
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  // sign in with emial and password

  // register with email and password

  // sign out
}
