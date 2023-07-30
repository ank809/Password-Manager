import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:password_manager/constants.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final userstream = FirebaseFirestore.instance.collection('passwords').snapshots();

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
      body: Container(
        margin: EdgeInsets.all(12.0),
        child: StreamBuilder(
          stream: userstream,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Text('Error in reading data');
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
                        SizedBox(height: 4.0),
                        Text(
                          docs[index]['username'],
                          style: usernamestyle,
                        ),
                        SizedBox(height: 4.0),
                        Text(
                          docs[index]['password'], 
                          style:usernamestyle,
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
      child: Icon(Icons.add,
      color: Colors.green,),
      backgroundColor: Colors.white,
      shape: CircleBorder(eccentricity:0.0),),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}