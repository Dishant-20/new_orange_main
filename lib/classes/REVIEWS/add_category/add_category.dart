import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:my_new_orange/header/utils/Utils.dart';
import 'package:my_new_orange/header/utils/custom/app_bar.dart';
import 'package:uuid/uuid.dart';

import '../../database/database_helper.dart';
// import '../../database/database_modal.dart';

import 'package:dropdown_button2/dropdown_button2.dart';

// import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class AddCategoryScreen extends StatefulWidget {
  const AddCategoryScreen({super.key});

  @override
  State<AddCategoryScreen> createState() => _AddCategoryScreenState();
}

class _AddCategoryScreenState extends State<AddCategoryScreen> {
  //
  late DataBase handler;
  //
  final formKey = GlobalKey<FormState>();
  var arrCategoryList = [];
  //
  var strSaveCategoryId = '0';
  var strSaveCategoryName = '0';
  var strSaveCategoryImage = '0';
  //
  late final TextEditingController contCategoryName;
  late final TextEditingController contTitle;
  late final TextEditingController contType;
  //
  final List<String> items = [
    'Hollywood',
    'Bollywood',
    'Tollywood',
    'Kollywood',
  ];
  String? selectedValue;
  //
  @override
  void initState() {
    super.initState();
    //
    contCategoryName = TextEditingController();
    contTitle = TextEditingController();
    contType = TextEditingController();
    //
    handler = DataBase();
    handler.retrievePlanets().then(
      (value) {
        if (kDebugMode) {
          print(value.length);
          print('YES, LOCAL DB HAVE SOME DATA');
        }
        //
        // var arrCategoryList = [];
        for (int i = 0; i < value.length; i++) {
          if (kDebugMode) {
            // print(value[i].categoryId);
            // print(value[i].categoryName);
            // print(value[i].categoryImage);
            print('***************************');
          }
          //
          arrCategoryList.add({
            'id': value[i].categoryId,
            'name': value[i].categoryName,
            'image': value[i].categoryImage,
          });
          //
        }
        //
        if (kDebugMode) {
          print(arrCategoryList);
        }
      },
    );
    //
  }

