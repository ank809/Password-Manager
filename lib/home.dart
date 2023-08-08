import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:password_manager/constants.dart';
import 'package:password_manager/drawer.dart';
import 'package:password_manager/update.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final userstream = FirebaseFirestore.instance.collection('passwords').snapshots();

 void editData(String documentId, String title, String username, String password) {
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
  // Delete data from firebase 
  void DeleteData(String documentID,String title, String username, String password){
    var collectionRef = FirebaseFirestore.instance.collection('passwords');
    // final docref= 
    collectionRef.doc(documentID).delete();
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
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade400, Colors.green.shade400],
            begin: Alignment.topCenter,
          ),
          
        ),
        padding: EdgeInsets.all(12.0),
        child: StreamBuilder(
          stream: userstream,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Text('Error in reading data');
            }
            if(snapshot.connectionState == ConnectionState.waiting){
              return Center(child: CircularProgressIndicator(),);
            }
            if(!snapshot.hasData || snapshot.data==null){
              return Text('No data found');
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
                        Text(
                          docs[index]['password'], 
                          style:usernamestyle,
                        ), 
                        SizedBox(height: 15.0,),
                         Row(
                          children:[
                          GestureDetector(
                            child:Icon(Icons.edit, color: Colors.blue,),
                           onTap: () {
                            editData(
                              docs[index].id,
                               docs[index]['title'], 
                               docs[index]['username'],
                              docs[index]['password']);
                           }
                          ),
                          SizedBox(width: 16.0,),
                        GestureDetector(
                          child: Icon(Icons.delete, color: Colors.red,),
                          onTap: () {
                           DeleteData(
                            docs[index].id,
                            docs[index]['title'],
                            docs[index]['username'],
                            docs[index]['password']);
                          },
                        )
                          ],
                        ),
                      ],
                    ),
              
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () => Navigator.pushNamed(context, '/password'),
      backgroundColor: Colors.white,
      shape: CircleBorder(eccentricity:0.0),
      child: Icon(Icons.add,
      color: Colors.green,),),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
  
}