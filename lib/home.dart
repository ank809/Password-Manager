import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:password_manager/constants.dart';
import 'package:password_manager/drawer.dart';
import 'package:password_manager/update.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final User? userId = FirebaseAuth.instance.currentUser;
  bool isPasswordVisible = false;
  String correctPin = '1234';
  Map<String, bool> passwordVisibilityMap = {};

// This function is used to edit the collection which user has saved
  void editData(
      String documentId, String title, String username, String password) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UpdateData(
          docID: documentId,
          title: title,
          email: username,
          password: password,
        ),
      ),
    );
  }

  // Used to delete the data
  void deleteData(String documentID) {
    var collectionRef = FirebaseFirestore.instance.collection('passwords');
    collectionRef.doc(documentID).delete();
  }

  // This function is used see the password only when user enters the correct pin
  void _togglePasswordVisibility(
      String documentId, BuildContext context) async {
    final pin = await _showPinDialog(context);
    if (pin == correctPin) {
      setState(() {
        passwordVisibilityMap[documentId] =
            !(passwordVisibilityMap[documentId] ?? false);
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Incorrect PIN')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Saved Passwords',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.green,
      ),
      drawer: NavBar(),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade400, Colors.green.shade400],
            begin: Alignment.topCenter,
          ),
        ),
        padding: EdgeInsets.all(12.0),
        child: StreamBuilder(
          // Used to get the data of the user who has currently logged in
          stream: userId != null
              ? FirebaseFirestore.instance
                  .collection("passwords")
                  .where('email', isEqualTo: userId!.email)
                  .snapshots()
              : Stream.empty(),
          builder: (context, snapshot) {
            try {
              if (snapshot.hasError) {
                log("Error is reading data");
                return const Text('Error in reading data');
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                // log(FirebaseAuth.instance.currentUser.email);
                log('loading...');
                print(FirebaseAuth.instance.currentUser);
                return const Center(
                    child: CircularProgressIndicator(
                  color: Colors.amber,
                ));
              }
              if (!snapshot.hasData || snapshot.data == null) {
                return Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.transparent,
                  child:const  Text(
                    'No data found',
                    style: TextStyle(fontSize: 20.0),
                  ),
                );
              }

              var docs = snapshot.data!.docs;

              return ListView.builder(
                itemCount: docs.length,
                itemBuilder: (context, index) {
                  return Container(
                    padding: EdgeInsets.all(16.0),
                    margin: EdgeInsets.symmetric(vertical: 8.0),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 193, 185, 185),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          docs[index]['title'],
                          style: titlestyle,
                        ),
                        SizedBox(height: 15.0),
                        Text(
                          docs[index]['username'],
                          style: usernamestyle,
                        ),
                        SizedBox(height: 15.0),
                        TextFormField(
                          obscureText:
                              !(passwordVisibilityMap[docs[index].id] ?? false),
                          controller: TextEditingController(
                              text: docs[index]['password']),
                          style: usernamestyle,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.zero,
                            labelText: 'Password',
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  _togglePasswordVisibility(
                                      docs[index].id, context);
                                });
                              },
                              icon: Icon(
                                isPasswordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Colors.green,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 15.0),
                        Row(
                          children: [
                            GestureDetector(
                              child: Icon(Icons.edit, color: Colors.blue),
                              onTap: () {
                                editData(
                                    docs[index].id,
                                    docs[index]['title'],
                                    docs[index]['username'],
                                    docs[index]['password']);
                              },
                            ),
                            SizedBox(width: 16.0),
                            GestureDetector(
                              child: Icon(Icons.delete, color: Colors.red),
                              onTap: () {
                                deleteData(docs[index].id);
                              },
                            )
                          ],
                        ),
                      ],
                    ),
                  );
                },
              );
            } catch (e) {
              return Text('Error: $e');
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/password'),
        backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
        shape: const CircleBorder(eccentricity: 0.0),
        child: const Icon(
          Icons.add,
          color: Colors.green,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  // It is used to show  a dialog box when user tries to see the password
  Future<String?> _showPinDialog(BuildContext context) async {
    TextEditingController pinController = TextEditingController();
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Enter Security PIN'),
          content: TextField(
            controller: pinController,
            keyboardType: TextInputType.number,
            obscureText: true,
            maxLength: 4,
            decoration: InputDecoration(labelText: 'PIN'),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop(pinController.text);
              },
            ),
          ],
        );
      },
    );
  }
}
