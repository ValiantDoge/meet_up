import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:meet_up/services/database.dart';
import 'package:meet_up/shared/constants.dart';

class UserConversationDM extends StatefulWidget {
  final String chatRoomId;

  UserConversationDM(this.chatRoomId);

  @override
  _UserConversationDMState createState() => _UserConversationDMState();
}

class _UserConversationDMState extends State<UserConversationDM> {
  DatabaseServices databaseServices = DatabaseServices();
  TextEditingController messageController = TextEditingController();
  String? _message;

  Stream? chatMessageStream;
  final ScrollController _scrollController = ScrollController();

  _scrollToEnd() async {
    _scrollController.animateTo(_scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 400),
        curve: Curves.fastLinearToSlowEaseIn);
  }

  Widget ChatMessageList() {
    return StreamBuilder(
      stream: chatMessageStream,
      builder: (context, snapshot) {
        WidgetsBinding.instance!.addPostFrameCallback((_) {
          if (_scrollController.hasClients) {
            _scrollController
                .jumpTo(_scrollController.position.maxScrollExtent);
          } else {
            setState(() => null);
          }
        });
        return snapshot.hasData
            ? Container(
                margin: EdgeInsets.only(bottom: 60),
                child: Scrollbar(
                  child: ListView.builder(
                      controller: _scrollController,
                      itemCount: (snapshot.data! as QuerySnapshot).docs.length,
                      itemBuilder: (context, index) {
                        return MessageTile(
                          (snapshot.data! as QuerySnapshot).docs[index]
                              ["message"],
                          (snapshot.data! as QuerySnapshot).docs[index]
                                  ["sendBy"] ==
                              Constants.myName,
                        );
                      }),
                ),
              )
            : Container(
                alignment: Alignment.center,
                child: Text("Say Hi to ${UserName.convoName}!"),
              );
      },
    );
  }

  sendMessage() {
    if (messageController.text.isNotEmpty) {
      Map<String, dynamic> messageMap = {
        "message": messageController.text,
        "sendBy": Constants.myName,
        "time": DateTime.now().millisecondsSinceEpoch
      };
      databaseServices.addConversationMessages(widget.chatRoomId, messageMap);
      messageController.text = "";
      _scrollToEnd();
    }
  }

  @override
  void initState() {
    databaseServices.getConversationMessages(widget.chatRoomId).then((value) {
      setState(() {
        chatMessageStream = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                _scrollToEnd();
              },
              icon: Icon(Icons.arrow_downward_sharp))
        ],
        elevation: 0,
        backgroundColor: Colors.grey[850],
        title: Text(UserName.convoName),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
        child: Container(
          child: Stack(
            children: [
              ChatMessageList(),
              Container(
                alignment: Alignment.bottomCenter,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SizedBox(width: 5),
                    Expanded(
                      child: TextField(
                          controller: messageController,
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
                          }),
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
                          splashColor: Colors.blue, // Splash color
                          onTap: () {
                            sendMessage();
                          },
                          child: SizedBox(
                              width: 48, height: 48, child: Icon(Icons.send)),
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
      ),
    );
  }
}

class MessageTile extends StatelessWidget {
  late final String message;
  final bool isSendByMe;

  MessageTile(this.message, this.isSendByMe);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      padding: EdgeInsets.only(
          left: isSendByMe ? 0 : 10, right: isSendByMe ? 10 : 0),
      width: MediaQuery.of(context).size.width,
      alignment: isSendByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: isSendByMe
                  ? [
                      const Color(0xff169a71),
                      const Color(0xff169a71),
                    ]
                  : [
                      const Color(0xff2d2828),
                      const Color(0xff2d2828),
                    ]),
          borderRadius: isSendByMe
              ? BorderRadius.only(
                  topLeft: Radius.circular(23),
                  topRight: Radius.circular(23),
                  bottomLeft: Radius.circular(23),
                )
              : BorderRadius.only(
                  topLeft: Radius.circular(23),
                  topRight: Radius.circular(23),
                  bottomRight: Radius.circular(23),
                ),
        ),
        child: SelectableText(
          message,
          toolbarOptions: ToolbarOptions(copy: true, selectAll: true),
          scrollPhysics: ClampingScrollPhysics(),
          style: TextStyle(
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
