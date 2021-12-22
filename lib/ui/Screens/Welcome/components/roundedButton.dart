import 'package:flutter/material.dart';

import '../../../constants.dart';


class RoundedButton extends StatelessWidget {
  final String text;
  final Function onPress;
  final Color color, textColor;

  const RoundedButton({
    Key key,
    this.text,
    this.onPress,
    this.color = kPrimaryColor,
    this.textColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: size.width * 0.8,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(29),
        child: TextButton(
          style: TextButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 40.0),
            backgroundColor: this.color,
            primary: this.textColor,
          ),
          onPressed: this.onPress,
          child: Text(this.text),
        ),
      ),
    );
  }
}
