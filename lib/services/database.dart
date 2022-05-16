import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meet_up/models/user.dart';

class DatabaseMethods {
  final String? uid;
  DatabaseMethods({required this.uid});

  final CollectionReference userInterest =
      FirebaseFirestore.instance.collection("users");

  Future updateUserData(String email, String username, String interest) async {
    return await userInterest.doc(uid).set({
      "email": email,
      "name": username,
      "interest": interest,
    });
  }

  Future updateUserInterest(String interest) async {
    return await userInterest.doc(uid).update({
      "interest": interest,
    });
  }

  //stream
  Stream<QuerySnapshot> get users {
    return userInterest.snapshots();
  }
}

class DatabaseServices {
  getUserByUsername(String username) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .where("name", isEqualTo: username)
        .get();
  }

  getUserByEmail(String userEmail) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .where("email", isEqualTo: userEmail)
        .get();
  }

  getUserInterest(String interest) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .where("interest", isEqualTo: interest)
        .get();
  }

  createChatRoom(String chatRoomId, chatRoomMap) {
    FirebaseFirestore.instance
        .collection("ChatRoom")
        .doc(chatRoomId)
        .set(chatRoomMap)
        .catchError((e) {
      print(e.toString());
    });
  }

  getConversationMessages(String chatRoomId) async {
    return FirebaseFirestore.instance
        .collection("ChatRoom")
        .doc(chatRoomId)
        .collection("chats")
        .orderBy("time", descending: false)
        .snapshots();
  }

  addConversationMessages(String chatRoomId, messsageMap) async {
    return await FirebaseFirestore.instance
        .collection("ChatRoom")
        .doc(chatRoomId)
        .collection("chats")
        .add(messsageMap)
        .catchError((e) {
      print(e.toString());
    });
  }

  getChatRooms(String userName) async {
    return await FirebaseFirestore.instance
        .collection("ChatRoom")
        .where("users", arrayContains: userName)
        .snapshots();
  }
}
