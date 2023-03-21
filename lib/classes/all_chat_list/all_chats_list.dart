import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:my_new_orange/header/utils/Utils.dart';
// import 'package:shaawl/classes/headers/utils/utils.dart';
// import 'package:shaawl/classes/models/chat_user_model.dart';

class AllChatsListScreen extends StatefulWidget {
  const AllChatsListScreen(
      {super.key, required this.str_dialog_login_user_chat_id});

  final String str_dialog_login_user_chat_id;

  @override
  State<AllChatsListScreen> createState() => _AllChatsListScreenState();
}

class _AllChatsListScreenState extends State<AllChatsListScreen> {
  //

  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            /*SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const <Widget>[
                    Text(
                      "Conversations",
                      style:
                          TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                    ),
                    /*Container(
                      padding: const EdgeInsets.only(
                          left: 8, right: 8, top: 2, bottom: 2),
                      height: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.pink[50],
                      ),
                      child: Row(
                        children: const <Widget>[
                          Icon(
                            Icons.add,
                            color: Colors.pink,
                            size: 20,
                          ),
                          SizedBox(
                            width: 2,
                          ),
                          Text(
                            "Add New",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    )*/
                  ],
                ),
              ),
            ),*/
            //
            /*Padding(
              padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Search...",
                  hintStyle: TextStyle(color: Colors.grey.shade600),
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.grey.shade600,
                    size: 20,
                  ),
                  filled: false,
                  fillColor: Colors.grey.shade100,
                  contentPadding: const EdgeInsets.all(8),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: Colors.grey.shade100)),
                ),
              ),
            ),*/
//

            StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('dialog')
                    .doc('India')
                    .collection('details')
                    .orderBy('time_stamp', descending: true)
                    .where('match', arrayContainsAny: [
                  widget.str_dialog_login_user_chat_id,
                ]).snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData) {
                    //
                    var saveSnapshotValue = snapshot.data!.docs;
                    //
                    if (kDebugMode) {
                      print(snapshot.hasData);
                      print(widget.str_dialog_login_user_chat_id);
                      print(snapshot.data!.docs.length);
                      print(saveSnapshotValue);
                    }
                    //
                    return Column(
                      children: [
                        for (int i = 0; i < saveSnapshotValue.length; i++) ...[
                          Container(
                            padding: const EdgeInsets.only(
                              left: 16,
                              right: 16,
                              top: 10,
                              bottom: 10,
                            ),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: Row(
                                    children: <Widget>[
                                      const CircleAvatar(
                                        backgroundImage: NetworkImage(
                                            'https://images.unsplash.com/photo-1525310072745-f49212b5ac6d?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=930&q=80'),
                                        maxRadius: 30,
                                      ),
                                      const SizedBox(
                                        width: 16,
                                      ),
                                      Expanded(
                                        child: Container(
                                          color: Colors.transparent,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              (saveSnapshotValue[i][
                                                              'sender_firebase_id']
                                                          .toString() ==
                                                      FirebaseAuth.instance
                                                          .currentUser!.uid
                                                          .toString())
                                                  ? textWithSemiBoldStyle(
                                                      //
                                                      // 'd',
                                                      saveSnapshotValue[i]
                                                          ['receiver_name'],
                                                      //
                                                      16.0,
                                                      Colors.black,
                                                    )
                                                  : textWithSemiBoldStyle(
                                                      //
                                                      // 'd',
                                                      saveSnapshotValue[i]
                                                          ['sender_name'],
                                                      //
                                                      16.0,
                                                      Colors.black,
                                                    ),
                                              const SizedBox(
                                                height: 6,
                                              ),
                                              //
                                              textWithRegularStyle(
                                                //
                                                // 'd',
                                                saveSnapshotValue[i]['message']
                                                    .toString(),
                                                //
                                                16.0,
                                                Colors.black,
                                                'left',
                                              ),
                                              //
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  funcConvertTimeStampToDateAndTime(
                                    saveSnapshotValue[i]['time_stamp'],
                                  ),
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ],
                    );
                  } else if (snapshot.hasError) {
                    if (kDebugMode) {
                      print(snapshot.error);
                    }
                    return Center(
                      child: Text('Error: ${snapshot.error}'),
                    );
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
