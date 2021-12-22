import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:snoop/composition_root.dart';
import 'package:snoop/ui/Screens/Chat/chat_screen.dart';
import 'package:snoop/ui/Screens/Contacts/contacts_screen.dart';
import 'package:snoop/ui/Screens/Login/components/login_screen.dart';
import 'package:snoop/ui/Screens/SignUp/sign_up_screen.dart';
import 'package:snoop/ui/Screens/Welcome/welcome_screen.dart';
import 'package:snoop/ui/constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CompositionRoot.configure();
  final firstPage = CompositionRoot.start();
  runApp(MyApp(firstPage:firstPage));
}

class MyApp extends StatelessWidget {
  final Widget firstPage;
  const MyApp({Key key, this.firstPage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Auth',
      theme: ThemeData(
          primaryColor: kPrimaryColor, scaffoldBackgroundColor: Colors.white),
      home: firstPage,
      routes: {
        '/welcome' : (context) => WelcomeScreen(),
        '/login' : (context) => const LoginScreen(),
        '/sign-up' : (context) => const SignUpScreen(),
        '/chat-screen' : (context) => const ChatScreen(),
        '/contact-screen' : (context) => ContactScreen(),
      },
    );
  }
}
