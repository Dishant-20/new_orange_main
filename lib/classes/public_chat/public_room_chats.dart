import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:my_new_orange/header/utils/Utils.dart';
// import 'package:shaawl/classes/headers/utils/utils.dart';

class PublicChatRoomChats extends StatefulWidget {
  const PublicChatRoomChats({super.key});

  @override
  State<PublicChatRoomChats> createState() => _PublicChatRoomChatsState();
}

class _PublicChatRoomChatsState extends State<PublicChatRoomChats> {
  //
  // ScrollController controller = ScrollController();
  //
  bool _needsScroll = false;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  _scrollToEnd() async {
    if (_needsScroll) {
      _needsScroll = false;
      _scrollController.animateTo(_scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 200), curve: Curves.easeInOut);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // keyboard dismiss when click outside
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Container(
        color: Colors.transparent,
        margin: const EdgeInsets.only(top: 0, bottom: 60),
        child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection(
                  "message/India/public_chats",
                )
                .orderBy('time_stamp', descending: false)
                .limit(40)
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData) {
                //
                _needsScroll = true;
                WidgetsBinding.instance
                    .addPostFrameCallback((_) => _scrollToEnd());
                //
                var getSnapShopValue = snapshot.data!.docs.toList();
                if (kDebugMode) {
                  // print(getSnapShopValue);
                }
                return ListView.builder(
                  // controller: controller,
                  controller: _scrollController,
                  itemCount: getSnapShopValue.length,
                  shrinkWrap: true,
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Container(
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
                                FirebaseAuth.instance.currentUser!.uid
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
                    );
                  },
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
    );
  }

  Column leftSideUIOnlyForPublicChat(getSnapshotData, int index) {
    return Column(
      children: [
        //
        Align(
          alignment: Alignment.bottomLeft,
          child: Row(
            children: [
              textWithSemiBoldStyle(
                //
                getSnapshotData[index]['sender_name'].toString(),
                //
                16.0,
                Colors.black,
                // 'right',
              ),
              //
              (getSnapshotData[index]['sender_firebase_id'].toString() ==
                      FirebaseAuth.instance.currentUser!.uid)
                  ? const SizedBox()
                  : IconButton(
                      onPressed: () {
                        if (kDebugMode) {
                          print('=====> CHAT WITH OTHERS CLICK <=====');
                        }
                      },
                      icon: const Icon(
                        Icons.chat,
                        color: Colors.purple,
                      ),
                    ),
            ],
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

  // Column senderUI(getSnapshot, int index) {
  //   return Column(
  //     children: [
  //       Align(
  //         alignment: Alignment.bottomRight,
  //         child: Container(
  //           margin: const EdgeInsets.only(
  //             left: 40,
  //           ),
  //           decoration: BoxDecoration(
  //             borderRadius: const BorderRadius.only(
  //               topLeft: Radius.circular(
  //                 16,
  //               ),
  //               bottomLeft: Radius.circular(
  //                 16,
  //               ),
  //               topRight: Radius.circular(
  //                 16,
  //               ),
  //             ),
  //             color: Colors.blue[200],
  //           ),
  //           padding: const EdgeInsets.all(
  //             16,
  //           ),
  //           child: const Text(
  //             'r',
  //             style: TextStyle(
  //               fontSize: 15,
  //             ),
  //           ),
  //         ),
  //       ),
  //       //
  //       Align(
  //         alignment: Alignment.bottomRight,
  //         child: textWithRegularStyle(
  //           // getSnapshot[index]['time_stamp'].toString(),
  //           funcConvertTimeStampToDateAndTime(
  //             getSnapshot[index]['time_stamp'],
  //           ),
  //           12.0,
  //           Colors.black,
  //           'right',
  //         ),
  //       ),
  //       //
  //     ],
  //   );
  // }
}
