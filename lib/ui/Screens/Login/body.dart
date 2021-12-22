import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:snoop/states_management/onboarding/onboarding_cubit.dart';
import 'package:snoop/states_management/onboarding/onboarding_router.dart';
import 'package:snoop/states_management/onboarding/onboarding_state.dart';
import 'package:snoop/states_management/onboarding/profile_image_cubit.dart';
import 'package:snoop/ui/Screens/SignUp/sign_up_screen.dart';
import 'package:snoop/ui/Screens/Welcome/components/roundedButton.dart';

import '../../constants.dart';
import 'components/already_have_an_account.dart';
import 'components/background.dart';
import 'components/profile_upload.dart';
import 'components/rounded_text_field.dart';

class Body extends StatelessWidget {
  final IOnboardingRouter router;
  const Body({
    Key key, @required this.router
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController _phoneNumberController = TextEditingController();
    Size size = MediaQuery.of(context).size;
    return Background(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Login".toUpperCase(),
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22.0,
              color: kPrimaryColor,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          SvgPicture.asset(
            "./lib/ui/assets/icons/password.svg",
            height: size.height * 0.3,
          ),
          const SizedBox(
            height: 10,
          ),
          InkWell(
            onTap: () async {
              await context.read<ProfileImageCubit>().getImage();
            },
            child: const ProfileUpload(),
          ),
          const SizedBox(
            height: 10,
          ),
          RoundedTextField(
            editingController: _phoneNumberController,
            hintText: "Your Phone Number",
            onChanged: (value) {},
            inputType: TextInputType.number,
          ),
          const SizedBox(
            height: 2,
          ),
          const SizedBox(
            height: 10,
          ),
          RoundedButton(
            text: "LOGIN",
            onPress: () async {
              final error = _checkInputs(context);
              if(error.isNotEmpty){
                final snackbar = SnackBar(content: Text(
                  error,style: const TextStyle(fontSize: 14.0,fontWeight: FontWeight.bold),
                ));
                ScaffoldMessenger.of(context).showSnackBar(snackbar);
              }
              _connectSession(_phoneNumberController.text,context);
            },
          ),
          const SizedBox(
            height: 10,
          ),
          BlocConsumer<OnboardingCubit,OnboardingState>(builder: (context,state)=> state is Loading ? const Center(child: CircularProgressIndicator()) : Container(), listener: (_,state){
            if(state is OnboardingSuccess){
               router.onSessionSuccess(context, state.user);
            }
          }),
          AlreadyHaveAnAccount(
            onPress: () => {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return SignUpScreen();
                  },
                ),
              ),
            },
          ),
        ],
      ),
    );

  }
  _connectSession(String username,BuildContext context) async {
    final profileImage = context.read<ProfileImageCubit>().state;
    await context.read<OnboardingCubit>().connect(username, profileImage);
  }

  String _checkInputs(BuildContext context){
    var error = '';
    if(context.read<ProfileImageCubit>().state == null) {
      error = 'Upload Profile Image';
    }
    return error;
  }
}
