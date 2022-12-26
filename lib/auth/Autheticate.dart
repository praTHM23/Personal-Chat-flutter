// import 'package:chat_app/Screens/HomeScreen.dart';
// import 'package:chat_app/Authenticate/LoginScree.dart';
import 'package:chat_appv2/auth/LoginAccount.dart';
import 'package:chat_appv2/screens/homescreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Authenticate extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    if (_auth.currentUser != null) {
      // return HomeScreen();
      print(_auth);
      return HomeScreen();
    } else {
      print(_auth.currentUser);
      return LoginScreen();
      // return LoginScreen();
    }
  }
}
