import 'package:flutter/material.dart';
import 'package:snoop/states_management/onboarding/onboarding_router.dart';

import '../body.dart';


class LoginScreen extends StatelessWidget {
  final IOnboardingRouter onboardingRouter;
  const LoginScreen({Key key, this.onboardingRouter, }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Body(router: onboardingRouter),
      ),
    );
  }
}
