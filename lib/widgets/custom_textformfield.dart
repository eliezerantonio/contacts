import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  CustomTextFormField({
    Key? key,
    required this.hintText,
    this.controller,
    this.isPassword = false,
    this.type = TextInputType.text,
    this.initialValue
  }) : super(key: key);
  final String hintText;
  final TextEditingController? controller;
  final TextInputType type;
  bool isPassword;
  String? initialValue;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey[100], borderRadius: BorderRadius.circular(13)),
      child: TextFormField(
        initialValue: initialValue,
        keyboardType: type,
        controller: controller,
        obscureText: isPassword,
        decoration: InputDecoration(
          focusColor: Colors.transparent,
          hintText: hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(color: Colors.white, width: 2.0),
          ),
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          contentPadding:
              const EdgeInsets.only(top: 15, left: 10, right: 10, bottom: 15),
          errorMaxLines: 1,
        ),
      ),
    );
  }
}
