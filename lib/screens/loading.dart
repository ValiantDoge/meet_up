import 'dart:async';
import 'package:flutter/material.dart';
import 'package:meet_up/screens/home/home.dart';
import 'package:meet_up/screens/wrapper.dart';
import 'authenticate/authenticate.dart';
import 'package:provider/provider.dart';
import 'package:meet_up/models/user.dart';

class Loadingscr extends StatefulWidget {
  const Loadingscr({Key? key}) : super(key: key);

  @override
  _LoadingscrState createState() => _LoadingscrState();
}

class _LoadingscrState extends State<Loadingscr> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (_) => Wrapper()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF25D55F),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/meetup_white.png',
              height: 300,
            ),
            SizedBox(
              height: 20,
            ),
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            )
          ],
        ),
      ),
    );
  }
}
