import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/Entity/user_entity.dart';
import 'package:todo_app/custom_textfeild/custom_butom.dart';
import 'package:todo_app/custom_textfeild/text_feild.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formkey = GlobalKey<FormState>();
  TextEditingController _fullNameContoller = TextEditingController();
  TextEditingController _emailContoller = TextEditingController();
  TextEditingController _pwdContoller = TextEditingController();
  TextEditingController _confirmPwdContoller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Form(
            key: _formkey,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              SizedBox(
                height: 30,
              ),
              Text(
                "Sign Up",
                style: TextStyle(
                    color: Colors.blue,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Welcome Back!",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: Colors.grey),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [Text("Full Name")],
              ),
              CustomTextFeild(
                controller: _fullNameContoller,
                validate: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter your name';
                  }
                },
                hinttext: "Enter your full name",
              ),
              SizedBox(
                height: 12,
              ),
              Row(
                children: [Text("Email Address")],
              ),
              CustomTextFeild(
                controller: _emailContoller,
                hinttext: "Enter your Email",
                validate: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter your email";
                  }
                },
              ),
              SizedBox(
                height: 12,
              ),
              Row(
                children: [Text("Password")],
              ),
              CustomTextFeild(
                controller: _pwdContoller,
                validate: (value) {
                  if (value == null || value.isEmpty) {
                    return " Enter your password";
                  }
                },
                hinttext: "Enter Password",
                suffixIcon: Icons.remove_red_eye,
                obsecureText: true,
              ),
              SizedBox(
                height: 12,
              ),
              Row(
                children: [Text(" Confirm Password")],
              ),
              CustomTextFeild(
                controller: _confirmPwdContoller,
                validate: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter Confirm password";
                  }
                },
                hinttext: "Enter Confirm Password",
                suffixIcon: Icons.remove_red_eye,
                obsecureText: true,
              ),
              SizedBox(
                height: 25,
              ),
              CustomButton(
                onPress: () async {
                  try {
                    if (!_formkey.currentState!.validate()) {
                      return;
                    }
                    if (_pwdContoller.text != _confirmPwdContoller.text) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Password Not Matched")));
                      return;
                    }
                    await FirebaseAuth.instance.createUserWithEmailAndPassword(
                        email: _emailContoller.text.trim(),
                        password: _pwdContoller.text.trim());
                    String id = FirebaseAuth.instance.currentUser!.uid;
                    UserEntity userData = UserEntity(
                        name: _fullNameContoller.text.trim(),
                        email: _emailContoller.text.trim(),
                        uId: id);
                    await UserEntity.doc(userId: id).set(userData);
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Data added sucessfully")));
                  } catch (e) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text(e.toString())));
                  }
                  _fullNameContoller.clear();
                  _emailContoller.clear();
                  _pwdContoller.clear();
                  _confirmPwdContoller.clear();
                },
                height: 58,
                width: double.infinity,
                fontBold: FontWeight.bold,
                fontSize: 20,
                textColor: Colors.white,
                text: "SIGN UP",
              ),
              // SizedBox(
              //   height: 200,
              //   child: Row(
              //     crossAxisAlignment: CrossAxisAlignment.center,
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: [
              //       Center(child: Text("Don’t have an account? ")),
              //       Text(
              //         "Login",
              //         style: TextStyle(
              //             color: Colors.blue, fontWeight: FontWeight.bold),
              //       )
              //     ],
              //   ),
              // ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.24,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already  have an account?"),
                  Text(
                    "LogIn",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.blue),
                  ),
                ],
              )
            ]),
          ),
        ),
      ),
    );
  }
}
