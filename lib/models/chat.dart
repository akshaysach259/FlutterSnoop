import 'package:chat/chat.dart';
import 'package:snoop/models/local_message.dart';

class Chat{
  String id;
  int unread = 0;
  List<LocalMessage> messages = [];
  User from;
  LocalMessage mostRecent;

  Chat(this.id, {this.messages, this.mostRecent});

  toMap() => {'id':id};
  factory Chat.fromMap(Map<String,dynamic> json) => Chat(json['id']);
}