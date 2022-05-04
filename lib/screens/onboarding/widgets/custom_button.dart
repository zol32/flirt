import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flirt/blocs/blocs.dart';
import 'package:flirt/cubits/signup/signup_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flirt/models/models.dart';

class CustomButton extends StatelessWidget {
  final TabController tabController;
  final String text;
  final void function;

  CustomButton({
    Key? key,
    required this.tabController,
    required this.text,
    this.function,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.secondary,
            Theme.of(context).primaryColor,
          ],
        ),
      ),
      child: ElevatedButton(
        onPressed: () async {
          if (tabController.index == 5) {
            Navigator.pushNamed(context, '/');
          } else {
            tabController.animateTo(tabController.index + 1);
          }

          if (tabController.index == 7) {
            log('SIGN UP USER 2');
            await context.read<SignupCubit>().signUpWithCredentials();
            log('SIGN UP USER IN');

            User user = User(
              id: context.read<SignupCubit>().state.user!.uid,
              name: '',
              age: 0,
              gender: '',
              imageUrls: [],
              jobTitle: '',
              interests: [],
              bio: '',
              location: '',
            );
            log('SIGN UP ADD USER');
            context.read<OnboardingBloc>().add(
                  StartOnboarding(
                    user: user,
                  ),
                );
            log('SIGN UP ADD USER COMPLETE');
          }
        },
        style: ElevatedButton.styleFrom(
          primary: Colors.transparent,
          elevation: 0,
        ),
        child: Container(
          width: double.infinity,
          child: Center(
            child: Text(
              text,
              style: Theme.of(context)
                  .textTheme
                  .headline4!
                  .copyWith(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
