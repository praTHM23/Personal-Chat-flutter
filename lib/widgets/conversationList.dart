import 'package:chat_appv2/screens/chatRoom.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ConversationList extends StatefulWidget {
  String name;
  String email;

  ConversationList({required this.name, required this.email});
  @override
  _ConversationListState createState() => _ConversationListState();
}

class _ConversationListState extends State<ConversationList> {
  String chatRoomId(String user1, String user2) {
    if (user1[0].toLowerCase().codeUnits[0] >
        user2.toLowerCase().codeUnits[0]) {
      return "$user1$user2";
    } else {
      return "$user2$user1";
    }
  }

  final FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final curruser = auth.currentUser;
        String RoomId = chatRoomId(curruser!.displayName!, widget.name);
        Navigator.of(context).push(MaterialPageRoute(
            builder: (_) => ChatRoom(RoomId: RoomId, user: widget.name)));
      },
      child: Container(
        padding: EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 10),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Row(
                children: <Widget>[
                  CircleAvatar(
                    backgroundImage: NetworkImage(
                        'https://cdn.pixabay.com/photo/2018/04/18/18/56/user-3331257_960_720.png'),
                    maxRadius: 30,
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: Container(
                      color: Colors.transparent,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            widget.name,
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          Text(widget.email, style: TextStyle(fontSize: 10))
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Text(
            //   widget.time,
            //   style: TextStyle(
            //       fontSize: 12,
            //       fontWeight: widget.isMessageRead
            //           ? FontWeight.bold
            //           : FontWeight.normal),
            // ),
            SizedBox(
              width: 6,
            ),
            Icon(
              Icons.chat_bubble_outline,
              color: Colors.black,
            )
          ],
        ),
      ),
    );
  }
}
