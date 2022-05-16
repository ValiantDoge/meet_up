import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meet_up/shared/constants.dart';

class ResetScreen extends StatefulWidget {
  const ResetScreen({Key? key}) : super(key: key);

  @override
  _ResetScreenState createState() => _ResetScreenState();
}

class _ResetScreenState extends State<ResetScreen> {
  late String _email;
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text("Reset your password"),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 30,
          ),
          Row(
            children: [
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      _email = value;
                    });
                  },
                  decoration: textFieldInputDecor("Enter your email"),
                ),
              ),
              SizedBox(
                width: 10,
              ),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: Colors.green, onPrimary: Colors.white),
              onPressed: () {
                auth.sendPasswordResetEmail(email: _email);

                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        backgroundColor: Colors.green[200],
                        title: Text(
                          "Password reset E-mail sent!",
                          style: TextStyle(color: Colors.black),
                        ),
                        content: SizedBox(
                          height: 150,
                          child: Column(
                            children: [
                              Container(
                                child: Image.asset(
                                  'assets/resetmail.gif',
                                  height: 100,
                                  width: 200,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Check your Inbox for the link to reset your password.",
                                style: TextStyle(color: Colors.black),
                              )
                            ],
                          ),
                        ),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.of(context, rootNavigator: true)
                                    .pop('dialog');
                              },
                              child: Text(
                                "Got it!",
                                style: TextStyle(color: Colors.green),
                              ))
                        ],
                      );
                    });
              },
              child: Text("Submit"))
        ],
      ),
    );
  }
}
