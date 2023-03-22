import 'package:flutter/material.dart';
import 'package:my_new_orange/header/utils/custom/app_bar.dart';

class ReviewCategoryListScreen extends StatefulWidget {
  const ReviewCategoryListScreen({super.key, required this.strCategoryName});

  final String strCategoryName;
  @override
  State<ReviewCategoryListScreen> createState() =>
      _ReviewCategoryListScreenState();
}

class _ReviewCategoryListScreenState extends State<ReviewCategoryListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarScreen(
        str_app_bar_title: widget.strCategoryName.toString(),
        str_status: '1',
      ),
    );
  }
}
