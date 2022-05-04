import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flirt/services/services.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  final String title;
  final bool hasActions;

  // final AuthService? _authService;

  const CustomAppBar({
    Key? key,
    required this.title,
    this.hasActions = true,
    // AuthService? authService,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthService _authService = AuthService();
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          Expanded(
            child: Image.asset(
              'assets/flirt-logo.png',
              height: 50,
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              title,
              style: Theme.of(context).textTheme.headline2,
            ),
          )
        ],
      ),
      actions: hasActions
          ? [
              IconButton(
                icon: const Icon(Icons.message),
                color: Theme.of(context).primaryColor,
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.person),
                color: Theme.of(context).primaryColor,
                onPressed: () {
                  final FirebaseAuth auth = FirebaseAuth.instance;
                  log("USER IS");
                  log(auth.currentUser.toString());
                },
              ),
              IconButton(
                icon: const Icon(Icons.exit_to_app),
                color: Theme.of(context).primaryColor,
                onPressed: () async {
                  log('Start Sign out');
                  await _authService.signOut();
                  log('SIGN OUT COMPLETE');
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    '/onboarding',
                    (_) => false,
                  );
                },
              ),
            ]
          : null,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56.0);
}
