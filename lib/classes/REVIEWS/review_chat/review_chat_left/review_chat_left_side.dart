import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:my_new_orange/header/utils/Utils.dart';

class ReviewChatLeftScreen extends StatefulWidget {
  const ReviewChatLeftScreen({super.key});

  @override
  State<ReviewChatLeftScreen> createState() => _ReviewChatLeftScreenState();
}

class _ReviewChatLeftScreenState extends State<ReviewChatLeftScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //
        Align(
          alignment: Alignment.bottomLeft,
          child: Row(
            children: [
              textWithSemiBoldStyle(
                //
                // getSnapshotData[index]['sender_name'].toString(),
                'rajput',

                //
                16.0,
                Colors.black,
                // 'right',
              ),
              //
              /*(getSnapshotData[index]['sender_firebase_id'].toString() ==
                      FirebaseAuth.instance.currentUser!.uid)
                  ? const SizedBox()
                  : */
              IconButton(
                onPressed: () {
                  if (kDebugMode) {
                    print('=====> CHAT WITH OTHERS CLICK <=====');
                  }
                  //
                  /*Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PrivateChatScreenTwo(
                              strSenderName:
                                  widget.strLoginSenderNameForPublic.toString(),
                              strReceiverName: getSnapshotData[index]
                                      ['sender_name']
                                  .toString(),
                              strReceiverFirebaseId: getSnapshotData[index]
                                      ['sender_firebase_id']
                                  .toString(),
                              strSenderChatId: widget
                                  .strLoginSenderChatIdForPublic
                                  .toString(),
                              strReceiverChatId: getSnapshotData[index]
                                      ['sender_chat_user_id']
                                  .toString(),
                            ),
                          ),
                        );*/
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
              //getSnapshotData[index]['message'].toString(),
              'dishu',
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
            // funcConvertTimeStampToDateAndTime(
            //   getSnapshotData[index]['time_stamp'],
            // ),
            'ok ok ',
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
}
