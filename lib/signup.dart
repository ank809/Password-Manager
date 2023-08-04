import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:password_manager/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:email_validator/email_validator.dart';


class Sign extends StatefulWidget {
  @override
  State<Sign> createState() => _SignState();
}

class _SignState extends State<Sign> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController= TextEditingController();
  TextEditingController _nameController= TextEditingController();
      bool isPasswordvisible=true;
      void togglevisibility(){
        setState(() {
          isPasswordvisible= !isPasswordvisible;
        });
      }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder <User?> (
        stream: FirebaseAuth.instance.authStateChanges(),
        builder:(context, snapshot){
           if (snapshot.hasData) {
          return Home();
        }
      else{
        return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Create Account',
          style: TextStyle(
            fontSize: 28.0,
            fontWeight: FontWeight.bold,
            color: Colors.green,
          ),
        ),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 233, 226, 226),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 40.0),
              const Text(
                'Create an Account with',
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
              SizedBox(height: 30.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconContainer(
                    onPressed: () {
                      signInwithGoogle();
                    },
                    imagePath: 'Asset/images/google3.png',
                    iconSize: 75.0,
                  ),
                  SizedBox(width: 20.0),
                  IconContainer(
                    onPressed: () {
                      // Handle Facebook login
                    },
                    imagePath: 'Asset/images/facebook1.png',
                    iconSize: 80.0,
                  ),
                  SizedBox(width: 20.0),
                  IconContainer(
                    onPressed: () {
                      // Handle Twitter login
                    },
                    imagePath: 'Asset/images/twitter2.png',
                    iconSize: 100.0,
                  ),
                ],
              ),
              SizedBox(height: 50.0),
              const Text(
                '-- Or create your account with --',
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
              SizedBox(height: 30.0),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  focusedBorder: OutlineInputBorder(),
                  fillColor: Colors.white,
                  filled: true,
                  hintText: 'Enter your  name',
                ),
              ),
              SizedBox(height: 30.0),
              TextFormField(
                controller: _emailController,
                decoration:const  InputDecoration(
                  focusedBorder: OutlineInputBorder(),
                  fillColor: Colors.white,
                  filled: true,
                  hintText: 'Enter your email',
                ),
                validator: (value){
                  if (!EmailValidator.validate(value!)) {
                    return 'Invalid email format';
                     }
                        return null;
                },
              ),
              SizedBox(height: 30.0),
              TextFormField(
                obscureText: isPasswordvisible,
                controller: _passwordController,
                decoration:  InputDecoration(
                  focusedBorder: OutlineInputBorder(),
                  fillColor: Colors.white,
                  filled: true,
                  hintText: 'Enter your password',
                  suffixIcon: GestureDetector(
                    onTap: () => togglevisibility(),
                    child: Icon( isPasswordvisible? Icons.visibility: Icons.visibility_off,
                  ) ,
                  ),
                ),
                validator: (value) {
                  if(value!.length<8){
                    return 'Password length should be greater than 8';
                  }
                  return null;
                 },
              ),
              SizedBox(height: 70.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      final auth= FirebaseAuth.instance;
                      auth.createUserWithEmailAndPassword(
                        email: _emailController.text, password: _passwordController.text
                        );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 233, 226, 226),
                    ),
                    child: const Text(
                      'Create Account',
                      style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                        fontSize: 22.0,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
    }
        },
    );
  }
  Future<void> signInwithGoogle() async {
  try {
    GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    if (googleUser == null) {
      // User canceled the sign-in process
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
    // Handle the error or show a friendly message to the user
  }
}
}


class IconContainer extends StatelessWidget {
  final VoidCallback onPressed;
  final String imagePath;
  final double iconSize;

  IconContainer({
    required this.onPressed,
    required this.imagePath,
    required this.iconSize,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: iconSize,
      height: iconSize,
      child: IconButton(
        onPressed: onPressed,
        icon: Image.asset(imagePath),
      ),
    );
  }
}
