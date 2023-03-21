import 'package:flutter/material.dart';
import 'package:my_new_orange/header/utils/Utils.dart';
// import 'package:shaawl/classes/headers/utils/utils.dart';

class PublicRoomHeader extends StatelessWidget {
  const PublicRoomHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Align(
          alignment: Alignment.topCenter,
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              margin: const EdgeInsets.only(left: 20, top: 50.0),
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: Colors.amber[600],
                borderRadius: BorderRadius.circular(
                  26,
                ),
              ),
              child: const Icon(
                Icons.chevron_left,
              ),
            ),
          ),
        ),
        //
        Align(
          alignment: Alignment.topCenter,
          child: Container(
            margin: const EdgeInsets.only(left: 4, top: 50.0),
            // width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: Colors.amber[600],
              borderRadius: BorderRadius.circular(
                26,
              ),
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: textWithRegularStyle(
                  'Public Room',
                  16.0,
                  Colors.black,
                  'left',
                ),
              ),
            ),
          ),
        ),
        //

        //
      ],
    );
  }
}
