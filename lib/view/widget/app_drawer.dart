import 'package:flutter/material.dart';
import 'package:notes_app/controllers/firebase_auth.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
      children: [
        const UserAccountsDrawerHeader(
          decoration: BoxDecoration(color: Color.fromARGB(255, 8, 43, 72)),
          accountName: Text(
            "Hello User",
            style: TextStyle(
              fontSize: 25.0,
              fontWeight: FontWeight.bold,
              letterSpacing: 3,
            ),
          ),
          accountEmail: Text(''),
        ),
        ListTile(
          onTap: () {
            Auth.instance.logout();
          },
          leading: Icon(Icons.logout),
          title: Text('LogOut'),
        )
      ],
    ));
  }
}