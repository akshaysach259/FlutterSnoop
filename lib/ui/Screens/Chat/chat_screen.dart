import 'dart:async';
import 'dart:convert';

import 'package:chat/chat.dart';
import 'package:flutter/material.dart';
import 'package:snoop/models/local_message.dart';
import 'package:snoop/states_management/message/message_bloc.dart';
import 'package:snoop/states_management/receipt/receipt_bloc.dart';
import 'package:snoop/ui/Screens/Chat/message_thread_cubit.dart';
import 'package:snoop/ui/Screens/Contacts/chats_cubit.dart';
import 'package:snoop/ui/utils/in_memory_utils.dart';


import 'components/receiver_block.dart';
import 'components/send_message_area.dart';
import 'components/senders_block.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatScreen extends StatefulWidget {
  final User receiver;
  final User currentUser;
  final String chatId;
  final MessageBloc messageBloc;
  final ChatsCubit chatsCubit;
  const ChatScreen({this.currentUser, this.receiver, this.chatId, this.messageBloc, this.chatsCubit}) : super();

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final ScrollController _scrollController = ScrollController();
  String chatId ='';
  User receiver;
  StreamSubscription _subscription;
  List<LocalMessage> messages = [];
  @override
  void initState() {
    super.initState();
    chatId = '';
    receiver = widget.receiver;
    _updateOnMessageReceived();
    _updateOnReceiptReceived();
    context.read<ReceiptBloc>().add(ReceiptEvent.onSubscribed(widget.currentUser));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF6F6F6),
      appBar: AppBar(
        centerTitle: true,
        title: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(children: [
            TextSpan(
              text: widget.receiver.username,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w400,
              ),
            ),
            TextSpan(text: "\n"),
            TextSpan(
               text: "Online",
              style: TextStyle(
                fontSize: 9,
                fontWeight: FontWeight.w400,
              ),
            )
          ]),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: BlocBuilder<MessageThreadCubit, List<LocalMessage>>(
                builder: (__, messages) {
                  print(messages);
                  this.messages = messages;
                  if (this.messages.isEmpty) {
                    return Container(color: Colors.blue);
                  }
                  return _buildListOfMessages();
                },
              ),

            ),
          ),
          SendMessageArea(me: widget.currentUser,messageBloc: widget.messageBloc,receiver: receiver,)
        ],
      ),
    );
  }

  void _updateOnMessageReceived() {
    final messageThreadCubit = context.read<MessageThreadCubit>();
    if (chatId.isNotEmpty) messageThreadCubit.messages(chatId);
    _subscription = widget.messageBloc.stream.listen((state) async {
      if (state is MessageReceivedSuccess) {
        await messageThreadCubit.viewModel.receivedMessage(state.message);
        final receipt = Receipt(
          recipient: state.message.from,
          messageId: state.message.id,
          status: ReceiptStatus.read,
          timestamp: DateTime.now(),
        );
        context.read<ReceiptBloc>().add(ReceiptEvent.onMessageSent(receipt));
      }
      if (state is MessageSentSuccess) {
        await messageThreadCubit.viewModel.sentMessage(state.message);
      }
      if (chatId.isEmpty) chatId = messageThreadCubit.viewModel.chatId;
      messageThreadCubit.messages(chatId);
    });
  }
  void _updateOnReceiptReceived() {
    final messageThreadCubit = context.read<MessageThreadCubit>();
    context.read<ReceiptBloc>().stream.listen((state) async {
      if (state is ReceiptReceivedSuccess) {
        await messageThreadCubit.viewModel.updateMessageReceipt(state.receipt);
        messageThreadCubit.messages(chatId);
        widget.chatsCubit.chats();
      }
    });
  }

  Widget _buildListOfMessages() => ListView.builder(itemBuilder: (__,index){
    if(messages[index].message.from == receiver.id){
      return SendersBlock(text: messages[index].message.contents.toString(),me: widget.currentUser);
    }else{
      return ReceiverBlock(text: messages[index].message.contents.toString(),me: widget.receiver,);
    }
  }, itemCount: messages.length,
    controller: _scrollController,
    scrollDirection: Axis.vertical,
    shrinkWrap: true,
    physics: const AlwaysScrollableScrollPhysics(),
    addAutomaticKeepAlives: true,
  );

  _sendReceipt(LocalMessage message) async {
    if (message.receipt == ReceiptStatus.read) return;
    final receipt = Receipt(
      recipient: message.message.from,
      messageId: message.id,
      status: ReceiptStatus.read,
      timestamp: DateTime.now(),
    );
    context.read<ReceiptBloc>().add(ReceiptEvent.onMessageSent(receipt));
    await context
        .read<MessageThreadCubit>()
        .viewModel
        .updateMessageReceipt(receipt);
  }
  _scrollToEnd() {
    _scrollController.animateTo(_scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 200), curve: Curves.easeInOut);
  }

}


class _updateOnReceiptReceived {
}