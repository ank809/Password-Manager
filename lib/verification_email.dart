import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:password_manager/home.dart';

class VerifyEmailAddress extends StatefulWidget {
  const VerifyEmailAddress({super.key});

  @override
  State<VerifyEmailAddress> createState() => _VerifyEmailAddressState();
}

class _VerifyEmailAddressState extends State<VerifyEmailAddress> {
  bool isEmailVerified = false;
  Timer? timer;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    if (!isEmailVerified) {
      sendVerificationEmail();

      timer = Timer.periodic(
        const Duration(seconds: 3),
        (_) => checkEmailVerified(),
      );
    } else {
     Navigator.pushNamed(context, '/home');
    }
  }
  Future sendVerificationEmail () async {
    try{
    final user = FirebaseAuth.instance.currentUser;
    await user!.sendEmailVerification();
    }catch(e){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('')));
    }
  }


  @override
  void dispose() {
    // TODO: implement dispose

    timer?.cancel();
    super.dispose();
  }

  Future checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser!.reload();
    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });
    if (isEmailVerified) {
      timer?.cancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    return isEmailVerified
        ? Home()
        : Scaffold(
            body: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 100.0)
                          .copyWith(top: 30.0),
                      child: Image.asset('assets/images/mail.png'),
                    ),
                    const Text(
                      'Verify your email address',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 26.0,
                          fontFamily: 'ADLaMDisplay'),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 30.0)
                          .copyWith(top: 30.0),
                      child: const Text(
                        'We have just send email verification link on your email. Please check email and click on that link to verify your email address',
                        style: TextStyle(fontSize: 22.0),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 30.0)
                          .copyWith(top: 15.0),
                      child: const Text(
                        'If not auto redirect after verification, click on the continue button',
                        style: TextStyle(fontSize: 22.0),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 55.0,
                      margin: const EdgeInsets.symmetric(horizontal: 85.0)
                          .copyWith(top: 20.0),
                      child: OutlinedButton(
                        style: ButtonStyle(
                          shape: MaterialStatePropertyAll(
                            ContinuousRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                        ),
                        onPressed: () {
                          isEmailVerified ? Home() : null;
                        },
                        child: const Text(
                          'Continue',
                          style: TextStyle(color: Colors.black, fontSize: 28.0),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 25.0),
                      child: InkWell(
                        onTap: () {
                          Future.delayed(Duration(seconds: 5));
                        },
                        child: const Text(
                          'Resend E-mail link',
                          style: TextStyle(
                              fontSize: 20.0,
                              color: Color.fromARGB(255, 11, 138, 241)),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 25.0),
                      child: TextButton(
                        onPressed: () {},
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.arrow_back),
                            SizedBox(
                              width: 10.0,
                            ),
                            Text(
                              'Back to Login',
                              style: TextStyle(fontSize: 20.0),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}