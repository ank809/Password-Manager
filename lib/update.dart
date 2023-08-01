import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:password_manager/constants.dart';

class UpdateData extends StatefulWidget {
  final String title;
  final String docID;
  final String email;
  final String password;

  UpdateData({required this.title, required this.email, required this.password, required this.docID});

  @override
  State<UpdateData> createState() => _UpdateDataState();
}

class _UpdateDataState extends State<UpdateData> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    titleController.text = widget.title;
    usernameController.text = widget.email;
    passwordController.text = widget.password;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text('Edit Password', style: TextStyle(fontWeight: FontWeight.bold),),
        backgroundColor: Colors.green,),
        body: SingleChildScrollView( // Wrap the Column with SingleChildScrollView
          child: Container(
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
                    controller: usernameController,
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
                    onPressed: updateDatatofirestore,
                    child: Text('Edit', style: buttonStyle),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void updateDatatofirestore() {
    // reference to collection
    var collectionRef = FirebaseFirestore.instance.collection('passwords'); // Fix the collection name

    collectionRef.doc(widget.docID).update({
      'title': titleController.text,
      'username': usernameController.text,
      'password': passwordController.text,
    }).then((_) {
      print('Data updated in Firestore successfully.');
    }).catchError((error) {
      print('Error updating data: $error');
    });
    Navigator.pop(context);
  }
}
