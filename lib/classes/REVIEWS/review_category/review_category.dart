// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:my_new_orange/classes/REVIEWS/review_category/review_category_list/review_category_list.dart';
import 'package:my_new_orange/header/utils/Utils.dart';
import 'package:my_new_orange/header/utils/custom/app_bar.dart';
// import 'package:sqflite/sqflite.dart';

// import 'package:my_new_orange/classes/database/database_helper.dart';
// import 'package:path/path.dart';
// import 'package:sqflite/sqflite.dart';

// local DB
// import 'package:path/path.dart';
// import 'package:sqflite/sqflite.dart';

import '../../database/database_helper.dart';
import '../../database/database_modal.dart';

class ReviewCategoryScreen extends StatefulWidget {
  const ReviewCategoryScreen({super.key});

  @override
  State<ReviewCategoryScreen> createState() => _ReviewCategoryScreenState();
}

class _ReviewCategoryScreenState extends State<ReviewCategoryScreen> {
  //
  late DataBase handler;
  //
  List<Map<String, dynamic>> myData = [];
  // List<Map<Planets>> myData = [];
  // List
  //
  // <List<Planets>>
  var strCategoryLoader = '0';
  //
  bool isLoading = true;
  // This function is used to fetch all data from the database

  //
  var saveElementId = [];
  //
  @override
  void initState() {
    super.initState();

    // addItem
    handler = DataBase();

    // first get data from local DB
    handler.retrievePlanets().then(
      (value) {
        if (kDebugMode) {
          print(value.length);
        }
        if (value.isEmpty) {
          if (kDebugMode) {
            print('NO, LOCAL DB DOES NOT HAVE ANY DATA');
          }
          // call firebase server
          setState(() {
            strCategoryLoader = '1';
          });
        } else {
          if (kDebugMode) {
            print('YES, LOCAL DB HAVE SOME DATA');
          }
          //
          setState(() {
            strCategoryLoader = '2';
          });
        }
      },
    );
    //
  }

  // Future<int> rererer() async {}
  Future<int> addPlanets(arrGetAllCategoryData) async {
    //
    // print('dishant rajput');
    // print(arrGetAllCategoryData[0]['category_name']);

    List<Planets> planets = [];
    //
    for (int i = 0; i < arrGetAllCategoryData.length; i++) {
      Planets one = Planets(
        id: i + 1,
        categoryId: arrGetAllCategoryData[i]['category_id'].toString(),
        categoryImage: arrGetAllCategoryData[i]['category_image'].toString(),
        categoryName: arrGetAllCategoryData[i]['category_name'].toString(),
        timeStamp: arrGetAllCategoryData[i]['time_stamp'].toString(),
        totalItem: arrGetAllCategoryData[i]['total_items'].toString(),
      );

      planets.add(one);
    }

    return await handler.insertPlanets(planets);
  }

  // Define a function that inserts dogs into the database

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
      body: (strCategoryLoader == '0')
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  if (strCategoryLoader == '2')
                    listShowViaDB
                  else
                    listShowViaFB,
                ],
              ),
            ),
    );
  }

  FutureBuilder<QuerySnapshot<Map<String, dynamic>>> get listShowViaFB {
    return FutureBuilder(
        // future: handler.retrievePlanets(),
        future: FirebaseFirestore.instance
            .collection('${strFirebaseMode}reviews')
            .doc('India')
            .collection('details')
            .orderBy('time_stamp', descending: false)
            .get(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot)
            // (BuildContext context,
            // AsyncSnapshot<List<Planets>> snapshot)
            {
          if (snapshot.hasData) {
            if (kDebugMode) {
              print('YES, CATEGORY HAS DATA');
            }

            //
            var saveSnapshotValue = snapshot.data!.docs;

            addPlanets(saveSnapshotValue);
            //
            // var saveSnapshotValue = snapshot.data!;

            for (int i = 0; i < saveSnapshotValue.length; i++) {
              if (kDebugMode) {
                // print(i);
                // print(saveSnapshotValue[i]['category_name'].toString());
                // print(saveSnapshotValue[i]['category_image'].toString());
                // print(saveSnapshotValue[i]['total_items'].toString());
              }
              //

              // refreshData();
              //
            }

            //
            if (kDebugMode) {}

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
                              strCategoryId: saveSnapshotValue[i]['category_id']
                                  .toString(),
                              strCategoryImage: saveSnapshotValue[i]
                                      ['category_image']
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
                                            'Total ${saveSnapshotValue[i]['category_name']} : ${saveSnapshotValue[i]['total_items']}',
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
        );
  }

  FutureBuilder<List<Planets>> get listShowViaDB {
    return FutureBuilder(
        future: handler.retrievePlanets(),
        builder: (BuildContext context, AsyncSnapshot<List<Planets>> snapshot) {
          if (snapshot.hasData) {
            if (kDebugMode) {
              print('YES, CATEGORY HAS DATA DB');
            }

            var saveSnapshotValue = snapshot.data!;
            // addPlanets(saveSnapshotValue);

            for (int i = 0; i < saveSnapshotValue.length; i++) {
              if (kDebugMode) {
                // print(i);
              }
              //

              // refreshData();
              //
            }

            //
            if (kDebugMode) {
              // print(snapshot.hasData);
            }

            return SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  for (int i = 0; i < saveSnapshotValue.length; i++) ...[
                    InkWell(
                      onTap: () {
                        print('RETRIEVE DATA BY ID');
                        handler
                            .retrievePlanetsById(1)
                            .then((value) => {print(value[0].categoryName)});

                        print(saveSnapshotValue);

                        // List<Planets> groceryList = saveSnapshotValue.isNotEmpty
                        //     ? saveSnapshotValue
                        //         .map((c) =>
                        //             Planets.fromMap(c as Map<String, dynamic>))
                        //         .toList()
                        //     : [];

                        // print(groceryList);

                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => ReviewCategoryListScreen(
                        //       strCategoryName:
                        //           saveSnapshotValue[i].categoryName.toString(),
                        //       strCategoryId:
                        //           saveSnapshotValue[i].categoryId.toString(),
                        //       strCategoryImage:
                        //           saveSnapshotValue[i].categoryImage.toString(),
                        //     ),
                        //   ),
                        // );
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
                                      saveSnapshotValue[i]
                                          .categoryImage
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
                                                .categoryName
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
                                            'Total ${saveSnapshotValue[i].categoryName} :: ${saveSnapshotValue[i].totalItem.toString()}',
                                            //
                                            14.0,
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
        );
  }
}
