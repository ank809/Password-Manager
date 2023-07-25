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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
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
                    prefixIcon: Icon(Icons.email),
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
                  controller: _passwordController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock),
                    hintText: 'Enter your password',
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0)),
                    suffixIcon:Icon(Icons.remove_red_eye),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                TextButton(onPressed: (){}, 
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
                    ElevatedButton(onPressed: (){
                      Navigator.pushNamed(context, '/signup');
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
    );
  }
}