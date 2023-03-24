import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:my_new_orange/classes/REVIEWS/review_category/review_category.dart';
import 'package:my_new_orange/header/utils/Utils.dart';
import 'package:my_new_orange/header/utils/custom/app_bar.dart';
import 'package:uuid/uuid.dart';

import '../database/database_helper.dart';
import '../database/database_modal.dart';

class AddCategoryInFirebaseServerScreen extends StatefulWidget {
  const AddCategoryInFirebaseServerScreen({super.key});

  @override
  State<AddCategoryInFirebaseServerScreen> createState() =>
      _AddCategoryInFirebaseServerScreenState();
}

class _AddCategoryInFirebaseServerScreenState
    extends State<AddCategoryInFirebaseServerScreen> {
  //
  late DataBase handler;
  final formKey = GlobalKey<FormState>();
  //
  late final TextEditingController contCategoryName;
  late final TextEditingController contCategoryImage;
  //
  var strTotalItemsInLocalDBCount = '0';
  var saveTotalCountOfElement = '0';
  //
  @override
  void initState() {
    super.initState();
    //
    handler = DataBase();
    //
    contCategoryName = TextEditingController();
    contCategoryImage = TextEditingController();
    //
    // handler.deleteAllLocalDB().then((value) => {
    //       print('====> ALL DATA HAS BEEN DELETED FROM LOCAL SERVER <===='),
    //       funcRetrieveDataFromLocalDB(),
    //     });
  }

  @override
  void dispose() {
    //
    contCategoryName.dispose();
    contCategoryImage.dispose();
    //
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarScreen(
        str_app_bar_title: 'ADD CATEGORY',
        str_status: '1',
      ),
      body: Form(
        key: formKey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                // width: 100,
                child: TextFormField(
                  controller: contCategoryName,
                  readOnly: false,
                  decoration: InputDecoration(
                    hintText: "select category...",
                    labelText: 'Category',
                    hintStyle: TextStyle(color: Colors.grey.shade600),

                    filled: false,
                    fillColor: Colors.grey.shade100,
                    // contentPadding: const EdgeInsets.all(8),
                    // contentPadding: const EdgeInsets.symmetric(
                    // vertical: 10, // text field height
                    // ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(
                        color: Colors.brown,
                      ),
                    ),
                  ),
                  onTap: () {
                    //
                    // funcBottomSheet();
                    //
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Name';
                    }
                    return null;
                  },
                ),
              ),
            ),
            //
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                // width: 100,
                child: TextFormField(
                  controller: contCategoryImage,
                  readOnly: false,
                  decoration: InputDecoration(
                    hintText: "select category...",
                    labelText: 'Image',
                    hintStyle: TextStyle(color: Colors.grey.shade600),

                    filled: false,
                    fillColor: Colors.grey.shade100,
                    // contentPadding: const EdgeInsets.all(8),
                    // contentPadding: const EdgeInsets.symmetric(
                    // vertical: 10, // text field height
                    // ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(
                        color: Colors.brown,
                      ),
                    ),
                  ),
                  onTap: () {
                    //
                    // funcBottomSheet();
                    //
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Image';
                    }
                    return null;
                  },
                ),
              ),
            ),
            //
            InkWell(
              onTap: () {
                if (kDebugMode) {
                  // print('object');
                }
                //
                if (formKey.currentState!.validate()) {
                  funcAddCategoryForServer();
                }
                //
              },
              child: Center(
                child: Container(
                  margin: const EdgeInsets.all(10.0),
                  color: Colors.amber[600],
                  width: 48.0,
                  height: 48.0,
                ),
              ),
            ),
            //
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ReviewCategoryScreen(),
                  ),
                );
              },
              child: Container(
                margin: const EdgeInsets.all(10.0),
                color: Colors.purple,
                width: 200,
                height: 48.0,
                child: Center(
                  child: textWithRegularStyle(
                    'LIST OF CATEGORIES >',
                    14.0,
                    Colors.white,
                    'left',
                  ),
                ),
              ),
            ),
            // flucontain
            Center(
              child: InkWell(
                onTap: () {
                  funcRetrieveDataFromLocalDB();
                },
                child: Container(
                  margin: const EdgeInsets.all(10.0),
                  color: Colors.brown,
                  width: 200,
                  height: 48.0,
                  child: Center(
                    child: textWithRegularStyle(
                      'Click To Retrive Count',
                      14.0,
                      Colors.white,
                      'left',
                    ),
                  ),
                ),
              ),
            ),
            //

            textWithRegularStyle(
              'Retrive Count => $strTotalItemsInLocalDBCount',
              14.0,
              Colors.black,
              'left',
            ),
            //
          ],
        ),
      ),
    );
  }

  //
  funcAddCategoryForServer() {
    var chatUserId = const Uuid().v4();
    if (kDebugMode) {
      print(chatUserId);
    }

    var strImage =
        'https://firebasestorage.googleapis.com/v0/b/official-console.appspot.com/o/anamak%2Fcategory%2Fcategory_18.png?alt=media&token=a2de569a-050a-4fda-9c2b-05e06c9bfee0';

    CollectionReference users = FirebaseFirestore.instance
        .collection('${strFirebaseMode}reviews/India/review_lists');

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
                  .collection("${strFirebaseMode}reviews")
                  .doc('India')
                  .collection('review_lists')
                  .doc(value.id)
                  .set(
            {
              'firestore_id': value.id,
              'category_name': contCategoryName.text.toString(),
              'category_id': chatUserId.toString(),
              'category_image': strImage.toString(),
              // contCategoryImage.text.toString(),
              'time_stamp': DateTime.now().millisecondsSinceEpoch,
            },
            SetOptions(merge: true),
          ).then(
            (value1) {
              //
              if (kDebugMode) {
                print('<==================================>');
                print('<==================================>');
                print('Category add in Firebase. Now get data count / length');
                print('<==================================>');
                print('<==================================>');
              }

              // get total number of data in server => count / length
              funcGetTotalNumberOfDataOfCategory(
                value.id,
                chatUserId,
                strImage,
              );
              //
            },
          ),
        )
        .catchError(
          (error) => print("Failed to add user: $error"),
        );
  }

  funcGetTotalNumberOfDataOfCategory(
    elementId,
    getChatUserId,
    getImage,
  ) {
    FirebaseFirestore.instance
        .collection("${strFirebaseMode}reviews")
        .doc("India")
        .collection("review_lists")
        // .where("firestore_id", isEqualTo: elementId.toString())
        .get()
        .then((value) {
      if (kDebugMode) {
        print(value.docs);
      }

      if (value.docs.isEmpty) {
        if (kDebugMode) {
          print('======> NO USER FOUND');
        }
      } else {
        var arr = [];
        for (var element in value.docs) {
          if (kDebugMode) {
            // print('======> YES,  USER FOUND');
            // print(element.id);
            // print(value.docs);
            arr.add(element.id);
          }

          if (kDebugMode) {
            print(arr.length);
          }

          if (kDebugMode) {
            print('<==================================>');
            print('<==================================>');
            print('Category added. Now add this data to Local DB');
            print('<==================================>');
            print('<==================================>');
          }

          addPlanets(
            arr.length,
            getChatUserId.toString(),
            getImage.toString(),
            contCategoryName.text.toString(),
            DateTime.now().millisecondsSinceEpoch.toString(),
            '0',
          );

          contCategoryName.text = '';

          if (kDebugMode) {
            print('<==================================>');
            print('<==================================>');
            print('ALL DONE');
            print('<==================================>');
            print('<==================================>');
          }
          // EDIT USER IF IT ALREADY EXIST
        }
      }
    });
    // );
  }

  //
  Future<int> addPlanets(
    idMultiple,
    addCategoryIdtoLocalDB,
    addCategoryImageToLocalDB,
    addCategoryNameToLocalDB,
    timeStamp,
    totalItem,
  ) async {
    //
    List<Planets> planets = [];

    for (int i = 0; i < 1; i++) {
      Planets one = Planets(
        id: idMultiple,
        categoryId: addCategoryIdtoLocalDB.toString(),
        categoryImage: addCategoryImageToLocalDB.toString(),
        categoryName: addCategoryNameToLocalDB.toString(),
        timeStamp: timeStamp.toString(),
        totalItem: totalItem.toString(),
      );

      planets.add(one);
    }

    return await handler.insertPlanets(planets);
  }

  // get all item saved in local db
  funcRetrieveDataFromLocalDB() {
    handler.retrievePlanets().then(
      (value) {
        if (value.isEmpty) {
          if (kDebugMode) {
            print('NO, LOCAL DB DOES NOT HAVE ANY DATA');
          }
        } else {
          if (kDebugMode) {
            print('YES, LOCAL DB HAVE SOME DATA');
          }
          //
          if (kDebugMode) {
            print('Total Item in local DB ===> ${value.length}');
            setState(() {
              strTotalItemsInLocalDBCount = value.length.toString();
            });
          }
          //
        }
      },
    );
  }
}