  @override
  void dispose() {
    //
    contCategoryName.dispose();
    contTitle.dispose();
    //
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarScreen(
        str_app_bar_title: 'Add Category',
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
                  readOnly: true,
                  decoration: InputDecoration(
                    hintText: "select category...",
                    labelText: 'Category',
                    hintStyle: TextStyle(color: Colors.grey.shade600),
                    prefixIcon: Icon(
                      Icons.category,
                      color: Colors.grey.shade600,
                      size: 30,
                    ),
                    suffixIcon: Icon(
                      Icons.arrow_drop_down,
                      color: Colors.grey.shade600,
                      size: 30,
                    ),
                    filled: false,
                    fillColor: Colors.grey.shade100,
                    // contentPadding: const EdgeInsets.all(8),
                    // contentPadding: const EdgeInsets.symmetric(
                    // vertical: 10, // text field height
                    // ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(
                        color: Colors.transparent,
                      ),
                    ),
                  ),
                  onTap: () {
                    //
                    funcBottomSheet();
                    //
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select Category';
                    }
                    return null;
                  },
                ),
              ),
            ),
            //
            Container(
              margin: const EdgeInsets.all(10.0),
              color: Colors.amber[600],
              width: MediaQuery.of(context).size.width,
              height: 1,
            ),
            //
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                // width: 100,
                child: TextFormField(
                  controller: contTitle,
                  decoration: InputDecoration(
                    hintText: "title...",
                    labelText: 'Title',
                    hintStyle: TextStyle(color: Colors.grey.shade600),
                    prefixIcon: Icon(
                      Icons.house_rounded,
                      color: Colors.grey.shade600,
                      size: 30,
                    ),
                    filled: false,
                    fillColor: Colors.grey.shade100,
                    // contentPadding: const EdgeInsets.all(8),
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 20.0, // text field height
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(
                        color: Colors.transparent,
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Title';
                    }
                    return null;
                  },
                ),
              ),
            ),
            //
            Container(
              margin: const EdgeInsets.all(10.0),
              color: Colors.amber[600],
              width: MediaQuery.of(context).size.width,
              height: 1,
            ),
            //
            /*Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                // width: 100,
                child: TextFormField(
                  controller: contType,
                  readOnly: true,
                  decoration: InputDecoration(
                    hintText: "select type...",
                    labelText: 'Type',
                    hintStyle: TextStyle(color: Colors.grey.shade600),
                    prefixIcon: Icon(
                      Icons.category,
                      color: Colors.grey.shade600,
                      size: 30,
                    ),
                    suffixIcon: Icon(
                      Icons.arrow_drop_down,
                      color: Colors.grey.shade600,
                      size: 30,
                    ),
                    filled: false,
                    fillColor: Colors.grey.shade100,
                    // contentPadding: const EdgeInsets.all(8),
                    // contentPadding: const EdgeInsets.symmetric(
                    // vertical: 10, // text field height
                    // ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(
                        color: Colors.transparent,
                      ),
                    ),
                  ),
                  onTap: () {
                    //
                    DropdownButtonHideUnderline(
                      child: DropdownButton2(
                        hint: Text(
                          'Select Item',
                          style: TextStyle(
                            fontSize: 14,
                            color: Theme.of(context).hintColor,
                          ),
                        ),
                        items: items
                            .map((item) => DropdownMenuItem<String>(
                                  value: item,
                                  child: Text(
                                    item,
                                    style: const TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                ))
                            .toList(),
                        value: selectedValue,
                        onChanged: (value) {
                          setState(() {
                            selectedValue = value as String;
                          });
                        },
                        buttonStyleData: const ButtonStyleData(
                          height: 40,
                          width: 140,
                        ),
                        menuItemStyleData: const MenuItemStyleData(
                          height: 40,
                        ),
                      ),
                    );
                    //
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select Category';
                    }
                    return null;
                  },
                ),
              ),
            ),*/
            DropdownButtonHideUnderline(
              child: DropdownButton2(
                hint: Text(
                  'Select TYPE',
                  style: TextStyle(
                    fontSize: 14,
                    color: Theme.of(context).hintColor,
                  ),
                ),
                items: items
                    .map((item) => DropdownMenuItem<String>(
                          value: item,
                          child: Text(
                            item,
                            style: const TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ))
                    .toList(),
                value: selectedValue,
                onChanged: (value) {
                  setState(() {
                    selectedValue = value as String;
                  });
                },
                buttonStyleData: const ButtonStyleData(
                  height: 40,
                  width: 140,
                ),
                menuItemStyleData: const MenuItemStyleData(
                  height: 40,
                ),
              ),
            ),
            //
            Container(
              margin: const EdgeInsets.all(10.0),
              color: Colors.amber[600],
              width: MediaQuery.of(context).size.width,
              height: 1,
            ),
            //
            Center(
              child: InkWell(
                onTap: () {
                  if (formKey.currentState!.validate()) {
                    // ScaffoldMessenger.of(context).showSnackBar(
                    //   const SnackBar(
                    //     content: Text(
                    //       'Processing Data',
                    //     ),
                    //   ),
                    // );
                    //
                    funcSetProfileForChat();
                  }
                },
                child: Container(
                  margin: const EdgeInsets.all(10.0),
                  color: Colors.amber[600],
                  width: 48.0,
                  height: 48.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  //
  // CHECK THIS TITLE ALREADY EXIST IN SERVER OR NOT
  funcSetProfileForChat() {
    FirebaseFirestore.instance
        .collection("${strFirebaseMode}add_review")
        .doc("India")
        .collection("details")
        .where('category_id', isEqualTo: strSaveCategoryId.toString())
        .where('title', isEqualTo: contTitle.text.toString())
        .get()
        .then((value) {
      if (kDebugMode) {
        print(value.docs);
      }

      if (value.docs.isEmpty) {
        if (kDebugMode) {
          print('======> NO USER FOUND');
        }
        //
        funcAddCategory(
          strSaveCategoryId,
          contCategoryName.text,
          strSaveCategoryImage,
        );
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
          //
          funcThisTitleAlreadyRegister();
          //
        }
      }
    });
    // );
  }

  //
  //
  funcAddCategory(
    String categoryId,
    String categoryName,
    String categoryImage,
  ) {
    var chatUserId = const Uuid().v4();
    if (kDebugMode) {
      print(chatUserId);
    }

    CollectionReference users = FirebaseFirestore.instance
        .collection('${strFirebaseMode}add_review/India/details');

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
                  .collection("${strFirebaseMode}add_review")
                  .doc('India')
                  .collection('details')
                  .doc(value.id)
                  .set(
            {
              'firestore_id': value.id,
              'title': contTitle.text.toString(),
              'category_id': categoryId.toString(),
              'category_name': categoryName.toString(),
              'category_image': categoryImage.toString(),
              'time_stamp': DateTime.now().millisecondsSinceEpoch,
              'movie_type': selectedValue.toString(),
              'total_likes': '0',
              'total_views': '0',
              'total_reviews': '0',
            },
            SetOptions(merge: true),
          ).then(
            (value1) {
              //
              Navigator.pop(context, 'back_after_add_category_title');
              //
            },
          ),
        )
        .catchError(
          (error) => print("Failed to add user: $error"),
        );
  }

  //
  //
  funcBottomSheet() {
    showModalBottomSheet(
      context: context,
      // color is applied to main screen when modal bottom screen is displayed
      // barrierColor: Colors.grey,
      //background color for modal bottom screen
      backgroundColor: Colors.white,
      //elevates modal bottom screen
      elevation: 1,

      // gives rounded corner to modal bottom screen
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      builder: (BuildContext context) {
        // UDE : SizedBox instead of Container for whitespaces
        return SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              for (int i = 0; i < arrCategoryList.length; i++) ...[
                InkWell(
                  onTap: () {
                    //
                    contCategoryName.text =
                        arrCategoryList[i]['name'].toString();
                    //
                    strSaveCategoryId = arrCategoryList[i]['id'].toString();
                    strSaveCategoryImage =
                        arrCategoryList[i]['image'].toString();
                    //
                    Navigator.of(context).pop();
                    //
                  },
                  child: ListTile(
                    title: textWithRegularStyle(
                      //
                      arrCategoryList[i]['name'].toString(),
                      //
                      14.0,
                      Colors.black,
                      'left',
                    ),
                    // onTap: () =>
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(10.0),
                  color: Colors.amber[600],
                  width: MediaQuery.of(context).size.width,
                  height: 1,
                )
              ]

              //
            ],
          ),
        );
      },
    );
  }

  //
  funcThisTitleAlreadyRegister() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                20.0,
              ),
            ), //this right here
            child: SizedBox(
              height: 300,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    text_with_bold_style(
                      //
                      'Already Exist\n',
                      //
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    text_with_regular_style(
                      'This Title is already exist. Please choose different Title.',
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      margin: const EdgeInsets.all(10.0),
                      width: 60.0,
                      height: 60.0,
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(230, 230, 230, 1),
                        borderRadius: BorderRadius.circular(
                          30,
                        ),
                        border: Border.all(
                          color: Colors.grey,
                        ),
                      ),
                      child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.close,
                        ),
                      ),
                    ),
                    // SizedBox(
                    //   width: 320.0,
                    //   child: ElevatedButton(
                    //     onPressed: () {},
                    //     child: Text(
                    //       "Save",
                    //       style: TextStyle(color: Colors.white),
                    //     ),
                    //     // color: const Color(0xFF1BC0C5),
                    //   ),
                    // )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
