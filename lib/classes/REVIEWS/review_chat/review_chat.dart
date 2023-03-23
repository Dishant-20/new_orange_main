import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:my_new_orange/classes/REVIEWS/review_chat/review_send_message/review_send_message.dart';
import 'package:my_new_orange/header/utils/Utils.dart';
import 'package:my_new_orange/header/utils/custom/app_bar.dart';
import 'package:visibility_detector/visibility_detector.dart';

class ReviewChatScreen extends StatefulWidget {
  const ReviewChatScreen(
      {super.key,
      required this.strCategoryId,
      required this.strCategoryTitle,
      required this.strFirestoreIdForEdit});

  final String strCategoryId;
  final String strCategoryTitle;
  final String strFirestoreIdForEdit;

  @override
  State<ReviewChatScreen> createState() => _ReviewChatScreenState();
}

class _ReviewChatScreenState extends State<ReviewChatScreen> {
  bool needsScroll = false;
  final ScrollController _scrollController = ScrollController();
  //
  int _currentItem = 0;
  var strScrollOnlyOneTime = '1';
  //
  @override
  void initState() {
    super.initState();
  }

  _scrollToEnd() async {
    if (needsScroll) {
      needsScroll = false;
      _scrollController.animateTo(_scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 200), curve: Curves.easeInOut);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarScreen(
        str_app_bar_title: widget.strCategoryTitle.toString(),
        str_status: '1',
      ),
      body: GestureDetector(
        onTap: () {
          // keyboard dismiss when click outside
          FocusScopeNode currentFocus = FocusScope.of(context);

          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: Stack(
          children: [
            Container(
              // margin: const EdgeInsets.all(10.0),
              color: Colors.amber[600],
              width: MediaQuery.of(context).size.width,
              height: 20,
              child: Center(
                child: textWithRegularStyle(
                  'click on chat to chat with that user',
                  14.0,
                  Colors.purple,
                  'left',
                ),
              ),
            ),
            //
            Container(
              margin: const EdgeInsets.only(
                top: 24,
                left: 10,
                bottom: 80,
                right: 10,
              ),
              color: Colors.amber[600],
              // width: 48.0,
              // height: 48.0,
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection(
                        "${strFirebaseMode}reviews/India/review_chats",
                      )
                      .orderBy('time_stamp', descending: true)
                      .limit(40)
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasData) {
                      //
                      if (strScrollOnlyOneTime == '1') {
                        needsScroll = true;
                        WidgetsBinding.instance
                            .addPostFrameCallback((_) => _scrollToEnd());
                      }
                      //

                      var getSnapShopValue =
                          snapshot.data!.docs.reversed.toList();
                      if (kDebugMode) {
                        // print(getSnapShopValue);
                      }
                      return Stack(
                        children: [
                          if (strScrollOnlyOneTime == '1') ...[
                            const SizedBox(
                              height: 0,
                            )
                          ] else ...[
                            Align(
                              alignment: Alignment.topCenter,
                              child: InkWell(
                                onTap: () {
                                  needsScroll = true;
                                  WidgetsBinding.instance.addPostFrameCallback(
                                      (_) => _scrollToEnd());
                                },
                                child: Container(
                                  margin: const EdgeInsets.all(10.0),
                                  width: 120,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: const Color.fromARGB(
                                      255,
                                      250,
                                      247,
                                      247,
                                    ),
                                    borderRadius: BorderRadius.circular(
                                      14.0,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 5,
                                        blurRadius: 7,
                                        offset: const Offset(
                                          0,
                                          3,
                                        ), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: Center(
                                    child: textWithSemiBoldStyle(
                                      'New message',
                                      14.0,
                                      Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                          ListView.builder(
                            // controller: controller,
                            controller: _scrollController,
                            itemCount: getSnapShopValue.length,
                            shrinkWrap: true,
                            padding: const EdgeInsets.only(top: 10, bottom: 10),
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              return VisibilityDetector(
                                key: Key(index.toString()),
                                onVisibilityChanged: (VisibilityInfo info) {
                                  if (info.visibleFraction == 1) {
                                    // setState(() {
                                    if (kDebugMode) {
                                      print(info);

                                      _currentItem = index;

                                      // print("INDEX =====> $index");
                                      // print("CURRENT INDEX =====> $_currentItem");
                                      // print(
                                      // "SERVER ARRAY INDEX =====> ${getSnapShopValue.length - 1}");

                                      if (_currentItem ==
                                          getSnapShopValue.length - 1) {
                                        print('USER IS IN LAST INDEX');
                                        setState(() {
                                          strScrollOnlyOneTime = '1';
                                        });
                                      } else {
                                        print('USER SCROLLS SCREEN');

                                        strScrollOnlyOneTime = '0';
                                      }
                                    }
                                  }
                                },
                                child: Container(
                                  padding: const EdgeInsets.only(
                                    left: 14,
                                    right: 14,
                                    //
                                    top: 10,
                                    bottom: 10,
                                  ),
                                  child: Align(
                                    alignment: (getSnapShopValue[index]
                                                    ['sender_firebase_id']
                                                .toString() ==
                                            FirebaseAuth
                                                .instance.currentUser!.uid
                                        ? Alignment.topRight
                                        : Alignment.topLeft),
                                    child: leftSideUIOnlyForPublicChat(
                                        getSnapShopValue, index),
                                    // (getSnapShopValue[index]['sender_firebase_id']
                                    //             .toString() ==
                                    //         FirebaseAuth.instance.currentUser!.uid)
                                    //     ? senderUI(getSnapShopValue, index)
                                    //     : receiverUI(index),
                                  ),
                                ),
                              );
                            },
                          )
                        ],
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text('Error: ${snapshot.error}'),
                      );
                    }
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }),
            ),
            //
            // ======> SEND MESSAGE UI <======
            // ========================
            Align(
                alignment: Alignment.bottomCenter,
                child: ReviewSendMessageScreen(
                  strCategoryMovieId: widget.strFirestoreIdForEdit,
                ) //sendMessageUI(),
                ),
            // ========================
            // ========================
          ],
        ),
      ),
    );
  }

  //
  Column leftSideUIOnlyForPublicChat(getSnapshotData, int index) {
    return Column(
      children: [
        //
        Align(
          alignment: Alignment.bottomLeft,
          child: Row(
            children: [
              // textWithSemiBoldStyle(
              //   //
              //   getSnapshotData[index]['sender_name'].toString(),
              //   //
              //   16.0,
              //   Colors.black,
              //   // 'right',
              // ),
              //
              (getSnapshotData[index]['sender_firebase_id'].toString() ==
                      FirebaseAuth.instance.currentUser!.uid)
                  ? const SizedBox()
                  : IconButton(
                      onPressed: () {
                        if (kDebugMode) {
                          print('=====> CHAT WITH OTHERS CLICK <=====');
                        }
                        //
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => PrivateChatScreenTwo(
                        //       strSenderName:
                        //           widget.strLoginSenderNameForPublic.toString(),
                        //       strReceiverName: getSnapshotData[index]
                        //               ['sender_name']
                        //           .toString(),
                        //       strReceiverFirebaseId: getSnapshotData[index]
                        //               ['sender_firebase_id']
                        //           .toString(),
                        //       strSenderChatId: widget
                        //           .strLoginSenderChatIdForPublic
                        //           .toString(),
                        //       strReceiverChatId: getSnapshotData[index]
                        //               ['sender_chat_user_id']
                        //           .toString(),
                        //     ),
                        //   ),
                        // );
                        //
                      },
                      icon: const Icon(
                        Icons.chat,
                        color: Colors.purple,
                      ),
                    ),
            ],
            // 98061311374
            // 8800631774
          ),
        ),
        //
        Align(
          alignment: Alignment.bottomLeft,
          child: Container(
            margin: const EdgeInsets.only(
              right: 40,
            ),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(
                  16,
                ),
                bottomLeft: Radius.circular(
                  0,
                ),
                topRight: Radius.circular(
                  16,
                ),
                bottomRight: Radius.circular(
                  16,
                ),
              ),
              color: Colors.grey.shade200,
            ),
            padding: const EdgeInsets.all(16),
            child: textWithRegularStyle(
              //
              getSnapshotData[index]['message'].toString(),
              //
              16.0,
              Colors.black,
              'left',
            ),
          ),
        ),
        //
        Align(
          alignment: Alignment.bottomLeft,
          child: textWithRegularStyle(
            //
            funcConvertTimeStampToDateAndTime(
              getSnapshotData[index]['time_stamp'],
            ),
            //
            12.0,
            Colors.black,
            'left',
          ),
        ),
        //
      ],
    );
  }
  //
}
