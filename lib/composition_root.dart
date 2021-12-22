import 'package:chat/chat.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rethinkdb_dart/rethinkdb_dart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:snoop/data/datasource/services/image_uploader.dart';
import 'package:snoop/data/factory/db_factory.dart';
import 'package:snoop/states_management/message/message_bloc.dart';
import 'package:snoop/states_management/onboarding/onboarding_cubit.dart';
import 'package:snoop/states_management/onboarding/onboarding_router.dart';
import 'package:snoop/states_management/onboarding/profile_image_cubit.dart';
import 'package:snoop/states_management/receipt/receipt_bloc.dart';
import 'package:snoop/ui/Home/home_router.dart';
import 'package:snoop/ui/Screens/Chat/chat_screen.dart';
import 'package:snoop/ui/Screens/Chat/message_thread_cubit.dart';
import 'package:snoop/ui/Screens/Contacts/chats_cubit.dart';
import 'package:snoop/ui/Screens/Contacts/contact_cubit.dart';
import 'package:snoop/ui/Screens/Contacts/contacts_screen.dart';
import 'package:snoop/ui/Screens/Login/components/login_screen.dart';
import 'package:snoop/viewmodels/chat_view_model.dart';
import 'package:snoop/viewmodels/chats_view_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:chat/src/services/message/message_service_impl.dart';

import 'cache/local_cache.dart';
import 'data/datasource/datasource_contract.dart';
import 'data/datasource/sqflite_datasource.dart';

class CompositionRoot {
  static Rethinkdb _rethinkdb;
  static Connection _connection;
  static IUserService _userService;
  static Database _db;
  static IMessageService _messageService;
  static IDataSource _dataSource;
  static ILocalCache _localCache;
  static MessageBloc _messageBloc;
  static ChatsCubit _chatsCubit;

  static configure() async {
    _rethinkdb = Rethinkdb();
    _connection = await _rethinkdb.connect(host: '192.168.29.66', port: 28015);
    _userService = UserService(_rethinkdb, _connection);
    _messageService = MessageService(_rethinkdb, _connection);
    _db = await LocalDatabaseFactory().createDatabase();
    _dataSource = SqfliteDatasource(_db);
    final _sp = await SharedPreferences.getInstance();
    print("Configuring");
    _localCache = LocalCache(_sp);
    print(_localCache.fetch('USER'));
    _messageBloc = MessageBloc(_messageService);
    final viewModel = ChatsViewModel(_dataSource, _userService);
    ChatsCubit(viewModel);
  }

  static Widget composeOnboardingUI() {
    ImageUploader imageUploader =
        ImageUploader('http://192.168.29.66:3000/upload');
    OnboardingCubit onboardingCubit =
        OnboardingCubit(_userService, imageUploader, _localCache);
    ProfileImageCubit imageCubit = ProfileImageCubit();
    IOnboardingRouter onboardingRouter = OnBoardingRouter(composeHomeUI);

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) => onboardingCubit),
        BlocProvider(create: (BuildContext context) => imageCubit),
      ],
      child: LoginScreen(
        onboardingRouter: onboardingRouter,
      ),
    );
  }

  static Widget start() {
    final user = _localCache.fetch('USER');
    return user.isEmpty
        ? composeOnboardingUI()
        : composeHomeUI(User.fromJson(user));
  }

  static Widget composeHomeUI(User me) {
    HomeCubit homeCubit = HomeCubit(_userService,_localCache);
    MessageBloc messageBloc = _messageBloc;
    ChatsViewModel chatsViewModel = ChatsViewModel(_dataSource, _userService);
    ChatsCubit chatsCubit = ChatsCubit(chatsViewModel);
    IHomeRouter homeRouter = HomeRouter(showMessageThread: composeMessageThreadUi);
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => homeCubit,
        ),
        BlocProvider(
          create: (BuildContext context) => messageBloc,
        ),
        BlocProvider(
          create: (BuildContext context) => chatsCubit,
        ),
      ],
      child: ContactScreen(
        me: me,
        router: homeRouter,
      ),
    );
  }
  static Widget composeMessageThreadUi(User receiver, User me,
      {String chatId}) {
    ChatViewModel viewModel = ChatViewModel(_dataSource);
    MessageThreadCubit messageThreadCubit = MessageThreadCubit(viewModel);
    IReceiptService receiptService = ReceiptService(_rethinkdb, _connection);
    ReceiptBloc receiptBloc = ReceiptBloc(receiptService);

    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (BuildContext context) => messageThreadCubit),
          BlocProvider(create: (BuildContext context) => receiptBloc)
        ],
        child: ChatScreen(
            receiver:receiver ,currentUser: me, messageBloc: _messageBloc, chatsCubit: _chatsCubit, chatId: chatId));
  }

}
