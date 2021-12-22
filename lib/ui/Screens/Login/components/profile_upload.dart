import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snoop/states_management/onboarding/profile_image_cubit.dart';

import '../../../constants.dart';

class ProfileUpload extends StatelessWidget {
  const ProfileUpload({
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 85.0,
      width: 85.0,
      child: Material(
        color: const Color(0xFFF2F2F2),
        borderRadius: BorderRadius.circular(80.0),
        child: InkWell(
          borderRadius: BorderRadius.circular(80.0),
          onTap: () async {
            // await context.read<ProfileImageCubit>().getImage();
          },
          child: Stack(
            fit: StackFit.expand,
            children: [
              CircleAvatar(
                backgroundColor: Colors.transparent,
                child: BlocBuilder<ProfileImageCubit, File>(
                  builder: (context, state) {
                    return state == null
                        ? const Icon(Icons.person_outline_rounded,
                        size: 80.0,
                        color: Colors.black,)
                        : ClipRRect(
                      borderRadius: BorderRadius.circular(126.0),
                      child: Image.file(state,
                          width: 80, height: 80, fit: BoxFit.fill),
                    );
                  },
                ),
              ),
              const Align(
                alignment: Alignment.bottomRight,
                child: Icon(
                  Icons.add_circle_rounded,
                  color: kPrimaryColor,
                  size: 20.0,
                ),
              )
            ],
          ),
        ),
      ),
    );

  }
}
