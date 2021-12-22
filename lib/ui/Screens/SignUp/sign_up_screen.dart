import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


import '../../constants.dart';
import 'components/body.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: kPrimaryColor,
        child: Icon(
          Icons.camera_alt,
          color: Colors.white,
        ),
      ),
      body: SingleChildScrollView(
        child: Body(),
      ),
    );
  }
}
