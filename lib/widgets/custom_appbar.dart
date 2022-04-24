import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  const CustomAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
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
              'DISCOVER',
              style: Theme.of(context).textTheme.headline2,
            ),
          )
        ],
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.message),
          color: Theme.of(context).primaryColor,
          onPressed: () {},
        ),
        IconButton(
          icon: Icon(Icons.person),
          color: Theme.of(context).primaryColor,
          onPressed: () {},
        )
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(56.0);
}
