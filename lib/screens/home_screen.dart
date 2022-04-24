import 'package:flirt/models/models.dart';
import 'package:flutter/material.dart';
import '../widgets/widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Column(
        children: [
          UserCard(user: User.users[0]),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 8.0,
              horizontal: 60,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ChoiceButton(
                  width: 60,
                  height: 60,
                  hasGradient: false,
                  size: 25,
                  color: Theme.of(context).colorScheme.secondary,
                  icon: Icons.clear_rounded,
                ),
                ChoiceButton(
                  width: 60,
                  height: 60,
                  size: 30,
                  hasGradient: true,
                  color: Colors.white,
                  icon: Icons.favorite,
                ),
                ChoiceButton(
                  width: 60,
                  height: 60,
                  hasGradient: false,
                  size: 25,
                  color: Theme.of(context).primaryColor,
                  icon: Icons.watch_later,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
