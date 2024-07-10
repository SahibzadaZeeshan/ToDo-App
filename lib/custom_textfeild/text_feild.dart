import 'package:flutter/material.dart';

class CustomTextFeild extends StatelessWidget {
  final String? hinttext;
  final String? label;
  final IconData? suffixIcon;
  final IconData? prefixIcon;
  final bool obsecureText;
  final TextInputType? keyboardtype;
  final String? Function(String?)? validate;
  final TextEditingController? controller;

  const CustomTextFeild(
      {super.key,
      this.hinttext,
      this.label,
      this.suffixIcon,
      this.prefixIcon,
      this.validate,
      this.obsecureText = false,
      this.keyboardtype, this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validate,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
        hintText: hinttext,
        labelText: label,
        suffixIcon: Icon(suffixIcon),
      ),
      obscureText: obsecureText,
      keyboardType: keyboardtype,
    );
  }
}
