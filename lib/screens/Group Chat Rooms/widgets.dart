import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meet_up/shared/load.dart';

class MessageWall extends StatefulWidget {
  final List<QueryDocumentSnapshot> messages;

  MessageWall({Key? key, required this.messages}) : super(key: key);

  @override
  _MessageWallState createState() => _MessageWallState();
}

class _MessageWallState extends State<MessageWall> {
  final _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    Timer(
      Duration(milliseconds: 100),
      () => _controller.jumpTo(_controller.position.maxScrollExtent),
    );
    return Scrollbar(
      child: ListView.builder(
          controller: _controller,
          shrinkWrap: true,
          itemCount: widget.messages.length,
          itemBuilder: (context, index) {
            final data =
                (widget.messages[index].data() as Map<String, dynamic>);
            final user = FirebaseAuth.instance.currentUser;

            if (user != null && user.uid == data['author_id']) {
              return ChatMessageInterest(index: index, data: data);
            }

            return ChatMessageOther(
              index: index,
              data: data,
            );
          }),
    );
  }
}

class ChatMessageOther extends StatelessWidget {
  final int index;
  final Map<String, dynamic> data;

  const ChatMessageOther({
    Key? key,
    required this.index,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 5, right: 11, top: 8, bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 7,
          ),
          Container(
            constraints: BoxConstraints(maxWidth: 300),
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            decoration: BoxDecoration(
                color: Colors.black, borderRadius: BorderRadius.circular(23)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SelectableText(
                  "${data['author']} said:",
                  toolbarOptions: ToolbarOptions(copy: true, selectAll: true),
                  scrollPhysics: ClampingScrollPhysics(),
                  style: TextStyle(
                    color: Colors.blue,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                SelectableText(
                  data['value'],
                  toolbarOptions: ToolbarOptions(copy: true, selectAll: true),
                  scrollPhysics: ClampingScrollPhysics(),
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class ChatMessageInterest extends StatelessWidget {
  final int index;
  final Map<String, dynamic> data;
  const ChatMessageInterest({Key? key, required this.index, required this.data})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            constraints: BoxConstraints(maxWidth: 300),
            decoration: BoxDecoration(
                color: Color(0xff169a71),
                borderRadius: BorderRadius.circular(23)),
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            child: SelectableText(data['value'],
                toolbarOptions: ToolbarOptions(copy: true, selectAll: true),
                scrollPhysics: ClampingScrollPhysics(),
                style: TextStyle(fontSize: 18)),
          )
        ],
      ),
    );
  }
}
