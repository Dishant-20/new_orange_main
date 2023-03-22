import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
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
      body: Column(
        children: [
          Container(
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
                          widget.strCategoryImage.toString(),
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              textWithSemiBoldStyle(
                                //
                                'BMCTM',
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
                                'total reviews : 2.1M',
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
        ],
      ),
    );
  }
}
