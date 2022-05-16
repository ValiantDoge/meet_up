import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meet_up/models/user.dart';
import 'package:meet_up/screens/authenticate/helperfunctions.dart';
import 'package:meet_up/screens/authenticate/sign_in.dart';
import 'package:meet_up/services/auth.dart';
import 'package:meet_up/services/database.dart';
import 'package:meet_up/shared/constants.dart';
import 'package:meet_up/shared/load.dart';
import '../../theme.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  Register({required this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController userNameTextEditingController = TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  bool loading = false;

  String username = '';
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
                'Register to MeetUp',
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
                          controller: userNameTextEditingController,
                          validator: (val) => val!.isEmpty
                              ? 'Please enter a valid username'
                              : null,
                          decoration: textFieldInputDecor('Create a Username'),
                          onChanged: (val) {
                            setState(() => username = val);
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: emailTextEditingController,
                          validator: (val) =>
                              RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                      .hasMatch(val!)
                                  ? null
                                  : "Please Enter a valid email",
                          decoration: textFieldInputDecor('Enter your E-mail'),
                          onChanged: (val) {
                            setState(() => email = val);
                          },
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          controller: passwordTextEditingController,
                          validator: (val) => val!.length < 8
                              ? 'Your password needs to be at least 8+ characters.'
                              : null,
                          decoration:
                              textFieldInputDecor('Enter your password'),
                          obscureText: true,
                          onChanged: (val) {
                            setState(() => password = val);
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                SizedBox(
                                  height: 10,
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.green,
                                      onPrimary: Colors.white),
                                  child: Text('Register'),
                                  onPressed: () async {
                                    if (_formKey.currentState!.validate()) {
                                      setState(() {
                                        loading = true;
                                      });

                                      HelperFunctions
                                          .saveUserEmailSharedPreference(
                                              emailTextEditingController.text);
                                      HelperFunctions
                                          .saveUserNameSharedPreference(
                                              userNameTextEditingController
                                                  .text);

                                      dynamic result =
                                          await _auth.registerwithEmail(
                                              email,
                                              password,
                                              userNameTextEditingController
                                                  .text);

                                      if (result == null) {
                                        setState(() {
                                          error = 'Please enter a valid email';
                                          loading = false;
                                        });
                                      }
                                    }
                                  },
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 30,
                            ),
                            Column(
                              children: [
                                Text(
                                  "Already have an account?",
                                  style: TextStyle(
                                    fontSize: 10,
                                  ),
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.green,
                                      onPrimary: Colors.white),
                                  child: Text('Sign in'),
                                  onPressed: () {
                                    widget.toggleView();
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Text(
                          error,
                          style: TextStyle(color: Colors.red, fontSize: 14),
                        )
                      ],
                    ),
                  )),
            ),
          );
  }
}
