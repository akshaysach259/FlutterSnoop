import 'package:chat/chat.dart';
import 'package:flutter/material.dart';

import '../chat_screen.dart';
import 'circular_image.dart';

class SendersBlock extends StatelessWidget {
  const SendersBlock({
    Key key,
    @required this.text, this.me,
  }) : super(key: key);

  final String text;
  final User me;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              CircularImage(
                userImageName: me.photoUrl,
              ),
            ],
          ),
        ),
        Container(
          // constraints: BoxConstraints(
          //   maxWidth: MediaQuery.of(context).size.width * 0.65,
          // ),
          child: Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.all(15),
            margin: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
                color: Colors.white,
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

            ),
          ),
        ),
      ],
    );
  }
}
