import 'dart:convert';
import 'package:chat/chat.dart';
import 'package:flutter/material.dart';
import 'package:snoop/states_management/message/message_bloc.dart';

import '../../../constants.dart';

class SendMessageArea extends StatefulWidget {
  final User me;
  final User receiver;
  final MessageBloc messageBloc;
  const SendMessageArea({Key key, this.me, this.receiver, this.messageBloc}) : super(key: key);
  
  @override
  State<SendMessageArea> createState() => _SendMessageAreaState();
}

class _SendMessageAreaState extends State<SendMessageArea> {
  @override
  Widget build(BuildContext context) {
    TextEditingController messageController = new TextEditingController();
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8),
      height: 70,
      color: Colors.white,
      child: Row(
        children: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.photo),
            iconSize: 25,
            color: kPrimaryColor,
          ),
          Expanded(
            child: TextField(
              controller: messageController,
              decoration:
              InputDecoration.collapsed(hintText: "Send a message..."),
              textCapitalization: TextCapitalization.sentences,
            ),
          ),
          IconButton(
            onPressed: (){_sendMeassage(messageController);},
            icon: Icon(Icons.send),
            iconSize: 25,
            color: kPrimaryColor,
          ),
        ],
      ),
    );
  }

  _sendMeassage(TextEditingController messageController, ) {
    print("Clicked");
    if (messageController.text.isEmpty) return;
    final message = Message(
        from: widget.me.id,
        to: widget.receiver.id,
        timestamp: DateTime.now(),
        contents: messageController.text,);

    final sendMessageEvent = MessageEvent.onMessageSent(message);
    widget.messageBloc.add(sendMessageEvent);

    messageController.clear();
  }
}
