import 'package:flutter/material.dart';

class Security_Pin extends StatefulWidget {
  const Security_Pin({Key? key}) : super(key: key);

  @override
  State<Security_Pin> createState() => _SecurityPinState();
}

class _SecurityPinState extends State<Security_Pin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Set your Security Pin"),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade400, Colors.green.shade400],
            begin: Alignment.topCenter,
          ),
        ),
        padding: EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
           const Text(
              'Create a memorable MPIN',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 25.0,
              ),
            ),
            SizedBox(height: 20.0),
           const Text(
              'Your key to unlocking your account securely. Choose something only you\'d know, ensuring both convenience and protection.',
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 30.0),
            Form(
              child: TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Enter your 4-digit MPIN',
                  labelStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                  ),
                  focusedBorder: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                obscureText: true,
                maxLength: 4,
                style: TextStyle(color: Colors.white, fontSize: 18.0),
              ),
            ),
            SizedBox(height: 25.0),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
              child: const Text(
                'Save',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
