import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:password_manager/constants.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController= TextEditingController();
  bool isobscureText=true;
  void toggleobscure(){
    setState(() {
      isobscureText=!isobscureText;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade400, Colors.green.shade400],
            begin: Alignment.topCenter,
          ),
        ),
        child: SingleChildScrollView(
          child: SafeArea(
            child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    alignment: Alignment.topRight,
                    height: 200,
                    width: 200.0,
                    child: Image.asset('Asset/images/white1.png', )),
                ],
              ),
              Center(child: Text('Welcome back !', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40.0),),),
              SizedBox(height: 60.0,),
              Container(
                padding: EdgeInsets.all(10.0),
                margin: EdgeInsets.all(22.0),
                child: TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.email, color: Colors.green,size: 28.0,),
                    hintText: 'Enter your username or email',
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0)),
                  ),
                ),
              ),
              SizedBox(height: 12.0,),
               Container(
                padding: EdgeInsets.all(10.0),
                margin: EdgeInsets.only(left: 22.0, right: 22.0),
                child: TextFormField(
                  obscureText: isobscureText,
                  controller: _passwordController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock, color: Colors.green, size: 30.0,),
                    hintText: 'Enter your password',
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0)),
                    suffixIcon: IconButton(
                      icon:Icon(isobscureText? Icons.visibility: Icons.visibility_off,),
                    onPressed: toggleobscure,
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                TextButton(onPressed: (){
                  Navigator.pushNamed(context, '/reset');
                }, 
                child: Text('Forget Password?', style: buttonStyle1,)),
                SizedBox(height: 18.0,),
            ],
          ),
          SizedBox(height: 15.0,),
          Container(
            margin: EdgeInsets.only(right: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                    Text('Sign In', style: buttonStyle2),
                    SizedBox(width: 8.0,),
                    ElevatedButton(
                      onPressed: (){
                          login();
                    }, 
                    child:Icon(Icons.arrow_forward, color: Colors.black,),
                    style:ElevatedButton.styleFrom(
                     backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0)
                      )),),
                  ],
                  ),
          ),
          SizedBox(height: 90.0,),
         Container(
          margin: EdgeInsets.only(right: 40.0, left: 60.0),
           child: Row(
            children: [
            Text('Don\'t have an account ?', style: TextStyle(fontSize: 16.0)),
            TextButton(onPressed: (){
              Navigator.pushNamed(context, '/signup');
            }, 
            child:Text('Create Account', style: TextStyle(color: Colors.white, fontSize: 16.0),),
            ) 
           ],),
         )
              ],
              ),
        ),
      ),
    ),
    );
  }
  Future<void> login() async {
  try {
    final auth = FirebaseAuth.instance;
    await auth.signInWithEmailAndPassword(
      email: _emailController.text,
      password: _passwordController.text,
    );
    Navigator.pushNamed(context, '/home');
    ScaffoldMessenger.of(context).showSnackBar( const SnackBar(
                       content: Text('Successfully logged in')));
  } on FirebaseAuthException catch (e) {
    if (e.code == 'wrong-password') {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Invalid Password. Please try again'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    } else if (e.code == 'user-not-found') {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('User not found. Please check your email and try again.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    } 
  } 
}


}