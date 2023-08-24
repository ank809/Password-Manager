import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:password_manager/add_password_page.dart';
import 'package:password_manager/login.dart';
import 'package:password_manager/mainScreen.dart';
import 'package:password_manager/reset_password.dart';
import 'package:password_manager/security_pin.dart';
import 'package:password_manager/signup.dart';
import 'package:password_manager/home.dart';
import 'package:get/get.dart';
import 'package:password_manager/verification_email.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp( MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          '/login': (context) => const Login(),
          '/signup': (context) => const Signup(),
          '/home': (context) => const Home(),
          '/password': (context) => const AddPasswordPage(),
          '/reset': (context) => const ResetPassword(),
          '/mpin': (context) => const Security_Pin(),
          '/getverification':(context)=> VerifyEmailAddress(),
        },
        home: FutureBuilder(
            future: Firebase.initializeApp(),
            builder: ((context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return FirebaseAuth.instance.currentUser != null
                    ? const Home()
                    :const MainScreen();
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            })));
  }
}
