import 'package:chat_appv2/auth/Autheticate.dart';
import 'package:chat_appv2/auth/LoginAccount.dart';
import 'package:chat_appv2/auth/createAccount.dart';
import 'package:chat_appv2/screens/homescreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Authenticate(),
      // home: Authenticate(),
    );
  }
}
