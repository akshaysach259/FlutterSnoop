import 'package:flutter/cupertino.dart';
import 'package:snoop/data/datasource/datasource_contract.dart';
import 'package:snoop/models/chat.dart';
import 'package:snoop/models/local_message.dart';

abstract class BaseViewModel {
  IDataSource _datasource;

  BaseViewModel(this._datasource);

  @protected
  Future<void> addMessage(LocalMessage message) async {
    if (!await _isExistingChat(message.chatId)) {
      print("Creating Chat Id");
      print(message.chatId);
      await _createNewChat(message.chatId);
    }
    await _datasource.addMessage(message);
  }

  Future<bool> _isExistingChat(String chatId) async {
    return await _datasource.findChat(chatId) != null;
  }

  Future<void> _createNewChat(String chatId) async {
    final chat = Chat(chatId);
    await _datasource.addChat(chat);
  }
}
