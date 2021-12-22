import 'package:chat/chat.dart';
import 'package:flutter/material.dart';


import '../../../constants.dart';
import '../chat_screen.dart';
import 'circular_image.dart';

class ReceiverBlock extends StatelessWidget {
  const ReceiverBlock({
    Key key,
    @required this.text, this.me,
  }) : super(key: key);
  final User me;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topRight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            // constraints: BoxConstraints(
            //   maxWidth: MediaQuery.of(context).size.width * 0.65,
            // ),
            child: Container(
              alignment: Alignment.topRight,
              padding: EdgeInsets.all(15),
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              decoration: BoxDecoration(
                  color: kPrimaryColor,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                    )
                  ]),
              child: Text(
                text,
                textAlign: TextAlign.left,
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          Row(
            children: [
              CircularImage(
                 userImageName: me.photoUrl
              ),
              const SizedBox(
                width: 10,
              ),
            ],
          )
        ],
      ),
    );
  }
}
