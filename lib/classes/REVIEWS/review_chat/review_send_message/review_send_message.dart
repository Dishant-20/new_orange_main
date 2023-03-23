import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../../header/utils/Utils.dart';

class ReviewSendMessageScreen extends StatefulWidget {
  const ReviewSendMessageScreen({super.key, required this.strCategoryMovieId});

  final String strCategoryMovieId;

  @override
  State<ReviewSendMessageScreen> createState() =>
      _ReviewSendMessageScreenState();
}

class _ReviewSendMessageScreenState extends State<ReviewSendMessageScreen> {
  //
  TextEditingController contTextSendMessage = TextEditingController();
  //
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      color: Colors.white,
      // height: 60,
      // width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: contTextSendMessage,
                minLines: 1,
                maxLines: 5,
                decoration: const InputDecoration(
                  // border: Border(),
                  // labelText: '',
                  hintText: 'write something',
                ),
              ),
            ),
          ),
          //
          IconButton(
            onPressed: () {
              if (kDebugMode) {
                print('send');
              }
              //

              sendMessageViaFirebase(contTextSendMessage.text);
              contTextSendMessage.text = '';
              //
            },
            icon: const Icon(
              Icons.send,
            ),
          ),
          //
        ],
      ),
    );
  }

  //
  // send message
  sendMessageViaFirebase(strLastMessageEntered) {
    // print(cont_txt_send_message.text);

    CollectionReference users = FirebaseFirestore.instance.collection(
      '${strFirebaseMode}reviews/India/review_chats',
    );

    users
        .add(
          {
            'sender_name': '',
            'sender_gender': 'gender',
            'sender_firebase_id': FirebaseAuth.instance.currentUser!.uid,
            'message': strLastMessageEntered.toString(),
            'time_stamp': DateTime.now().millisecondsSinceEpoch,
            'room': 'review_chat',
            'type': 'text_message',
          },
        )
        .then(
          (value) =>
              // print(
              // "Message send successfully. Message id is =====> ${value.id}"),
              funcEditTotalReviewCount(),
        )
        .catchError(
          (error) => print("Failed to add user: $error"),
        );
  }

  // EDIT TOTAL REVIEW COUNT
  funcEditTotalReviewCount() {
    /*FirebaseFirestore.instance
        .collection("${strFirebaseMode}add_review")
        .doc('India')
        .collection('details')
        .doc(widget.strCategoryMovieId)
        .set(
      {
        'total_reviews': '1',
      },
      SetOptions(merge: true),
    ).then(
      (value1) {},
    );*/
    FirebaseFirestore.instance
        .collection("${strFirebaseMode}add_review")
        .doc("India")
        .collection("details")
        .where("firestore_id", isEqualTo: widget.strCategoryMovieId)
        .get()
        .then((value) {
      if (kDebugMode) {
        print(value.docs);
      }

      if (value.docs.isEmpty) {
        if (kDebugMode) {
          print('======> NO USER FOUND');
        }
        // ADD THIS USER TO FIREBASE SERVER
        // funcRegisterNewUserInDB();
        //
      } else {
        for (var element in value.docs) {
          if (kDebugMode) {
            print('======> YES,  USER FOUND');
          }
          if (kDebugMode) {
            print(element.id);
            print(element.id.runtimeType);
            print(element.data()['total_reviews']);
          }
          //
          var sumOne = 1;
          var strTotalReview =
              int.parse(element.data()['total_reviews'].toString());

          var strTotal = sumOne + strTotalReview;

          FirebaseFirestore.instance
              .collection("${strFirebaseMode}add_review")
              .doc('India')
              .collection('details')
              .doc(widget.strCategoryMovieId)
              .set(
            {
              'total_reviews': strTotal.toString(),
            },
            SetOptions(merge: true),
          ).then(
            (value1) {},
          );

          //
        }
      }
    });
  }
}
