import 'package:flutter/material.dart';

class UserImagesSmall extends StatelessWidget {
  const UserImagesSmall({
    Key? key,
    required this.imageUrl,
  }) : super(key: key);

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(
          top: 8,
          right: 8,
        ),
        height: 70,
        width: 70,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(imageUrl),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(5.0),
        ));
  }
}
