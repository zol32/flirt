import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flirt/blocs/blocs.dart';

import '/screens/screens.dart';

class SplashScreen extends StatelessWidget {
  static const String routeName = '/splash';

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => SplashScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state.status == AuthStatus.unauthenticated) {
            Timer(
              const Duration(seconds: 1),
              () => Navigator.of(context).pushNamedAndRemoveUntil(
                OnboardingScreen.routeName,
                ModalRoute.withName('/onboarding'),
              ),
            );
          } else if (state.status == AuthStatus.authenticated) {
            log('');
            Timer(
              const Duration(seconds: 1),
              () => Navigator.of(context).pushNamed(HomePage.routeName),
            );
          }
        },
        child: Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/flirt-logo.png',
                  height: 100,
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
