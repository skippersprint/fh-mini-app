
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //auth change user stream (detects any changes in the authentication of user, constantly)
  // and returns a User obj back, use this to determine which screen to show
  Stream<User?> get userStream {
    return _auth.authStateChanges();
  }

  final FirebaseAuth auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  GoogleSignInAccount? _user;

  // String? inputData() {
  //   final User? user = auth.currentUser;
  //   final String? email = user!.email;
  //   debugPrint(email);
  //   return email;
  // }

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
  Future signInWithEmailAndPassword(String email, password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? emailUser = result.user;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  // register with email and password
  Future registeredWithEmailAndPassword(String email, password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? emailUser = result.user;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  Future googleLogin() async {
    final googleUser = await googleSignIn.signIn();
    if (googleUser == null) return;
    _user = googleUser;

    final googleAuth = await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    await FirebaseAuth.instance.signInWithCredential(credential);
  }

  // sign out
  Future signOut() async {
    try {
      debugPrint("trying _auth signout");
      return await _auth.signOut();
    } catch (e) {
      debugPrint("Error with _auth signout");
      debugPrint(e.toString());
      return null;
    } finally {
      debugPrint("_auth signout successful");
    }
  }
}
