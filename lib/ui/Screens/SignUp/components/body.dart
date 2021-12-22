import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:snoop/ui/Screens/Login/components/already_have_an_account.dart';
import 'package:snoop/ui/Screens/Login/components/login_screen.dart';
import 'package:snoop/ui/Screens/Login/components/rounded_text_field.dart';
import 'package:snoop/ui/Screens/Welcome/components/roundedButton.dart';


import '../../../constants.dart';
import 'background.dart';


class Body extends StatefulWidget {
  const Body({Key key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    TextEditingController _emailController = TextEditingController();
    TextEditingController _userNameController = TextEditingController();
    TextEditingController _phoneNumberController = TextEditingController();
    Size size = MediaQuery.of(context).size;
    String saveUserResponse = "s";
    Color saveUserStatusColor = Colors.green;
    return Background(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Register",
            style: TextStyle(
              color: kPrimaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 22.0,
            ),
          ),
          SizedBox(
            height: size.height * .02,
          ),
          SvgPicture.asset(
            "./lib/ui/assets/icons/sign_up.svg",
            height: size.height * 0.29,
          ),
          SizedBox(
            height: 20,
          ),
          RoundedTextField(
            editingController: _userNameController,
            hintText: "Username",
          ),
          RoundedTextField(
            icon: Icons.email,
            editingController: _emailController,
            hintText: "Email",
          ),
          RoundedTextField(
            icon: Icons.phone_android,
            editingController: _phoneNumberController,
            hintText: "Phone Number",
          ),
          RoundedButton(
            text: "Sign Up",
            onPress: () {},
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: AlreadyHaveAnAccount(
              onPress: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return const LoginScreen();
                  },
                ));
              },
              login: false,
            ),
          ),
        ],
      ),
    );
  }
}
