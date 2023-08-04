import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
// import 'package:password_manager/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:email_validator/email_validator.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  bool isPasswordVisible = true;

  void toggleVisibility() {
    setState(() {
      isPasswordVisible = !isPasswordVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade400, Colors.green.shade400],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all( 30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Create Account',
                  style: TextStyle(
                    fontSize: 40.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 60.0),
                TextFormField(
                  controller: _nameController,
                  keyboardType: TextInputType.text,
                  decoration: const  InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    labelText: 'Enter your name',
                    labelStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                    ),
                    prefixIcon: Icon(Icons.person_2, size: 30.0),
                    prefixIconColor: Colors.green,
                  ),
                ),
                SizedBox(height: 30.0),
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    labelText: 'Enter your email',
                    labelStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                    ),
                    prefixIcon: Icon(Icons.email, size: 30.0),
                    prefixIconColor: Colors.green,
                  ),
                  validator: (value) {
                    if(value!.isEmpty){
                      return 'Please enter a email';
                    }
                  },
                ),
                SizedBox(height: 30.0),
                TextFormField(
                  controller: _passwordController,
                  keyboardType: TextInputType.numberWithOptions(),
                  obscureText: isPasswordVisible,
                  decoration: InputDecoration(
                    focusedBorder:const  OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    labelText: 'Enter your password',
                    labelStyle:const TextStyle(
                      color: Colors.black,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                    ),
                    prefixIcon: Icon(Icons.lock, size: 30.0),
                    prefixIconColor: Colors.green,
                    suffixIcon: IconButton(
                      icon: Icon(isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off),
                      onPressed: toggleVisibility,
                    ),
                  ),
                  validator: (value) {
                    if(value!.length<8){
                      return 'Please enter 8 digit long password';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 50.0),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.green,
                    backgroundColor: Colors.white,
                    minimumSize: Size(300.0, 50.0),
                  ),
                  onPressed: () {
                    if(_passwordController.text.isNotEmpty && _passwordController.text.length>=8){
                       final auth= FirebaseAuth.instance;
                      auth.createUserWithEmailAndPassword(
                        email: _emailController.text, 
                        password: _passwordController.text
                        );
                    }
                    else {
           ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Please fix the errors in the form')),
          );
          Navigator.pushNamed(context, '/home');
        }
                  },
                  child: const Text(
                    'Sign Up',
                    style: TextStyle(fontSize: 20.0),)),
                    SizedBox(height: 30.0,),
                const Center(
                  child: Text(
                    '-- Or create your account with --',
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(height: 30.0),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.green,
                     backgroundColor: Colors.white,
                    minimumSize: Size(300.0, 50.0),
                  ),
                  onPressed: () {
                    signInwithGoogle();
                  },
                  icon: Image.asset(
                    'Asset/images/google.png',
                    width: 45.0,
                    height: 45.0,
                  ),
                  label: const Text(
                    'Continue with Google',
                    style: TextStyle(fontSize: 20.0),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> signInwithGoogle() async {
  try {
    GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    if (googleUser == null) {
      return;
    }
    GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    AuthCredential credential = GoogleAuthProvider.credential(
      idToken: googleAuth.idToken,
      accessToken: googleAuth.accessToken,
    );
    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);
    User? user = userCredential.user;
    if (user != null) {
      Navigator.pushNamed(context, '/home');
    }
    print(user?.displayName);
  } catch (e) {
    print('Error logging in: $e');
  }
}
}