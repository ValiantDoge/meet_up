import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meet_up/models/user.dart';
import 'package:meet_up/services/database.dart';
import 'package:meet_up/shared/constants.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  ChatUser? _userFromFirebase(User user) {
    return user != null ? ChatUser(uid: user.uid) : null;
  }

  //auth change user stream

  Stream<ChatUser?> get user {
    return _auth
        .authStateChanges()
        .map((User? user) => _userFromFirebase(user!));
  }

  //sign with email
  Future signInwithEmail(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? chatUser = result.user;

      return _userFromFirebase(chatUser!);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //register with email n pass

  Future registerwithEmail(
      String email, String password, String username) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? chatUser = result.user;
      await DatabaseMethods(uid: chatUser!.uid)
          .updateUserData(email, username, 'None');
      return _userFromFirebase(chatUser);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //reset/ forgot pass
  Future resetPass(String email) async {
    try {
      return await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      print(e.toString());
    }
  }

  //sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
