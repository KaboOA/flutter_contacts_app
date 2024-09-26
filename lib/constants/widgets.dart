// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class Widgets {}

class DefaultTextFormField extends StatelessWidget {
  DefaultTextFormField({
    super.key,
    required this.controller,
    required this.keyboardType,
    required this.preIcon,
    required this.txt,
  });
  TextEditingController controller;
  TextInputType keyboardType;
  IconData preIcon;

  String txt;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please Enter $txt!';
        }
        return null;
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(color: Colors.blue),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        labelText: txt,
        prefixIcon: Icon(preIcon),
        labelStyle: const TextStyle(color: Colors.black),
        floatingLabelStyle: const TextStyle(color: Colors.blue),
        floatingLabelBehavior: FloatingLabelBehavior.auto,
      ),
      cursorColor: Colors.blue,
    );
  }
}
