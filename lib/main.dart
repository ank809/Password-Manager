import 'package:flutter/material.dart';
import 'package:password_manager/login.dart';
import 'package:password_manager/mainScreen.dart';
import 'package:password_manager/signup.dart';
void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(scaffoldBackgroundColor: const Color.fromARGB(255, 81, 154, 83),
      appBarTheme: AppBarTheme(color: Colors.white)),
      routes: {
        '/login':(context) => Login(),
        '/signup':(context) => Sign(),
      },
      home: MainScreen(),
    );
    }
  }
