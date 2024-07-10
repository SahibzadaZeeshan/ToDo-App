import 'package:flutter/material.dart';
import 'package:todo_app/custom_textfeild/custom_butom.dart';
import 'package:todo_app/custom_textfeild/text_feild.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Text(
            "Forgot Password",
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 25, color: Colors.blue),
          ),
          SizedBox(
            height: 25,
          ),
          CustomTextFeild(
            hinttext: "Enter your password",
          ),
          SizedBox(
            height: 40,
          ),
          CustomButton(
            text: "Send",
            fontBold: FontWeight.bold,
          )
        ]),
      ),
    );
  }
}
