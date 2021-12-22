import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:snoop/ui/Screens/Contacts/contacts_screen.dart';
import 'package:snoop/ui/Screens/Login/components/login_screen.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return ContactScreen();
  }
}
