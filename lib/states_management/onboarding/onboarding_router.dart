import 'package:chat/chat.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

abstract class IOnboardingRouter {
  void onSessionSuccess(BuildContext context,User user);
}

class OnBoardingRouter implements IOnboardingRouter{

  final Widget Function(User me) onSessionConnected;

  OnBoardingRouter(this.onSessionConnected);

  @override
  void onSessionSuccess(BuildContext context, User me) {
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_)=>onSessionConnected(me)), (Route<dynamic> route) => false);
  }

}