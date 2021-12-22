import 'package:flutter/material.dart';

import '../../../constants.dart';

class AlreadyHaveAnAccount extends StatelessWidget {
  final bool login;
  final Function onPress;
  const AlreadyHaveAnAccount({
    Key key,
    this.login = true,
    @required this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          login ? "Don't have an account ? " : "Already have an Account ?",
          style: TextStyle(color: kPrimaryColor),
        ),
        GestureDetector(
          onTap: onPress,
          child: Text(
            login ? "Create Account" : " Sign In",
            style: TextStyle(color: kPrimaryColor, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}
