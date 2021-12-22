import 'package:bloc/bloc.dart';
import 'package:snoop/models/chat.dart';
import 'package:snoop/viewmodels/chats_view_model.dart';

class ChatsCubit extends Cubit<List<Chat>>{
  final ChatsViewModel chatsViewModel;
  ChatsCubit(this.chatsViewModel) : super([]);

  Future<void> chats() async {
    final chats = await chatsViewModel.getChats();
    emit(chats);
  }
}
