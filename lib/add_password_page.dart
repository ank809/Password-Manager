import 'package:flutter/material.dart';

class AddPasswordPage extends StatelessWidget {
  const AddPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Password',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.green,
      ),
      body: PasswordFields(),
    );
  }
}

class PasswordFields extends StatefulWidget {
  const PasswordFields({super.key});

  @override
  State<PasswordFields> createState() => _PasswordFieldsState();
}

class _PasswordFieldsState extends State<PasswordFields> {
  String title = '';
  String username = '';
  String password = '';
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20.0),
      child: Form(
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(
                labelText: 'Title',
                labelStyle: TextStyle(color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 22.0)
              ),
              onChanged: (value) {
                title = value;
              },
            ),
            SizedBox(height: 25.0,),
            TextField(
              decoration: InputDecoration(
                labelText: 'Enter username or email',
                labelStyle: TextStyle(
                  fontSize: 18.0,
                  color: Colors.black
                )),
              onChanged: (value) {
                username = value;
              },
            ),
            SizedBox(height: 25.0,),
            TextField(
              decoration: InputDecoration(labelText: 'Enter your password',
              labelStyle: TextStyle(
                color: Colors.black,
                fontSize: 18.0
              )),
              onChanged: (value) {
                password = value;
              },
            ),
            SizedBox(height: 25.0,),
            ElevatedButton(
              onPressed: () {
                // save logic here with title, username, and password
                print('Title: $title');
                print('Username: $username');
                print('Password: $password');
              },
              child: Text('Save', style: TextStyle(color: Colors.green,
              fontSize: 18.0),),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}
