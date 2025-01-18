import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
//import 'login_page.dart';
import 'home_page.dart';
import 'gorav_login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Initialize Firebase
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Firebase OTP',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: GoravLoginPage(),
    );
  }
}
