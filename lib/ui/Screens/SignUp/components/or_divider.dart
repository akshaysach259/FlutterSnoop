import 'package:flutter/material.dart';

import '../../../constants.dart';

class OrDivider extends StatelessWidget {
  const OrDivider({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.8,
      child: Row(
        children: [
          dividerLine(),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Text(
              " OR ",
              style:
                  TextStyle(color: kPrimaryColor, fontWeight: FontWeight.bold),
            ),
          ),
          dividerLine(),
        ],
      ),
    );
  }

  Expanded dividerLine() {
    return const Expanded(
      child: Divider(
        color: kPrimaryColor,
      ),
    );
  }
}
