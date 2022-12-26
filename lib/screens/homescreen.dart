import 'package:chat_appv2/widgets.dart/conversationList.dart';
import 'package:chat_appv2/auth/methods.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoading = false;
  var allusers;
  Map<String, dynamic>? userMap;
  final TextEditingController _search = TextEditingController();

  Future<void> onload() async {
    FirebaseFirestore _firestore = FirebaseFirestore.instance;

    setState(() {
      isLoading = true;
    });

    QuerySnapshot querySnapshot = await _firestore.collection('users').get();
    allusers = querySnapshot.docs.map((doc) => doc.data()).toList();
    print(allusers[0]['name']);
    setState(() {
      isLoading = false;
    });
  }

  // void onSearch() async {
  //   FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //   setState(() {
  //     isLoading = true;
  //   });

  //   await _firestore
  //       .collection('users')
  //       .where('email', isEqualTo: _search.text)
  //       .get()
  //       .then((value) {
  //     setState(() {
  //       print(value);
  //       userMap = value.docs[0].data();
  //       isLoading = false;
  //     });
  //     print(userMap);
  //   }).onError((error, stackTrace) => null);
  // }

  @override
  void initState() {
    onload();

    super.initState();
  }

  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Screen"),
        actions: [
          IconButton(icon: Icon(Icons.logout), onPressed: () => logOut(context))
        ],
      ),
      body: isLoading
          ? Center(
              child: Container(
                height: size.height / 20,
                width: size.height / 20,
                child: CircularProgressIndicator(),
              ),
            )
          : SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SafeArea(
                    child: Padding(
                      padding: EdgeInsets.only(left: 16, right: 16, top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            "Conversations",
                            style: TextStyle(
                                fontSize: 32, fontWeight: FontWeight.bold),
                          ),
                          Container(
                            // padding: EdgeInsets.only(
                            //     left: 8, right: 8, top: 2, bottom: 2),
                            // height: 30,
                            // decoration: BoxDecoration(
                            //   borderRadius: BorderRadius.circular(30),
                            //   color: Colors.pink[50],
                            // ),
                            child: Row(
                              children: <Widget>[
                                // Icon(
                                //   Icons.add,
                                //   color: Colors.pink,
                                //   size: 20,
                                // ),
                                // SizedBox(
                                //   width: 2,
                                // ),
                                // GestureDetector(
                                //   // onTap: () => onSearch(),
                                //   child: Text("Add New"),
                                // )
                                // Text(

                                //   "Add New",
                                //   style: TextStyle(
                                //       fontSize: 14,
                                //       fontWeight: FontWeight.bold),
                                // ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 16, left: 16, right: 16),
                    child: TextField(
                      controller: _search,
                      decoration: InputDecoration(
                        hintText: "Search...",
                        hintStyle: TextStyle(color: Colors.grey.shade600),
                        prefixIcon: Icon(
                          Icons.search,
                          color: Colors.grey.shade600,
                          size: 20,
                        ),
                        filled: true,
                        fillColor: Colors.grey.shade100,
                        contentPadding: EdgeInsets.all(8),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide:
                                BorderSide(color: Colors.grey.shade100)),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  allusers != null
                      ? ListView.builder(
                          shrinkWrap: true,
                          itemCount: allusers!.length,
                          itemBuilder: (context, index) {
                            return ConversationList(
                              name: allusers[index]['name'],
                              email: allusers[index]['email'],
                            );
                          })
                      : Container(),
                ],
              ),
            ),
    );
  }
}
