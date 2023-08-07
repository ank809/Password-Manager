import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NavBar extends StatefulWidget {

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  void _logout()async {
    try{
      await FirebaseAuth.instance.signOut();
    }catch(e){
      print('Error in logging out');
    }
    Navigator.pushNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.all(0.0),
        children: [
          const UserAccountsDrawerHeader(
            accountName: Text(
              'Ankita',
              style: TextStyle(fontSize: 23.0),
            ),
            accountEmail: Text(
              'ankita8091@gmail.com',
              style: TextStyle(fontSize: 18.0),
            ),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: ClipOval(
                child: Icon(
                  Icons.person,
                  size: 50.0,
                  color: Color.fromARGB(255, 10, 66, 113),
                ),
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.green,
            ),
          ),
          const ListTile(
            leading: Icon(Icons.person),
            title: Text('Upload'),
          ),
         const ListTile(
            leading: Icon(Icons.notification_add),
            title: Text('Notifications'),
          ),
          const ListTile(
            leading: Icon(Icons.share),
            title: Text('Share'),
          ),
          const ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
          ),
          SizedBox(height: 40.0,),
          ListTile(
            title: ElevatedButton.icon(
              onPressed: _logout,
              icon: Icon(Icons.logout),
              label: const Text(
                'Logout',
                style: TextStyle(fontSize: 22.0),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 16, 68, 110), // Customize the button color
              // foregroundColor: Colors.white, // Customize the text color
              ),
            ),
          ),
        ],
      ),
    );
  }
}
