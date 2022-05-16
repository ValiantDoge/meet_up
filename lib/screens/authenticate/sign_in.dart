import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:meet_up/screens/authenticate/authenticate.dart';
import 'package:meet_up/screens/authenticate/helperfunctions.dart';
import 'package:meet_up/screens/authenticate/register.dart';
import 'package:meet_up/screens/authenticate/resetpassword.dart';
import 'package:meet_up/services/auth.dart';
import 'package:meet_up/services/database.dart';
import 'package:meet_up/shared/constants.dart';
import 'package:meet_up/shared/load.dart';
import 'package:meet_up/theme.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({required this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  // late QuerySnapshot snapshotUserInfo;

  bool loading = false;
  late QuerySnapshot snapshotUserInfo;

  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
  DatabaseServices databaseServices = DatabaseServices();

  //text feild state
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            appBar: AppBar(
              actions: [
                IconButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ChangeTheme()));
                  },
                  icon: Icon(Icons.settings),
                ),
              ],
              backgroundColor: Colors.green,
              elevation: 0,
              title: Text(
                'Sign in to MeetUp',
              ),
              centerTitle: true,
            ),
            body: SingleChildScrollView(
              child: Container(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
                  child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/meetup1.png',
                            height: 100,
                            width: 300,
                            fit: BoxFit.fitWidth,
                          ),
                          SizedBox(height: 20),
                          TextFormField(
                            controller: emailTextEditingController,
                            validator: (val) =>
                                RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                        .hasMatch(val!)
                                    ? null
                                    : "Please Enter a valid email",
                            decoration:
                                textFieldInputDecor('Enter your E-mail'),
                            onChanged: (val) {
                              setState(() => email = val);
                            },
                          ),
                          SizedBox(height: 20),
                          TextFormField(
                            controller: passwordTextEditingController,
                            validator: (val) =>
                                val!.length < 8 ? 'Invalid password.' : null,
                            decoration:
                                textFieldInputDecor('Enter your password'),
                            obscureText: true,
                            onChanged: (val) {
                              setState(() => password = val);
                            },
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            error,
                            style: TextStyle(color: Colors.red, fontSize: 14),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                children: [
                                  SizedBox(height: 10),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        primary: Colors.green,
                                        onPrimary: Colors.white),
                                    child: Text('Sign in'),
                                    onPressed: () async {
                                      if (_formKey.currentState!.validate()) {
                                        setState(() {
                                          loading = true;
                                        });

                                        dynamic result = await _auth
                                            .signInwithEmail(email, password);

                                        HelperFunctions
                                            .saveUserEmailSharedPreference(
                                                email);

                                        databaseServices
                                            .getUserByEmail(email)
                                            .then((val) {
                                          snapshotUserInfo = val;

                                          HelperFunctions
                                              .saveUserNameSharedPreference(
                                                  snapshotUserInfo.docs[0]
                                                      ["name"]);
                                        });

                                        HelperFunctions
                                            .saveuserLoggedinSharedPreference(
                                                true);

                                        if (result == null) {
                                          setState(() {
                                            error = 'Invalid Credentials!';
                                            loading = false;
                                          });
                                        }
                                      }
                                    },
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 40,
                              ),
                              Column(
                                children: [
                                  Text(
                                    "Don't have an account?",
                                    style: TextStyle(
                                      fontSize: 10,
                                    ),
                                  ),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        primary: Colors.green,
                                        onPrimary: Colors.white),
                                    child: Text('Register'),
                                    onPressed: () {
                                      widget.toggleView();
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Divider(
                            color: Colors.green,
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          GestureDetector(
                            child: Container(
                              child: Padding(
                                padding: const EdgeInsets.all(8),
                                child: Text('Forgot Password?'),
                              ),
                            ),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ResetScreen(),
                                  ));
                              print('I forgor');
                            },
                          ),
                        ],
                      ))),
            ),
          );
  }
}
