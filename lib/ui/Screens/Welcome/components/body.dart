import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:snoop/ui/Screens/Welcome/components/roundedButton.dart';
import 'package:snoop/ui/utils/in_memory_utils.dart';

import '../../../constants.dart';
import 'background.dart';


class Body extends StatelessWidget {
  const Body({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Background(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Thanks for choosing SNOOP",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: kPrimaryColor,
              fontSize: 22.0,
            ),
          ),
          SizedBox(
            height: size.height * 0.05,
          ),
          SvgPicture.asset(
            "./lib/ui/assets/icons/welcome.svg",
            width: size.width * 0.9,
          ),
          SizedBox(
            height: size.height * 0.05,
          ),
          RoundedButton(
            text: "LOGIN",
            onPress: () => {
                Navigator.pushNamed(context, "/login")
            },
          ),
          RoundedButton(
            text: "Register",
            color: kPrimaryLightColor,
            textColor: kPrimaryColor,
            onPress: () => {
              Navigator.pushNamed(context, "/sign-up")
              }
          )
        ],
      )),
    );
  }
}
