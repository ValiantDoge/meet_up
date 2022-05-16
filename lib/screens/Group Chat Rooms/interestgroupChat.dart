import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meet_up/models/user.dart';
import 'package:meet_up/shared/load.dart';
import 'widgets.dart';

class ArtChat extends StatefulWidget {
  final ValueChanged<String> onSubmit;
  const ArtChat({Key? key, required this.onSubmit}) : super(key: key);

  @override
  _ArtChatState createState() => _ArtChatState();
}

class _ArtChatState extends State<ArtChat> {
  final FirebaseAuth auth = FirebaseAuth.instance;

  TextEditingController _controller = TextEditingController();
  String? _message;
  final ScrollController _scrollController = ScrollController();

  void _pressed() {
    widget.onSubmit(_message!);
    _message = '';
    _controller.clear();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text("Art"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("interest_chat")
                    .orderBy("timestamp")
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data!.docs.isEmpty) {
                      return Center(
                        child: Text(
                          "Oh! it's so lonely in here.",
                          style: TextStyle(fontSize: 20, color: Colors.grey),
                        ),
                      );
                    }

                    return MessageWall(messages: snapshot.data!.docs);
                  }
                  return Loading();
                },
              ),
            ),
            Container(
              child: Stack(
                children: [
                  Container(
                    alignment: Alignment.bottomCenter,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        SizedBox(width: 5),
                        Expanded(
                          child: TextField(
                            controller: _controller,
                            decoration: InputDecoration(
                              hintText: "Type a message",
                              hintStyle: TextStyle(color: Colors.grey.shade500),
                              prefixIcon: Icon(
                                Icons.message,
                                color: Colors.grey.shade600,
                                size: 20,
                              ),
                              filled: true,
                              contentPadding: EdgeInsets.all(8),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide:
                                      BorderSide(color: Colors.grey.shade600)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide:
                                      BorderSide(color: Colors.grey.shade600)),
                            ),
                            minLines: 1,
                            maxLines: 10,
                            onChanged: (value) {
                              setState(() {
                                _message = value;
                              });
                            },
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        ClipOval(
                          child: Material(
                            color: _message == null || _message!.isEmpty
                                ? Colors.blueGrey
                                : Colors.green, // Button color
                            child: InkWell(
                              splashColor: Colors.green, // Splash color
                              onTap: () {
                                _message == null || _message!.isEmpty
                                    ? null
                                    : _pressed();
                              },
                              child: SizedBox(
                                  width: 48,
                                  height: 48,
                                  child: Icon(Icons.send)),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MusicChat extends StatefulWidget {
  final ValueChanged<String> onSubmit;
  const MusicChat({Key? key, required this.onSubmit}) : super(key: key);

  @override
  _MusicChatState createState() => _MusicChatState();
}

class _MusicChatState extends State<MusicChat> {
  final FirebaseAuth auth = FirebaseAuth.instance;

  TextEditingController _controller = TextEditingController();
  String? _message;

  void _pressed() {
    widget.onSubmit(_message!);
    _message = '';
    _controller.clear();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        backgroundColor: Colors.amber,
        title: Text("Music",
            style: TextStyle(
              color: Colors.black,
            )),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
        child: Column(
          children: [
            Expanded(
                child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("interest_chat_2")
                  .orderBy("timestamp")
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data!.docs.isEmpty) {
                    return Center(
                      child: Text(
                        "Oh! it's so lonely in here.",
                        style: TextStyle(fontSize: 20, color: Colors.grey),
                      ),
                    );
                  }
                  return MessageWall(messages: snapshot.data!.docs);
                }
                return Loading();
              },
            )),
            Container(
              child: Stack(
                children: [
                  Container(
                    alignment: Alignment.bottomCenter,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        SizedBox(width: 5),
                        Expanded(
                          child: TextField(
                            controller: _controller,
                            decoration: InputDecoration(
                              hintText: "Type a message",
                              hintStyle: TextStyle(color: Colors.grey.shade500),
                              prefixIcon: Icon(
                                Icons.message,
                                color: Colors.grey.shade600,
                                size: 20,
                              ),
                              filled: true,
                              contentPadding: EdgeInsets.all(8),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide:
                                      BorderSide(color: Colors.grey.shade600)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide:
                                      BorderSide(color: Colors.grey.shade600)),
                            ),
                            minLines: 1,
                            maxLines: 10,
                            onChanged: (value) {
                              setState(() {
                                _message = value;
                              });
                            },
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        ClipOval(
                          child: Material(
                            color: _message == null || _message!.isEmpty
                                ? Colors.blueGrey
                                : Colors.green, // Button color
                            child: InkWell(
                              splashColor: Colors.green, // Splash color
                              onTap: () {
                                _message == null || _message!.isEmpty
                                    ? null
                                    : _pressed();
                              },
                              child: SizedBox(
                                  width: 48,
                                  height: 48,
                                  child: Icon(Icons.send)),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SportsChat extends StatefulWidget {
  final ValueChanged<String> onSubmit;
  const SportsChat({Key? key, required this.onSubmit}) : super(key: key);

  @override
  _SportsChatState createState() => _SportsChatState();
}

class _SportsChatState extends State<SportsChat> {
  final FirebaseAuth auth = FirebaseAuth.instance;

  TextEditingController _controller = TextEditingController();
  String? _message;

  void _pressed() {
    widget.onSubmit(_message!);
    _message = '';
    _controller.clear();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[800],
        title: Text(
          "Sports",
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
        child: Column(
          children: [
            Expanded(
                child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("interest_chat_3")
                  .orderBy("timestamp")
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data!.docs.isEmpty) {
                    return Center(
                      child: Text(
                        "Oh! it's so lonely in here.",
                        style: TextStyle(fontSize: 20, color: Colors.grey),
                      ),
                    );
                  }
                  return MessageWall(messages: snapshot.data!.docs);
                }
                return Loading();
              },
            )),
            Container(
              child: Stack(
                children: [
                  Container(
                    alignment: Alignment.bottomCenter,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        SizedBox(width: 5),
                        Expanded(
                          child: TextField(
                            controller: _controller,
                            decoration: InputDecoration(
                              hintText: "Type a message",
                              hintStyle: TextStyle(color: Colors.grey.shade500),
                              prefixIcon: Icon(
                                Icons.message,
                                color: Colors.grey.shade600,
                                size: 20,
                              ),
                              filled: true,
                              contentPadding: EdgeInsets.all(8),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide:
                                      BorderSide(color: Colors.grey.shade600)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide:
                                      BorderSide(color: Colors.grey.shade600)),
                            ),
                            minLines: 1,
                            maxLines: 10,
                            onChanged: (value) {
                              setState(() {
                                _message = value;
                              });
                            },
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        ClipOval(
                          child: Material(
                            color: _message == null || _message!.isEmpty
                                ? Colors.blueGrey
                                : Colors.green, // Button color
                            child: InkWell(
                              splashColor: Colors.green, // Splash color
                              onTap: () {
                                _message == null || _message!.isEmpty
                                    ? null
                                    : _pressed();
                              },
                              child: SizedBox(
                                  width: 48,
                                  height: 48,
                                  child: Icon(Icons.send)),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MoviesChat extends StatefulWidget {
  final ValueChanged<String> onSubmit;
  const MoviesChat({Key? key, required this.onSubmit}) : super(key: key);

  @override
  _MoviesChatState createState() => _MoviesChatState();
}

class _MoviesChatState extends State<MoviesChat> {
  final FirebaseAuth auth = FirebaseAuth.instance;

  TextEditingController _controller = TextEditingController();
  String? _message;

  void _pressed() {
    widget.onSubmit(_message!);
    _message = '';
    _controller.clear();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text(
          "Movies",
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
        child: Column(
          children: [
            Expanded(
                child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("interest_chat_4")
                  .orderBy("timestamp")
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data!.docs.isEmpty) {
                    return Center(
                      child: Text(
                        "Oh! it's so lonely in here.",
                        style: TextStyle(fontSize: 20, color: Colors.grey),
                      ),
                    );
                  }
                  return MessageWall(messages: snapshot.data!.docs);
                }
                return Loading();
              },
            )),
            Container(
              child: Stack(
                children: [
                  Container(
                    alignment: Alignment.bottomCenter,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        SizedBox(width: 5),
                        Expanded(
                          child: TextField(
                            controller: _controller,
                            decoration: InputDecoration(
                              hintText: "Type a message",
                              hintStyle: TextStyle(color: Colors.grey.shade500),
                              prefixIcon: Icon(
                                Icons.message,
                                color: Colors.grey.shade600,
                                size: 20,
                              ),
                              filled: true,
                              contentPadding: EdgeInsets.all(8),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide:
                                      BorderSide(color: Colors.grey.shade600)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide:
                                      BorderSide(color: Colors.grey.shade600)),
                            ),
                            minLines: 1,
                            maxLines: 10,
                            onChanged: (value) {
                              setState(() {
                                _message = value;
                              });
                            },
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        ClipOval(
                          child: Material(
                            color: _message == null || _message!.isEmpty
                                ? Colors.blueGrey
                                : Colors.green, // Button color
                            child: InkWell(
                              splashColor: Colors.green, // Splash color
                              onTap: () {
                                _message == null || _message!.isEmpty
                                    ? null
                                    : _pressed();
                              },
                              child: SizedBox(
                                  width: 48,
                                  height: 48,
                                  child: Icon(Icons.send)),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GamingChat extends StatefulWidget {
  final ValueChanged<String> onSubmit;
  const GamingChat({Key? key, required this.onSubmit}) : super(key: key);

  @override
  _GamingChatState createState() => _GamingChatState();
}

class _GamingChatState extends State<GamingChat> {
  final FirebaseAuth auth = FirebaseAuth.instance;

  TextEditingController _controller = TextEditingController();
  String? _message;

  void _pressed() {
    widget.onSubmit(_message!);
    _message = '';
    _controller.clear();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          "Gaming",
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
        child: Column(
          children: [
            Expanded(
                child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("interest_chat_5")
                  .orderBy("timestamp")
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data!.docs.isEmpty) {
                    return Center(
                      child: Text(
                        "Oh! it's so lonely in here.",
                        style: TextStyle(fontSize: 20, color: Colors.grey),
                      ),
                    );
                  }
                  return MessageWall(messages: snapshot.data!.docs);
                }
                return Loading();
              },
            )),
            Container(
              child: Stack(
                children: [
                  Container(
                    alignment: Alignment.bottomCenter,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        SizedBox(width: 5),
                        Expanded(
                          child: TextField(
                            controller: _controller,
                            decoration: InputDecoration(
                              hintText: "Type a message",
                              hintStyle: TextStyle(color: Colors.grey.shade500),
                              prefixIcon: Icon(
                                Icons.message,
                                color: Colors.grey.shade600,
                                size: 20,
                              ),
                              filled: true,
                              contentPadding: EdgeInsets.all(8),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide:
                                      BorderSide(color: Colors.grey.shade600)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide:
                                      BorderSide(color: Colors.grey.shade600)),
                            ),
                            minLines: 1,
                            maxLines: 10,
                            onChanged: (value) {
                              setState(() {
                                _message = value;
                              });
                            },
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        ClipOval(
                          child: Material(
                            color: _message == null || _message!.isEmpty
                                ? Colors.blueGrey
                                : Colors.green, // Button color
                            child: InkWell(
                              splashColor: Colors.green, // Splash color
                              onTap: () {
                                _message == null || _message!.isEmpty
                                    ? null
                                    : _pressed();
                              },
                              child: SizedBox(
                                  width: 48,
                                  height: 48,
                                  child: Icon(Icons.send)),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TechChat extends StatefulWidget {
  final ValueChanged<String> onSubmit;
  const TechChat({Key? key, required this.onSubmit}) : super(key: key);

  @override
  _TechChatState createState() => _TechChatState();
}

class _TechChatState extends State<TechChat> {
  final FirebaseAuth auth = FirebaseAuth.instance;

  TextEditingController _controller = TextEditingController();
  String? _message;

  void _pressed() {
    widget.onSubmit(_message!);
    _message = '';
    _controller.clear();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple[800],
        title: Text(
          "Technology",
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
        child: Column(
          children: [
            Expanded(
                child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("interest_chat_6")
                  .orderBy("timestamp")
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data!.docs.isEmpty) {
                    return Center(
                      child: Text(
                        "Oh! it's so lonely in here.",
                        style: TextStyle(fontSize: 20, color: Colors.grey),
                      ),
                    );
                  }
                  return MessageWall(messages: snapshot.data!.docs);
                }
                return Loading();
              },
            )),
            Container(
              child: Stack(
                children: [
                  Container(
                    alignment: Alignment.bottomCenter,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        SizedBox(width: 5),
                        Expanded(
                          child: TextField(
                            controller: _controller,
                            decoration: InputDecoration(
                              hintText: "Type a message",
                              hintStyle: TextStyle(color: Colors.grey.shade500),
                              prefixIcon: Icon(
                                Icons.message,
                                color: Colors.grey.shade600,
                                size: 20,
                              ),
                              filled: true,
                              contentPadding: EdgeInsets.all(8),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide:
                                      BorderSide(color: Colors.grey.shade600)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide:
                                      BorderSide(color: Colors.grey.shade600)),
                            ),
                            minLines: 1,
                            maxLines: 10,
                            onChanged: (value) {
                              setState(() {
                                _message = value;
                              });
                            },
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        ClipOval(
                          child: Material(
                            color: _message == null || _message!.isEmpty
                                ? Colors.blueGrey
                                : Colors.green, // Button color
                            child: InkWell(
                              splashColor: Colors.green, // Splash color
                              onTap: () {
                                _message == null || _message!.isEmpty
                                    ? null
                                    : _pressed();
                              },
                              child: SizedBox(
                                  width: 48,
                                  height: 48,
                                  child: Icon(Icons.send)),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class WritingChat extends StatefulWidget {
  final ValueChanged<String> onSubmit;
  const WritingChat({Key? key, required this.onSubmit}) : super(key: key);

  @override
  _WritingState createState() => _WritingState();
}

class _WritingState extends State<WritingChat> {
  final FirebaseAuth auth = FirebaseAuth.instance;

  TextEditingController _controller = TextEditingController();
  String? _message;

  void _pressed() {
    widget.onSubmit(_message!);
    _message = '';
    _controller.clear();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title: Text("Writing", style: TextStyle(color: Colors.black)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
        child: Column(
          children: [
            Expanded(
                child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("interest_chat_7")
                  .orderBy("timestamp")
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data!.docs.isEmpty) {
                    return Center(
                      child: Text(
                        "Oh! it's so lonely in here.",
                        style: TextStyle(fontSize: 20, color: Colors.grey),
                      ),
                    );
                  }
                  return MessageWall(messages: snapshot.data!.docs);
                }
                return Loading();
              },
            )),
            Container(
              child: Stack(
                children: [
                  Container(
                    alignment: Alignment.bottomCenter,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        SizedBox(width: 5),
                        Expanded(
                          child: TextField(
                            controller: _controller,
                            decoration: InputDecoration(
                              hintText: "Type a message",
                              hintStyle: TextStyle(color: Colors.grey.shade500),
                              prefixIcon: Icon(
                                Icons.message,
                                color: Colors.grey.shade600,
                                size: 20,
                              ),
                              filled: true,
                              contentPadding: EdgeInsets.all(8),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide:
                                      BorderSide(color: Colors.grey.shade600)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide:
                                      BorderSide(color: Colors.grey.shade600)),
                            ),
                            minLines: 1,
                            maxLines: 10,
                            onChanged: (value) {
                              setState(() {
                                _message = value;
                              });
                            },
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        ClipOval(
                          child: Material(
                            color: _message == null || _message!.isEmpty
                                ? Colors.blueGrey
                                : Colors.green, // Button color
                            child: InkWell(
                              splashColor: Colors.green, // Splash color
                              onTap: () {
                                _message == null || _message!.isEmpty
                                    ? null
                                    : _pressed();
                              },
                              child: SizedBox(
                                  width: 48,
                                  height: 48,
                                  child: Icon(Icons.send)),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FashionChat extends StatefulWidget {
  final ValueChanged<String> onSubmit;
  const FashionChat({Key? key, required this.onSubmit}) : super(key: key);

  @override
  _FashionState createState() => _FashionState();
}

class _FashionState extends State<FashionChat> {
  final FirebaseAuth auth = FirebaseAuth.instance;

  TextEditingController _controller = TextEditingController();
  String? _message;

  void _pressed() {
    widget.onSubmit(_message!);
    _message = '';
    _controller.clear();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan[800],
        title: Text("Fashion"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
        child: Column(
          children: [
            Expanded(
                child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("interest_chat_8")
                  .orderBy("timestamp")
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data!.docs.isEmpty) {
                    return Center(
                      child: Text(
                        "Oh! it's so lonely in here.",
                        style: TextStyle(fontSize: 20, color: Colors.grey),
                      ),
                    );
                  }
                  return MessageWall(messages: snapshot.data!.docs);
                }
                return Loading();
              },
            )),
            Container(
              child: Stack(
                children: [
                  Container(
                    alignment: Alignment.bottomCenter,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        SizedBox(width: 5),
                        Expanded(
                          child: TextField(
                            controller: _controller,
                            decoration: InputDecoration(
                              hintText: "Type a message",
                              hintStyle: TextStyle(color: Colors.grey.shade500),
                              prefixIcon: Icon(
                                Icons.message,
                                color: Colors.grey.shade600,
                                size: 20,
                              ),
                              filled: true,
                              contentPadding: EdgeInsets.all(8),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide:
                                      BorderSide(color: Colors.grey.shade600)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide:
                                      BorderSide(color: Colors.grey.shade600)),
                            ),
                            minLines: 1,
                            maxLines: 10,
                            onChanged: (value) {
                              setState(() {
                                _message = value;
                              });
                            },
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        ClipOval(
                          child: Material(
                            color: _message == null || _message!.isEmpty
                                ? Colors.blueGrey
                                : Colors.green, // Button color
                            child: InkWell(
                              splashColor: Colors.green, // Splash color
                              onTap: () {
                                _message == null || _message!.isEmpty
                                    ? null
                                    : _pressed();
                              },
                              child: SizedBox(
                                  width: 48,
                                  height: 48,
                                  child: Icon(Icons.send)),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
