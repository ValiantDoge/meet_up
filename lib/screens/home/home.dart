import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meet_up/models/user.dart';
import 'package:meet_up/screens/Group%20Chat%20Rooms/interestgroupChat.dart';
import 'package:meet_up/screens/Group%20Chat%20Rooms/join_room.dart';
import 'package:meet_up/screens/home/chatRoom.dart';
import 'package:meet_up/screens/home/searchusers.dart';
import 'package:meet_up/screens/home/settings.dart';
import 'package:meet_up/services/auth.dart';
import 'package:meet_up/services/database.dart';
import 'package:meet_up/shared/constants.dart';
import 'package:meet_up/theme.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthService _auth = AuthService();
  String interest = InterestInfo.interest;
  String intInfo = '';
  String int = 'Select your interest below!';
  Color colour = InterestColour.colour;
  Color colorr = Colors.green;
  Color txtcolour = InterestColour.textcolor;
  Color txtcolorr = Colors.white;

  final FirebaseAuth auth = FirebaseAuth.instance;

  Future newInterest(String interest) async {
    var user = await FirebaseAuth.instance.currentUser!;
    var uid = user.uid;
    await DatabaseMethods(uid: user.uid).updateUserInterest(interest);
  }

  void changeInterest() {
    setState(() {
      int = intInfo;
      colour = colorr;
      txtcolour = txtcolorr;
    });
  }

  Future<String> _getUsername() async {
    final user = FirebaseAuth.instance.currentUser;
    final docSnap = await FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get();

    return docSnap.get('name');
  }

  String _name = '';

  @override
  void initState() {
    super.initState();
    if (_name == '') {
      _getUsername().then((String value) => setState(() {
            _name = value;
          }));
    }
  }

  Widget build(BuildContext context) {
    String userName = _name;
    final quotelist = [
      "Hey look who's here, it's $userName!",
      "It's elementary, my dear $userName.",
      "It's a Bird, It's a plane, It's $userName!",
      "Hello $userName, we meet again!",
      "May the force be with you $userName!",
      "Carpe diem. Seize the day, $userName!"
    ];

    final quote = (quotelist..shuffle()).first;

    return StreamProvider<QuerySnapshot?>.value(
      value: DatabaseMethods(uid: null).users,
      initialData: null,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          elevation: 0,
          title: Text(
            'Welcome to MeetUp!',
          ),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SettingsScreen()));
              },
              icon: Icon(Icons.settings),
            ),
          ],
        ),
        body: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Container(
                padding: EdgeInsets.all(20.0),
                child: Center(
                  child: Text(
                    quote,
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                  ),
                )),
            Row(
              children: [
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Conversations()));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(15)),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Center(
                            child: Text(
                          "Your Chats",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        )),
                      ),
                    ),
                  ),
                ))
              ],
            ),
            SizedBox(
              height: 8,
            ),
            Row(
              children: [
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15),
                                topRight: Radius.circular(15))),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Center(
                              child: Text(
                            "Your Interest",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          )),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(15),
                                bottomRight: Radius.circular(15))),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Center(
                            child: Container(
                              decoration: BoxDecoration(
                                  color: colorr,
                                  borderRadius: BorderRadius.circular(10)),
                              padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
                              child: Text(
                                "$int",
                                style: TextStyle(
                                    color: txtcolorr,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ))
              ],
            ),
            Divider(
              color: Colors.green,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                "Select your interest to join a Chat Room.",
                style: TextStyle(fontSize: 20, color: Colors.green),
              ),
            ),
            Divider(
              color: Colors.green,
            ),
            Flexible(
                child: GridView(
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              children: [
                InkResponse(
                  child: Container(
                    child: Image.asset('assets/art.png'),
                    margin: EdgeInsets.all(5),
                    color: Colors.red[800],
                  ),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => JoinRoom()));
                    txtcolorr = Colors.white;
                    colorr = Colors.red;
                    intInfo = 'Art';
                    InterestInfo.interest = intInfo;
                    newInterest(intInfo);
                    changeInterest();
                    print(InterestInfo.interest);
                  },
                ),
                InkResponse(
                  child: Container(
                    child: Image.asset('assets/f.png'),
                    margin: EdgeInsets.all(5),
                    color: Colors.yellowAccent[700],
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => JoinMusicRoom()));
                    txtcolorr = Colors.black;
                    colorr = Colors.yellowAccent;
                    intInfo = 'Music';
                    InterestInfo.interest = intInfo;
                    newInterest(intInfo);
                    changeInterest();
                    print(InterestInfo.interest);
                  },
                ),
                InkResponse(
                  child: Container(
                    child: Image.asset('assets/sports.png'),
                    margin: EdgeInsets.all(5),
                    color: Colors.blue[800],
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => JoinSportsRoom()));
                    txtcolorr = Colors.white;
                    colorr = Colors.blue;
                    intInfo = 'Sports';
                    InterestInfo.interest = intInfo;
                    newInterest(intInfo);
                    changeInterest();
                    print(InterestInfo.interest);
                  },
                ),
                InkResponse(
                  child: Container(
                    child: Image.asset('assets/movies.png'),
                    margin: EdgeInsets.all(5),
                    color: Colors.orange[800],
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => JoinMoviesRoom()));
                    txtcolorr = Colors.white;
                    intInfo = 'Movies';
                    colorr = Colors.orange;
                    InterestInfo.interest = intInfo;
                    newInterest(intInfo);
                    changeInterest();
                    print(InterestInfo.interest);
                  },
                ),
                InkResponse(
                  child: Container(
                    child: Image.asset('assets/gaming.png'),
                    margin: EdgeInsets.all(5),
                    color: Colors.black,
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => JoinGamingRoom()));
                    txtcolorr = Colors.white;
                    colorr = Colors.black;
                    intInfo = 'Gaming';
                    InterestInfo.interest = intInfo;
                    newInterest(intInfo);
                    changeInterest();
                    print(InterestInfo.interest);
                  },
                ),
                InkResponse(
                  child: Container(
                    child: Image.asset('assets/tech.png'),
                    margin: EdgeInsets.all(5),
                    color: Colors.purple[800],
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => JoinTechRoom()));
                    txtcolorr = Colors.white;
                    colorr = Colors.purple;
                    intInfo = 'Technology';
                    InterestInfo.interest = intInfo;
                    newInterest(intInfo);
                    changeInterest();
                    print(InterestInfo.interest);
                  },
                ),
                InkResponse(
                  child: Container(
                      child: Image.asset('assets/writting.png'),
                      margin: EdgeInsets.all(5),
                      color: Colors.white),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => JoinWritingRoom()));
                    txtcolorr = Colors.black;
                    colorr = Colors.white;
                    intInfo = 'Writting';
                    InterestInfo.interest = intInfo;
                    newInterest(intInfo);
                    changeInterest();
                    print(InterestInfo.interest);
                  },
                ),
                InkResponse(
                  child: Container(
                      child: Image.asset('assets/fashion.png'),
                      margin: EdgeInsets.all(5),
                      color: Colors.cyan[800]),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => JoinFashionRoom()));
                    txtcolorr = Colors.white;
                    colorr = Colors.cyan;
                    intInfo = 'Fashion';
                    InterestInfo.interest = intInfo;
                    newInterest(intInfo);
                    changeInterest();
                    print(InterestInfo.interest);
                  },
                ),
              ],
            ))
          ],
        ),
      ),
    );
  }
}
