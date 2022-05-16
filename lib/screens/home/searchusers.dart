import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:meet_up/screens/home/chatRoom.dart';
import 'package:meet_up/screens/home/searchuserbyInt.dart';
import 'package:meet_up/services/database.dart';
import 'package:meet_up/shared/constants.dart';

import 'conversationdm.dart';

class SearchScr extends StatefulWidget {
  const SearchScr({Key? key}) : super(key: key);

  @override
  _SearchScrState createState() => _SearchScrState();
}

class _SearchScrState extends State<SearchScr> {
  TextEditingController searchTextEditingController = TextEditingController();

  late QuerySnapshot searchSnapshot;
  late final String interest;
  bool pressed = false;

  DatabaseServices databaseServices = DatabaseServices();

  initiateSearch() {
    databaseServices
        .getUserByUsername(
      searchTextEditingController.text,
    )
        .then((val) {
      print(val.toString());
      setState(() {
        searchSnapshot = val;
      });
    });
  }

  ///create chatroom, send user to convo screen, pushReplace

  createChatroomandStartConvo({required String userName}) {
    if (userName != Constants.myName) {
      String chatRoomId = getChatRoomId(userName, Constants.myName);

      List<String> users = [userName, Constants.myName];
      Map<String, dynamic> chatRoomMap = {
        "users": users,
        "chatroomId": chatRoomId
      };

      DatabaseServices().createChatRoom(chatRoomId, chatRoomMap);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => UserConversationDM(chatRoomId)));
      UserName.convoName = userName;
    } else {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              backgroundColor: Colors.green[200],
              title: Text(
                "Unfortunately you cannot chat with yourself.",
                style: TextStyle(color: Colors.black),
              ),
              content: SizedBox(
                height: 130,
                child: Column(
                  children: [
                    Container(
                      child: Image.asset(
                        'assets/barttalk.gif',
                        height: 100,
                        width: 200,
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context, rootNavigator: true).pop('dialog');
                    },
                    child: Text(
                      "Got it!",
                      style: TextStyle(color: Colors.green),
                    ))
              ],
            );
          });
      print("You cannot talk to yourself");
    }
  }

  Widget SearchTile(
      {required String userName,
      required String userEmail,
      required String interest}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    userName,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(10)),
                    padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
                    child: Text(
                      interest,
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 6,
              ),
              Text(userEmail),
            ],
          ),
          Spacer(),
          GestureDetector(
            onTap: () {
              createChatroomandStartConvo(userName: userName);
            },
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.green, borderRadius: BorderRadius.circular(30)),
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 18),
              child: Text(
                "Message",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget searchList() {
    return searchSnapshot != null
        ? ListView.builder(
            itemCount: searchSnapshot.docs.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return SearchTile(
                userName: searchSnapshot.docs[index]["name"],
                userEmail: searchSnapshot.docs[index]["email"],
                interest: searchSnapshot.docs[index]["interest"],
              );
            })
        : Container();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        backgroundColor: Colors.green[200],
                        title: Center(
                            child: Text(
                          "What do I do...?",
                          style: TextStyle(color: Colors.black),
                        )),
                        content: SizedBox(
                          height: 150,
                          child: Column(
                            children: [
                              Container(
                                child: Image.asset(
                                  'assets/whattodo.gif',
                                  height: 100,
                                  width: 100,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Center(
                                child: Text(
                                  "You can search your friends by typing their username.",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                              ),
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
                                style: TextStyle(color: Colors.black),
                              ))
                        ],
                      );
                    });
              },
              icon: Icon(Icons.lightbulb)),
        ],
        backgroundColor: Colors.green,
        elevation: 0,
        title: Text(
          'Find your friends',
        ),
      ),
      body: Container(
        child: Column(
          children: [
            SizedBox(
              height: 15,
            ),
            Row(
              children: [
                SizedBox(width: 5),
                Expanded(
                  child: TextField(
                    controller: searchTextEditingController,
                    decoration: InputDecoration(
                      hintText: "Search by username...",
                      hintStyle: TextStyle(color: Colors.green),
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.grey.shade600,
                        size: 20,
                      ),
                      filled: true,
                      contentPadding: EdgeInsets.all(8),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: Colors.green)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: Colors.green)),
                    ),
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                IconButton(
                  onPressed: () {
                    initiateSearch();

                    pressed = true;

                    print('yes');
                  },
                  padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                  icon: Icon(Icons.search),
                ),
                SizedBox(
                  width: 5,
                )
              ],
            ),
            TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SearchByInterest()));
                },
                child: Text("Dont have friends? Search people by interest!")),
            pressed != false ? Flexible(child: searchList()) : Container(),
          ],
        ),
      ),
    );
  }
}

getChatRoomId(String a, String b) {
  if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
    return "$b\_$a";
  } else {
    return "$a\_$b";
  }
}
