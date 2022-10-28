import 'package:fh_mini_app/models/custom_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //create user obj based on Firebase user
  CustomUser _userFromFireBaseUser(User user) {
    return CustomUser(uid: user.uid);
  }

  //auth change user stream (detects any changes in the authentication of user, constantly)
  // and returns a User obj back -> converted to a custom User obj, use this to determine which screen to show
  Stream<User?> get userStream {
    return _auth.authStateChanges();
  }

  // sign in anonymously
  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      return user;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  // sign in with emial and password

  // register with email and password

  // sign out
  Future signOut() async {
    try {
      debugPrint("trying _auth signout");
      return await _auth.signOut();
      
    } 
    catch (e) {
      debugPrint("Error with _auth signout");
      debugPrint(e.toString());
      return null;
    }
    finally {
        debugPrint("_auth signout successful");
      }
  }
}
