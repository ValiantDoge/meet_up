import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

const textInputDecoration = InputDecoration(
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.green, width: 2),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.green, width: 2.0),
  ),
  hintText: 'Enter your password',
);

InputDecoration textFieldInputDecor(String hintText) {
  return InputDecoration(
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.green, width: 2),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.green, width: 2.0),
    ),
    hintText: hintText,
  );
}

class Constants {
  static String myName = '';
  static String userName = '';
}

class InterestInfo {
  static String interest = '';
}

class InterestColour {
  static Color colour = Colors.green;
  static Color textcolor = Colors.white;
}

class UserName {
  static String username = '';
  static String convoName = '';
}
