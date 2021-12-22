import 'package:bloc/bloc.dart';
import 'package:chat/chat.dart';
import 'package:snoop/cache/local_cache.dart';
import 'package:snoop/ui/Screens/Contacts/contact_state.dart';

class HomeCubit extends Cubit<HomeState>{
  final IUserService _userService;
  HomeCubit(this._userService, this._localCache) : super(HomeInitial());
  final ILocalCache _localCache;
  Future<User> connect() async {
    final userJson = _localCache.fetch('USER');
    userJson['last_seen'] = DateTime.now();
    userJson['active'] = true;

    final user = User.fromJson(userJson);
    await _userService.connect(user);
    return user;
  }

  Future<void> activeUsers(User user) async {
    emit(HomeLoading());
    final users = await _userService.online();
    print(users[0].username);
    //users.removeWhere((element) => element.id == user.id);
    emit(HomeSuccess(users));
  }

}