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
      theme: ThemeData(scaffoldBackgroundColor: Colors.green,
      appBarTheme: AppBarTheme(color: Colors.white)),
      routes: {
        '/login':(context) => Login(),
        '/sign':(context) => Sign(),
      },
      home: MainScreen(),
    );
    }
  }
