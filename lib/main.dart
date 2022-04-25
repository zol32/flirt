import 'package:flirt/blocs/swipe/swipe_bloc.dart';
import 'package:flirt/screens/home_screen.dart';
import 'package:flirt/screens/user_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'models/models.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (_) => SwipeBloc()..add(LoadUsersEvent(users: User.users)))
      ],
      child: MaterialApp(
        title: 'Flirt',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const UserPage(),
      ),
    );
  }
}
