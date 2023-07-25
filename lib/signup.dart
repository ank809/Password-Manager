import 'package:flutter/material.dart';

class Sign extends StatefulWidget {
  @override
  State<Sign> createState() => _SignState();
}

class _SignState extends State<Sign> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
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
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 40.0),
            Text(
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
                    // Handle Google login
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
            Text(
              '-- Or create your account with --',
              style: TextStyle(
                fontSize: 20.0,
              ),
            ),
            SizedBox(height: 30.0),
            Expanded(
              flex: 5,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(),
                        fillColor: Colors.white,
                        filled: true,
                        hintText: 'Enter your first name',
                      ),
                    ),
                    SizedBox(height: 30.0),
                    TextFormField(
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(),
                        fillColor: Colors.white,
                        filled: true,
                        hintText: 'Enter your last name',
                      ),
                    ),

                    SizedBox(height: 30.0),
                    TextFormField(
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(),
                        fillColor: Colors.white,
                        filled: true,
                        hintText: 'Enter your email',
                      ),
                    ),

                    SizedBox(height: 70.0),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            // Handle create account action
                          },
                          child: Text(
                            'Create Account',
                            style: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                              fontSize: 22.0,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 233, 226, 226),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
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
