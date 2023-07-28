import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Passwords',
        style: TextStyle(color: Colors.white,
        fontWeight: FontWeight.bold),),
      backgroundColor: Colors.green,
      ),
      body: Container(
        margin: EdgeInsets.all(15.0),
        child: Align(
          alignment: Alignment.bottomRight,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
            FloatingActionButton(onPressed: (){
              Navigator.pushNamed(context, '/password');
            },
            child: Icon(Icons.add,color: Colors.green,),
            backgroundColor: Colors.white,
            )
          ]),
        ),
      ),
    );
  }
}