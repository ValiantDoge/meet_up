import 'package:flutter/material.dart';
import 'package:meet_up/screens/authenticate/sign_in.dart';
import 'package:meet_up/screens/wrapper.dart';
import 'package:meet_up/services/auth.dart';
import 'package:meet_up/theme.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<SettingsScreen> {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        elevation: 0,
        title: Text(
          'Settings',
          style: TextStyle(fontSize: 20),
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextButton.icon(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ChangeTheme()));
                },
                icon: Icon(
                  Icons.lightbulb_outline_sharp,
                  color: Colors.green,
                ),
                label: Text(
                  'Themes',
                  style: TextStyle(fontSize: 17, color: Colors.green),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextButton.icon(
                onPressed: () async {
                  await _auth.signOut();
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => Wrapper()),
                      (route) => false);
                },
                icon: Icon(
                  Icons.logout,
                  color: Colors.green,
                ),
                label: Text(
                  'Log out',
                  style: TextStyle(fontSize: 17, color: Colors.green),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
