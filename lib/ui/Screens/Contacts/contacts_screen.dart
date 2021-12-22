import 'package:chat/chat.dart';
import 'package:flutter/material.dart';
import 'package:snoop/models/chat.dart';
import 'package:snoop/states_management/message/message_bloc.dart';
import 'package:snoop/ui/Home/home_router.dart';
import 'package:snoop/ui/Screens/Contacts/chats_cubit.dart';
import 'package:snoop/ui/Screens/Contacts/contact_cubit.dart';
import '../../constants.dart';
import 'components/category_options.dart';
import 'components/recent_chat.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'contact_state.dart';

class ContactScreen extends StatefulWidget {
  final User me;
  final IHomeRouter router;

  const ContactScreen({Key key, this.me, this.router}) : super(key: key);
  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> with AutomaticKeepAliveClientMixin{
  List<Chat> chats = [];

  @override
  void initState() {
    print("This is mee");
    print(widget.me.username);
    super.initState();
    context.read<HomeCubit>().activeUsers(widget.me);
    context.read<ChatsCubit>().chats();
    context.read<MessageBloc>().add(MessageEvent.onSubscribed(widget.me));
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: kBluePrimaryColor,
      appBar: AppBar(
        backgroundColor: kBluePrimaryColor,
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () => {},
          iconSize: 24,
          color: Colors.white,
        ),
        centerTitle: true,
        title: Text(
          "Chats",
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0.0,
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () => {},
            iconSize: 24,
            color: Colors.white,
          ),
        ],
      ),
      body: Column(
        children: [
          CategoryOptions(),
          RecentChat(me: widget.me,router: widget.router,)
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
