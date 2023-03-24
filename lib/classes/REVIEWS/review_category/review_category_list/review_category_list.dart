// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:my_new_orange/classes/REVIEWS/add_category/add_category.dart';
import 'package:my_new_orange/classes/REVIEWS/review_chat/review_chat.dart';
import 'package:my_new_orange/header/utils/Utils.dart';
import 'package:my_new_orange/header/utils/custom/app_bar.dart';

class ReviewCategoryListScreen extends StatefulWidget {
  const ReviewCategoryListScreen(
      {super.key,
      required this.strCategoryName,
      required this.strCategoryId,
      required this.strCategoryImage});

  final String strCategoryId;
  final String strCategoryName;
  final String strCategoryImage;

  @override
  State<ReviewCategoryListScreen> createState() =>
      _ReviewCategoryListScreenState();
}

class _ReviewCategoryListScreenState extends State<ReviewCategoryListScreen> {
  @override
  void initState() {
    super.initState();
    if (kDebugMode) {
      print(widget.strCategoryId);
      print(widget.strCategoryName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarScreen(
        str_app_bar_title: widget.strCategoryName.toString(),
        str_status: '1',
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your onPressed code here!
          pushToAddNewTitle(context);
          //
        },
        backgroundColor: app_blue_color,
        child: const Icon(
          Icons.add,
        ),
      ),
      body: Column(
        children: [
          StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('${strFirebaseMode}add_review')
                  .doc('India')
                  .collection('details')
                  .orderBy('time_stamp', descending: true)
                  .where('category_id', isEqualTo: widget.strCategoryId)
                  .snapshots(),
              //.get(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasData) {
                  //
                  var saveSnapshotValue = snapshot.data!.docs;
                  if (kDebugMode) {
                    print('dishant rajput');
                    print(saveSnapshotValue.length);
                  }
                  //
                  return Column(
                    children: [
                      for (int i = 0; i < saveSnapshotValue.length; i++) ...[
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ReviewChatScreen(
                                  strCategoryId:
                                      widget.strCategoryId.toString(),
                                  strCategoryTitle:
                                      saveSnapshotValue[i]['title'].toString(),
                                  strFirestoreIdForEdit: saveSnapshotValue[i]
                                          ['firestore_id']
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
                                      Container(
                                        // margin: const EdgeInsets.all(10.0),
                                        color: Colors.transparent,
                                        width: 50,
                                        height: 50,
                                        child: Image.network(
                                          //
                                          widget.strCategoryImage.toString(),
                                          //
                                        ),
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
                                                saveSnapshotValue[i]['title']
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
                                                'total reviews : ${saveSnapshotValue[i]['total_reviews'].toString()}',
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
                      ]
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
    );
  }

  //
  Future<void> pushToAddNewTitle(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const AddCategoryScreen(),
      ),
    );

    if (kDebugMode) {
      print('result =====> ' + result);
    }

    if (!mounted) return;

    if (result == 'back_after_add_category_title') {
      //
      setState(() {});
      //
    } else {
      if (kDebugMode) {
        print('object');
      }
    }
  }
  //
}
