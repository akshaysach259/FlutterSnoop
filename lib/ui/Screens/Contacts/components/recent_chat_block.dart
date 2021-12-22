import 'dart:async';

import 'package:chat/chat.dart';
import 'package:flutter/material.dart';
import 'package:snoop/models/chat.dart';
import 'package:snoop/states_management/message/message_bloc.dart';
import 'package:snoop/states_management/typing/typing_notification_bloc.dart';
import 'package:snoop/ui/Home/home_router.dart';
import 'package:snoop/ui/Screens/Chat/chat_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../../../constants.dart';
import '../chats_cubit.dart';

class RecentChatBlock extends StatefulWidget {
  const RecentChatBlock({
    Key key, this.user, this.lastChat, this.onTap,
  }) : super(key: key);
  final User user;
  final Function onTap;
  final String lastChat;
  @override
  State<RecentChatBlock> createState() => _RecentChatBlockState();
}

class _RecentChatBlockState extends State<RecentChatBlock> {
  final String defaultImage = "http://10.0.2.2:3000/images/profile/scaled_image_picker9035402752632242828.jpg";
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String message = "Hello i am a message";
    List<Chat> chats = [];
    return InkWell(
      onTap: widget.onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(2),
              decoration: BoxDecoration(
                border: Border.all(
                  width: 3,
                  color: kBluePrimaryColor.withOpacity(0.7),
                ),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                  ),
                ],
              ),
              child:  CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(widget.user.photoUrl != null? widget.user.photoUrl : defaultImage),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.72,
              padding: EdgeInsets.only(
                left: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            widget.user.username,
                            style: TextStyle(
                              color: kBluePrimaryColor.withOpacity(0.9),
                              fontSize: 19,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 5),
                            width: 7,
                            height: 7,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: kBluePrimaryColor,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "12:30pm",
                        style: TextStyle(
                          color: Colors.grey.withOpacity(0.9),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 6),
                    child: BlocBuilder<ChatsCubit,List<Chat>>(builder: (_ ,chats){
                      return Text(widget.lastChat!= null? widget.lastChat : "Hey");
                    }),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

}
