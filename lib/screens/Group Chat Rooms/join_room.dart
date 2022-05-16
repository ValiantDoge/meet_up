import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meet_up/screens/authenticate/helperfunctions.dart';
import 'package:meet_up/shared/constants.dart';

import 'interestGroupChat.dart';

class JoinRoom extends StatefulWidget {
  const JoinRoom({Key? key}) : super(key: key);

  @override
  _JoinRoomState createState() => _JoinRoomState();
}

class _JoinRoomState extends State<JoinRoom> {
  TextEditingController chatName = TextEditingController();

  Future<String> _getUsername() async {
    final user = FirebaseAuth.instance.currentUser;
    final docSnap = await FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get();
    return docSnap.get('name');
  }

  void _addMessage(String value) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final userName = await _getUsername();
      await FirebaseFirestore.instance.collection("interest_chat").add({
        'author': userName,
        'author_id': user.uid,
        'timestamp': Timestamp.now().millisecondsSinceEpoch,
        'value': value,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Join Art chat room"),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 10,
          ),
          Container(
            alignment: Alignment.center,
            child: SizedBox(
              height: 60,
              width: 100,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Colors.red, onPrimary: Colors.white),
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ArtChat(onSubmit: _addMessage)));
                },
                child: Text(
                  "Join",
                  style: TextStyle(fontSize: 30),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class JoinMusicRoom extends StatefulWidget {
  const JoinMusicRoom({Key? key}) : super(key: key);

  @override
  _JoinMusicRoomState createState() => _JoinMusicRoomState();
}

class _JoinMusicRoomState extends State<JoinMusicRoom> {
  TextEditingController chatName = TextEditingController();

  Future<String> _getUsername() async {
    final user = FirebaseAuth.instance.currentUser;
    final docSnap = await FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get();
    return docSnap.get('name');
  }

  void _addMessage(String value) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final userName = await _getUsername();
      await FirebaseFirestore.instance.collection("interest_chat_2").add({
        'author': userName,
        'author_id': user.uid,
        'timestamp': Timestamp.now().millisecondsSinceEpoch,
        'value': value,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Join Music chat room"),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 10,
          ),
          Container(
            alignment: Alignment.center,
            child: SizedBox(
              height: 60,
              width: 100,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Colors.amber, onPrimary: Colors.white),
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              MusicChat(onSubmit: _addMessage)));
                },
                child: Text(
                  "Join",
                  style: TextStyle(fontSize: 30, color: Colors.black),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class JoinSportsRoom extends StatefulWidget {
  const JoinSportsRoom({Key? key}) : super(key: key);

  @override
  _JoinSportsRoomState createState() => _JoinSportsRoomState();
}

class _JoinSportsRoomState extends State<JoinSportsRoom> {
  TextEditingController chatName = TextEditingController();

  Future<String> _getUsername() async {
    final user = FirebaseAuth.instance.currentUser;
    final docSnap = await FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get();
    return docSnap.get('name');
  }

  void _addMessage(String value) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final userName = await _getUsername();
      await FirebaseFirestore.instance.collection("interest_chat_3").add({
        'author': userName,
        'author_id': user.uid,
        'timestamp': Timestamp.now().millisecondsSinceEpoch,
        'value': value,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Join Sports chat room"),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 10,
          ),
          Container(
            alignment: Alignment.center,
            child: SizedBox(
              height: 60,
              width: 100,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Colors.blue[800], onPrimary: Colors.white),
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              SportsChat(onSubmit: _addMessage)));
                },
                child: Text(
                  "Join",
                  style: TextStyle(fontSize: 30),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class JoinMoviesRoom extends StatefulWidget {
  const JoinMoviesRoom({Key? key}) : super(key: key);

  @override
  _JoinMoviesRoomState createState() => _JoinMoviesRoomState();
}

class _JoinMoviesRoomState extends State<JoinMoviesRoom> {
  TextEditingController chatName = TextEditingController();

  Future<String> _getUsername() async {
    final user = FirebaseAuth.instance.currentUser;
    final docSnap = await FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get();
    return docSnap.get('name');
  }

  void _addMessage(String value) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final userName = await _getUsername();
      await FirebaseFirestore.instance.collection("interest_chat_4").add({
        'author': userName,
        'author_id': user.uid,
        'timestamp': Timestamp.now().millisecondsSinceEpoch,
        'value': value,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Join Movies chat room"),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 10,
          ),
          Container(
            alignment: Alignment.center,
            child: SizedBox(
              height: 60,
              width: 100,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Colors.orange, onPrimary: Colors.white),
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              MoviesChat(onSubmit: _addMessage)));
                },
                child: Text(
                  "Join",
                  style: TextStyle(fontSize: 30),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class JoinGamingRoom extends StatefulWidget {
  const JoinGamingRoom({Key? key}) : super(key: key);

  @override
  _JoinGamingRoomState createState() => _JoinGamingRoomState();
}

class _JoinGamingRoomState extends State<JoinGamingRoom> {
  TextEditingController chatName = TextEditingController();

  Future<String> _getUsername() async {
    final user = FirebaseAuth.instance.currentUser;
    final docSnap = await FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get();
    return docSnap.get('name');
  }

  void _addMessage(String value) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final userName = await _getUsername();
      await FirebaseFirestore.instance.collection("interest_chat_5").add({
        'author': userName,
        'author_id': user.uid,
        'timestamp': Timestamp.now().millisecondsSinceEpoch,
        'value': value,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Join Gaming chat room"),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 10,
          ),
          Container(
            alignment: Alignment.center,
            child: SizedBox(
              height: 60,
              width: 100,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Colors.black, onPrimary: Colors.white),
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              GamingChat(onSubmit: _addMessage)));
                },
                child: Text(
                  "Join",
                  style: TextStyle(fontSize: 30, color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class JoinTechRoom extends StatefulWidget {
  const JoinTechRoom({Key? key}) : super(key: key);

  @override
  _JoinTechRoomState createState() => _JoinTechRoomState();
}

class _JoinTechRoomState extends State<JoinTechRoom> {
  TextEditingController chatName = TextEditingController();

  Future<String> _getUsername() async {
    final user = FirebaseAuth.instance.currentUser;
    final docSnap = await FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get();
    return docSnap.get('name');
  }

  void _addMessage(String value) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final userName = await _getUsername();
      await FirebaseFirestore.instance.collection("interest_chat_6").add({
        'author': userName,
        'author_id': user.uid,
        'timestamp': Timestamp.now().millisecondsSinceEpoch,
        'value': value,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Join Technology chat room"),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 10,
          ),
          Container(
            alignment: Alignment.center,
            child: SizedBox(
              height: 60,
              width: 100,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Colors.purple[800], onPrimary: Colors.white),
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              TechChat(onSubmit: _addMessage)));
                },
                child: Text(
                  "Join",
                  style: TextStyle(fontSize: 30),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class JoinWritingRoom extends StatefulWidget {
  const JoinWritingRoom({Key? key}) : super(key: key);

  @override
  _JoinWritingRoomState createState() => _JoinWritingRoomState();
}

class _JoinWritingRoomState extends State<JoinWritingRoom> {
  TextEditingController chatName = TextEditingController();

  Future<String> _getUsername() async {
    final user = FirebaseAuth.instance.currentUser;
    final docSnap = await FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get();
    return docSnap.get('name');
  }

  void _addMessage(String value) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final userName = await _getUsername();
      await FirebaseFirestore.instance.collection("interest_chat_7").add({
        'author': userName,
        'author_id': user.uid,
        'timestamp': Timestamp.now().millisecondsSinceEpoch,
        'value': value,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Join Writing chat room"),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 10,
          ),
          Container(
            alignment: Alignment.center,
            child: SizedBox(
              height: 60,
              width: 100,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Colors.white, onPrimary: Colors.white),
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              WritingChat(onSubmit: _addMessage)));
                },
                child: Text(
                  "Join",
                  style: TextStyle(fontSize: 30, color: Colors.black),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class JoinFashionRoom extends StatefulWidget {
  const JoinFashionRoom({Key? key}) : super(key: key);

  @override
  _JoinFashionRoomState createState() => _JoinFashionRoomState();
}

class _JoinFashionRoomState extends State<JoinFashionRoom> {
  TextEditingController chatName = TextEditingController();

  Future<String> _getUsername() async {
    final user = FirebaseAuth.instance.currentUser;
    final docSnap = await FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get();
    return docSnap.get('name');
  }

  void _addMessage(String value) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final userName = await _getUsername();
      await FirebaseFirestore.instance.collection("interest_chat_8").add({
        'author': userName,
        'author_id': user.uid,
        'timestamp': Timestamp.now().millisecondsSinceEpoch,
        'value': value,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Join Fashion chat room"),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 10,
          ),
          Container(
            alignment: Alignment.center,
            child: SizedBox(
              height: 60,
              width: 100,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Colors.cyan[800], onPrimary: Colors.white),
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              FashionChat(onSubmit: _addMessage)));
                },
                child: Text(
                  "Join",
                  style: TextStyle(fontSize: 30),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
