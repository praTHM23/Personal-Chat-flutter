import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

final FirebaseAuth auth = FirebaseAuth.instance;

class ChatRoom extends StatelessWidget {
  // const ChatRoom({super.key});

  final TextEditingController _message = TextEditingController();

  var user;
  final String RoomId;
  ChatRoom({required this.RoomId, required this.user});
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void onSendMessage() async {
    if (_message.text.isNotEmpty) {
      Map<String, dynamic> messages = {
        "sendby": auth.currentUser!.displayName!,
        "message": _message.text,
        "type": "text",
        "time": FieldValue.serverTimestamp(),
      };

      _message.clear();
      await _firestore
          .collection('chatroom')
          .doc(RoomId)
          .collection('chats')
          .add(messages);
    } else {
      print("Enter Some Text");
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          title: Text(user),
        ),
        body: SingleChildScrollView(
            child: Column(
          children: [
            Container(
              height: size.height / 1.25,
              width: size.width,
              child: StreamBuilder<QuerySnapshot>(
                stream: _firestore
                    .collection('chatroom')
                    .doc(RoomId)
                    .collection('chats')
                    .orderBy("time", descending: false)
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.data != null) {
                    return ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: ((context, index) {
                          Map<String, dynamic> map = snapshot.data!.docs[index]
                              .data() as Map<String, dynamic>;
                          return messages(size, map);
                        }));
                  } else {
                    return Container();
                  }
                },
              ),
            ),
            Container(
              height: size.height / 10,
              width: size.width,
              alignment: Alignment.center,
              child: Container(
                height: size.height / 12,
                width: size.width / 1.1,
                child: Row(children: [
                  Container(
                    height: size.height / 12,
                    width: size.width / 1.5,
                    child: TextField(
                      controller: _message,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8))),
                    ),
                  ),
                  IconButton(icon: Icon(Icons.send), onPressed: onSendMessage)
                ]),
              ),
            ),
          ],
        )));
  }
}

Widget messages(Size size, Map<String, dynamic> map) {
  return Container(
    width: size.width,
    alignment: map['sendby'] == auth.currentUser!.displayName!
        ? Alignment.centerRight
        : Alignment.centerLeft,
    child: Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 14),
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15), color: Colors.blue),
      child: Text(
        map['message'],
        style: TextStyle(
            fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white),
      ),
    ),
  );
}
