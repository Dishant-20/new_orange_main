import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:my_new_orange/classes/REVIEWS/review_category/review_category_list/review_category_list.dart';
import 'package:my_new_orange/header/utils/Utils.dart';
import 'package:my_new_orange/header/utils/custom/app_bar.dart';

class ReviewCategoryScreen extends StatefulWidget {
  const ReviewCategoryScreen({super.key});

  @override
  State<ReviewCategoryScreen> createState() => _ReviewCategoryScreenState();
}

class _ReviewCategoryScreenState extends State<ReviewCategoryScreen> {
  //
  var saveElementId = [];
  //
  @override
  void initState() {
    super.initState();
    //
    // funcGetAllCateogriesListElementIdToEdit();
    //
  }

  //
  funcGetAllCateogriesListElementIdToEdit() {
    FirebaseFirestore.instance
        .collection("${strFirebaseMode}reviews")
        .doc("India")
        .collection("details")
        .get()
        .then((value) {
      if (kDebugMode) {
        // print(value.docs);
      }

      if (value.docs.isEmpty) {
        if (kDebugMode) {
          print('======> NO USER FOUND');
        }
      } else {
        for (var element in value.docs) {
          if (kDebugMode) {
            print('======> YES,  USER FOUND 2');
          }
          if (kDebugMode) {
            print(element.id);
          }
          //
          saveElementId.add(element.id);
          //
        }
        // EDIT CATEGORY
        funcEditOneByOneCategory();
        //
      }
    });
  }

  funcEditOneByOneCategory() {
    if (kDebugMode) {
      print(saveElementId);
    }

    for (int i = 0; i < saveElementId.length; i++) {
      FirebaseFirestore.instance
          .collection("${strFirebaseMode}reviews")
          .doc('India')
          .collection('details')
          .doc(
            saveElementId[i].toString(),
          )
          .set(
        {
          'category_image':
              'https://images.unsplash.com/photo-1509062522246-3755977927d7?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1832&q=80',
        },
        SetOptions(merge: true),
      ).then(
        (value1) {
          // print(value1);
        },
      );
    }
  }

  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarScreen(
        str_app_bar_title: 'Categories',
        str_status: '1',
      ),
      body: FutureBuilder(
          future: FirebaseFirestore.instance
              .collection('${strFirebaseMode}reviews')
              .doc('India')
              .collection('details')
              .orderBy('time_stamp', descending: false)
              .get(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              if (kDebugMode) {
                print('YES, CATEGORY HAS DATA');
              }

              var saveSnapshotValue = snapshot.data!.docs;
              //
              if (kDebugMode) {
                // print(snapshot.hasData);
                // print(widget.str_dialog_login_user_chat_id);
                // print(snapshot.data!.docs.length);
                // print(saveSnapshotValue);
              }
              return SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    for (int i = 0; i < saveSnapshotValue.length; i++) ...[
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ReviewCategoryListScreen(
                                strCategoryName: saveSnapshotValue[i]
                                        ['category_name']
                                    .toString(),
                              ),
                            ),
                          );
                        },
                        child: Container(
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
                                    CircleAvatar(
                                      backgroundImage: NetworkImage(
                                        //
                                        saveSnapshotValue[i]['category_image']
                                            .toString(),
                                        //
                                      ),
                                      maxRadius: 40,
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
                                            textWithSemiBoldStyle(
                                              //
                                              saveSnapshotValue[i]
                                                      ['category_name']
                                                  .toString(),
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
                                              'total : ${saveSnapshotValue[i]['total_items']}',
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
                              const Icon(
                                Icons.chevron_right,
                              )
                            ],
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.all(10.0),
                        color: app_blue_color,
                        width: MediaQuery.of(context).size.width,
                        height: 0.4,
                      ),
                    ]
                  ],
                ),
              );
            } else if (snapshot.hasError) {
              if (kDebugMode) {
                print(snapshot.error);
              }
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            }
            return Center(
              child: textWithRegularStyle(
                'please wait...',
                14.0,
                Colors.black,
                'left',
              ),
            );
          }

          /**/
          ),
    );
  }
}
