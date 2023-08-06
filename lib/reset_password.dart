import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:password_manager/constants.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final formkey= GlobalKey<FormState>();
  TextEditingController emailController= TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:const  Text('Reset Password',
      style: resetstyle, ),
      backgroundColor: Color.fromARGB(255, 140, 190, 222),),
      body: Container(
        padding: EdgeInsets.all(25.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade400, Colors.green.shade400],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
         mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Recieve an email to \n reset your password. ',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0),),
            SizedBox(height: 40.0,),
            Form(child: 
            TextFormField(
              controller: emailController,
              cursorColor: Colors.white,
              decoration: const InputDecoration(
                labelText: 'Enter your email',
                labelStyle: TextStyle(color: Colors.white, fontSize: 22.0),
                focusedBorder: OutlineInputBorder(),
              ),
              validator: (value) {
                        if (value!.isEmpty ) {
                          return 'Enter an email';
                        }
                        if(!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$').hasMatch(value)){
                          return 'Enter a valid email';
                        }
                        return null;
                      },
            ),
            
            ),
            SizedBox(height: 20.0,),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                minimumSize: Size.fromHeight(40.0),
                backgroundColor: const Color.fromARGB(255, 118, 197, 121),
              ),
              onPressed: (){
                  reset_password();
            }, icon: Icon(Icons.email_outlined), 
            label: Text('Reset Password', style: TextStyle(fontSize: 22.0),)),
          ],
        ),
      )
    );
  }
  Future reset_password () async {
    try{await FirebaseAuth.instance.sendPasswordResetEmail(email: emailController.text.trim());
 ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Password Reset Email Sent '))
 );
  }on   FirebaseAuthException catch(e){
    print(e);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.message.toString()))
 );
  }
  Navigator.of(context).pop();
  }
}