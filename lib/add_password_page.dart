import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:password_manager/constants.dart';

class AddPasswordPage extends StatelessWidget {
  const AddPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
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
  final String title;
  final String username;
  final String password;
  PasswordFields({this.title = '', this.username = '', this.password = ''});

  @override
  State<PasswordFields> createState() => _PasswordFieldsState();
}

class _PasswordFieldsState extends State<PasswordFields> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool showProgressIndicator = false;

  @override
  void initState() {
    titleController.text = widget.title;
    emailController.text = widget.username;
    passwordController.text = widget.password;
    super.initState();
  }

  void dispose() {
    titleController.dispose();
    passwordController.dispose();
    emailController.dispose();
    super.dispose();
  }

  void _saveDataToFirestore() async {
    if (passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter the password')),
      );
      return;
    }

    // Data is valid, proceed to save in Firestore
    final jsonData = {
      'title': titleController.text,
      'username': emailController.text,
      'password': passwordController.text,
    };

    try {
      // Get a reference to the Firestore collection where you want to store the data
      final collectionRef = FirebaseFirestore.instance.collection('passwords');

      // Add the data to Firestore
      await collectionRef.add(jsonData);

      // Show a success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Data saved to Firestore')),
      );

      // Clear the fields after successful saving
      titleController.clear();
      emailController.clear();
      passwordController.clear();
    } catch (e) {
      // Show an error message if something goes wrong
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error saving data to Firestore')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: 'Title',
                labelStyle: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 22.0,
                ),
              ),
            ),
            const SizedBox(height: 25.0,),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: 'Enter username or email',
                labelStyle: TextStyle(
                  fontSize: 18.0,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 25.0,),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(
                labelText: 'Enter your password',
                labelStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 18.0,
                ),
              ),
            ),
           const SizedBox(height: 25.0,),
            ElevatedButton(
              onPressed: _saveDataToFirestore,
              child: Text('Save', style: buttonStyle),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
