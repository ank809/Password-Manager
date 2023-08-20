import 'package:firebase_auth/firebase_auth.dart';
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
  String? id;
  final String title;
  final String username;
  final String password;

  PasswordFields(
      {this.title = '', this.username = '', this.password = '', this.id = ''});

  @override
  State<PasswordFields> createState() => _PasswordFieldsState();
}

class _PasswordFieldsState extends State<PasswordFields> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool showProgressIndicator = false;
  bool isobscure = true;
  void hidevisibility() {
    setState(() {
      isobscure = !isobscure;
    });
  }

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
      'email': FirebaseAuth.instance.currentUser!.email
    };

    try {
      //  reference to the Firestore collection where you want to store the data
      final collectionRef = FirebaseFirestore.instance.collection('passwords');

      // Add data to Firestore
      await collectionRef.add(jsonData);

      // Show a success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Password saved ')),
      );

      // Clear the fields after successful saving
      titleController.clear();
      emailController.clear();
      passwordController.clear();
      Navigator.pop(context);
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
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue.shade400, Colors.green.shade400],
          begin: Alignment.topCenter,
        ),
      ),
      padding: EdgeInsets.all(20.0),
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
            const SizedBox(
              height: 25.0,
            ),
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
            const SizedBox(
              height: 25.0,
            ),
            TextField(
              controller: passwordController,
              obscureText: isobscure,
              decoration: InputDecoration(
                  labelText: 'Enter your password',
                  labelStyle: const TextStyle(
                    color: Colors.black,
                    fontSize: 18.0,
                  ),
                  suffixIcon: IconButton(
                    onPressed: hidevisibility,
                    icon: Icon(
                        isobscure ? Icons.visibility : Icons.visibility_off),
                    color: Colors.white,
                  )),
            ),
            const SizedBox(
              height: 25.0,
            ),
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
