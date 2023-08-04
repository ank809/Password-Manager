import 'package:flutter/material.dart';
import 'package:password_manager/constants.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key});

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
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.4, // Adjust the height as needed
                child: Center(
                  child: Image.asset('Asset/images/password.png'),
                ),
              ),
              Expanded(
                flex: 5,
                child: Container(
                  margin: EdgeInsets.only(bottom: 50.0, left: 20.0, right: 20.0),
                  padding: EdgeInsets.all(40.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    color: Colors.white,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text('Never Forget A ', style: mainSreentext1),
                      const SizedBox(height: 18.0,),
                      const Text('Password Anymore ', style: mainScreentext2),
                      const SizedBox(height: 90,),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/login');
                        },
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.green,),
                        child: const Text('Login', style: TextStyle(fontSize: 18.0),),
                      ),
                      const SizedBox(height: 30,),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/signup');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 187, 214, 237)),
                        child: const Text('Create Account', style: TextStyle(fontSize: 18.0, color: Colors.green),),
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
