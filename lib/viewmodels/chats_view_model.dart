import 'package:chat/chat.dart';
import 'package:flutter/cupertino.dart';
import 'package:snoop/data/datasource/datasource_contract.dart';
import 'package:snoop/models/chat.dart';
import 'package:snoop/models/local_message.dart';
import 'package:snoop/viewmodels/base_view_model.dart';

class ChatsViewModel extends BaseViewModel {
  IDataSource _datasource;
  IUserService _userService;

  ChatsViewModel(this._datasource, this._userService) : super(_datasource);

  Future<List<Chat>> getChats() async {
    final chats = await _datasource.findAllChats();
    await Future.forEach(chats, (chat) async {
      final user = await _userService.fetch(chat.id);
      chat.from = user;
    });

    return chats;
  }

  Future<void> receivedMessage(Message message) async {
    LocalMessage localMessage =
    LocalMessage(message.from, message, ReceiptStatus.deliverred);
    await addMessage(localMessage);
  }
}

