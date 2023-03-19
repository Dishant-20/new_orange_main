import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:my_new_orange/classes/public_chat/public_chat_room.dart';
import 'package:my_new_orange/header/utils/Utils.dart';
import 'package:my_new_orange/header/utils/custom/app_bar.dart';
// import 'package:shaawl/classes/headers/utils/utils.dart';
// import 'package:shaawl/classes/tabbar/chat/public_chat_room/public_chat_room.dart';
// import 'package:shaawl/custom_classes/appbar/app_bar.dart';

import 'package:uuid/uuid.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SetProfileNameScreen extends StatefulWidget {
  const SetProfileNameScreen({super.key});

  @override
  State<SetProfileNameScreen> createState() => _SetProfileNameScreenState();
}

class _SetProfileNameScreenState extends State<SetProfileNameScreen> {
  //
  var strSetLoader = '1';
  // var strSave
  final formGlobalKey = GlobalKey<FormState>();
  TextEditingController contSetName = TextEditingController();
  //
  var strSaveChatUserId = '0';
  @override
  void initState() {
    super.initState();
    //
    // func();
    //
  }

  func() async {
    try {
      final userCredential = await FirebaseAuth.instance.signInAnonymously();
      if (kDebugMode) {
        print("Signed in with temporary account.");
        print(userCredential);
      }
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "operation-not-allowed":
          if (kDebugMode) {
            print("Anonymous auth hasn't been enabled for this project.");
          }
          break;
        default:
          if (kDebugMode) {
            print("Unknown error.");
          }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarScreen(
        str_app_bar_title: 'Set Profile Name',
        str_status: '0',
        // appBarTitle: 'Set Profile Name',
        // strBackButtonHide: 'yes',
      ),
      body: Form(
        key: formGlobalKey,
        child: Column(
          children: [
            //
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: contSetName,
                decoration: const InputDecoration(
                  labelText: 'Set Name',
                  hintText: '',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please set name...';
                  }
                  return null;
                },
              ),
            ),
            //
            Center(
              child: InkWell(
                onTap: () {
                  if (formGlobalKey.currentState!.validate()) {
                    if (kDebugMode) {
                      print('object');
                    }
                    //
                    setState(() {
                      strSetLoader = '0';
                    });
                    //
                    funcSetProfileForChat();
                    //
                  }
                },
                child: Container(
                  margin: const EdgeInsets.all(10.0),
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    color: Colors.amber[600],
                    // color: colori,
                    borderRadius: BorderRadius.circular(
                      35,
                    ),
                    boxShadow: const [
                      BoxShadow(
                        offset: Offset(0, 1),
                        blurRadius: 5.0,
                      ),
                    ],
                  ),
                  child: (strSetLoader == '0')
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: Colors.deepPurple,
                          ),
                        )
                      : Center(
                          child: textWithSemiBoldStyle(
                            'Set',
                            16.0,
                            Colors.black,
                          ),
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
    //
  }

  // CHECK PROFILE DATA AFTER CLICK ON SET
  funcSetProfileForChat() {
    FirebaseFirestore.instance
        .collection("users")
        .doc("India")
        .collection("details")
        .where("firebase_id", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
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
        funcRegisterNewUserInDB();
        //
      } else {
        for (var element in value.docs) {
          if (kDebugMode) {
            print('======> YES,  USER FOUND');
          }
          if (kDebugMode) {
            print(element.id);
            print(element.id.runtimeType);
          }
          // EDIT USER IF IT ALREADY EXIST
          funcUserAlreadyExistUpdateProfileData(element.id);
          //
        }
      }
    });
    // );
  }

  // REGISTER NEW USER IN DB
  funcRegisterNewUserInDB() {
    var chatUserId = const Uuid().v4();
    if (kDebugMode) {
      print(chatUserId);
    }

    CollectionReference users =
        FirebaseFirestore.instance.collection('users/India/details');

    users
        .add(
          {
            'firebase_id': FirebaseAuth.instance.currentUser!.uid,
          },
        )
        .then(
          (value) =>

              // print("Place details added Successfully" + value.id)
              FirebaseFirestore.instance
                  .collection('users')
                  .doc('India')
                  .collection('details')
                  .doc(value.id)
                  .set(
            {
              'firestore_id': value.id,
              'chat_user_id': chatUserId,
              'time_stamp': DateTime.now().millisecondsSinceEpoch,
              'gender_status': 'g' //_currentSelection.toString()
            },
            SetOptions(merge: true),
          ).then(
            (value1) {
              // setState(() {
              //   // isLoading = false;
              // });
              //
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PublicChatRoomScreen(
                    strSenderName: contSetName.text.toString(),
                    strSenderChatId: chatUserId.toString(),
                  ),
                ),
              );
              //
              setState(() {
                strSetLoader = '1';
              });
              //
            },
          ),
        )
        .catchError(
          (error) => print("Failed to add user: $error"),
        );
  }

  // IF USER ALREADY EXIST SO UPDATE DATA
  funcUserAlreadyExistUpdateProfileData(String getFirestoreId) {
    var chatUserId = const Uuid().v4();
    if (kDebugMode) {
      print(chatUserId);
    }

    FirebaseFirestore.instance
        .collection('users')
        .doc('India')
        .collection('details')
        .doc(getFirestoreId)
        .set(
      {
        'firestore_id': getFirestoreId,
        'chat_user_id': chatUserId,
        'time_stamp': DateTime.now().millisecondsSinceEpoch,
        'gender_status': 'g', //_currentSelection.toString()
        'chat_user_name': contSetName.text.toString()
      },
      SetOptions(merge: true),
    ).then(
      (value1) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PublicChatRoomScreen(
              strSenderName: contSetName.text.toString(),
              strSenderChatId: chatUserId.toString(),
            ),
          ),
        );
        //
        setState(() {
          strSetLoader = '1';
        });
        //
        //
      },
    );
  }
}

/*
funcEditLoginChatUserFirebaseData(
    String getFirestoreId,
  ) {
    var chatUserId = const Uuid().v4();
    if (kDebugMode) {
      print(chatUserId);
      print('=====> WE GOT FIRESTORE ID <=====');
    }

    FirebaseFirestore.instance
        .collection('users')
        .doc('India')
        .collection('details')
        .doc(getFirestoreId.toString())
        .set(
      {
        'firestore_id': getFirestoreId.toString(),
        'chat_user_id': chatUserId.toString(),
        'time_stamp': DateTime.now().millisecondsSinceEpoch,
        'gender_status': 'g' //_currentSelection.toString()
      },
      SetOptions(merge: true),
    ).then(
      (value1) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const PublicChatRoomScreen(),
          ),
        );
        //
        //
        setState(() {
          strSetLoader = '1';
        });
        //
      },
    );
  }
  */
