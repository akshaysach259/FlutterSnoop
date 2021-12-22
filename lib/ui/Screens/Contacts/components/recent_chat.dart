
import 'package:chat/chat.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snoop/models/chat.dart';
import 'package:snoop/states_management/message/message_bloc.dart';
import 'package:snoop/ui/Home/home_router.dart';
import 'package:snoop/ui/Screens/Contacts/components/recent_chat_block.dart';
import 'package:snoop/ui/Screens/Contacts/contact_cubit.dart';
import 'package:snoop/ui/Screens/Contacts/contact_state.dart';

import '../chats_cubit.dart';


class RecentChat extends StatefulWidget {
  final IHomeRouter router;
  final User me;
  const RecentChat({
    Key key, this.router, this.me,
  }) : super(key: key);

  @override
  State<RecentChat> createState() => _RecentChatState();
}

class _RecentChatState extends State<RecentChat> {
  List<Chat> chats = [];

  @override
  void initState() {
    _updateChatOnMessageReceived();
    context.read<ChatsCubit>().chats();
  }
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.only(top: 12, bottom: 0, right: 5, left: 5),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50),
            topRight: Radius.circular(50),
          ),
        ),
        child: BlocBuilder<HomeCubit,HomeState>(builder: (_,state){
          if(state is HomeLoading){
            print("Home Loading");
            return const Center(child: CircularProgressIndicator(),);
          }
          if(state is HomeSuccess){
            print("Home Success");
           return _buildList(state.onlineUsers);
          }
          return Container(child: RecentChatBlock(user: User(username: "Akshay2", photoUrl: "http://192.168.29.66:3000/images/profile/scaled_image_picker9035402752632242828.jpg", active: true, lastseen: DateTime.now()),),);
        }),
      ),
    );
  }

  void _updateChatOnMessageReceived() async {
    final chatsCubit = context.read<ChatsCubit>();
    print("---------------");
    print(chatsCubit.chats());
    List<Chat> chats= await chatsCubit.chatsViewModel.getChats();
    print("----!");
    print(chats);
    context.read<MessageBloc>().stream.listen((state) async {
      if(state is MessageReceivedSuccess){
        await chatsCubit.chatsViewModel.receivedMessage(state.message);
        chatsCubit.chats();
      }else {
        print("Not Yet");
      }
    });
  }

  String _lastChat() {
    ListView.builder(itemBuilder: (BuildContext context, index){
      print("----");
      print(chats[index].messages);

      return Text("Hello");
    });
  }

  Widget _buildList(List<User> onlineUsers) {
    return ListView.builder(itemBuilder: (BuildContext context, index) => RecentChatBlock(user: onlineUsers[index],lastChat: _lastChat(),onTap: () async {
      print("Hello");
      await this.widget.router.onShowMessageThread(context, onlineUsers[index], widget.me);
    },),itemCount: onlineUsers.length);
  }
}

