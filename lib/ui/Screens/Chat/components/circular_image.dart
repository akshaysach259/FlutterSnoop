import 'package:flutter/material.dart';

import '../../../constants.dart';

class CircularImage extends StatelessWidget {
  final String userImageName;
  const CircularImage({Key key, this.userImageName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(2),
      decoration: BoxDecoration(
        border: Border.all(
          width: 3,
          color: kBluePrimaryColor.withOpacity(0.7),
        ),
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
          ),
        ],
      ),
      child: CircleAvatar(
        radius: 15,
        backgroundImage: NetworkImage(userImageName),
      ),
    );
  }
}
