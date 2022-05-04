import 'package:flutter/material.dart';

class CustomPasswordField extends StatelessWidget {
  final String hint;
  final Function(String)? onChanged;

  const CustomPasswordField({
    Key? key,
    required this.hint,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: TextField(
        obscureText: true,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hintText: hint,
          contentPadding: const EdgeInsets.only(bottom: 5.0, top: 12.5),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
        ),
        onChanged: onChanged,
      ),
    );
  }
}
