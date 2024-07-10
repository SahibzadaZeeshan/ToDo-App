import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/auth/forgot_password.dart';
import 'package:todo_app/auth/sign_up.dart';
import 'package:todo_app/buttom_nav_bar/buttom_nav.dart';
import 'package:todo_app/custom_textfeild/custom_butom.dart';
import 'package:todo_app/custom_textfeild/text_feild.dart';
import 'package:todo_app/view/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScrenState();
}

class _LoginScrenState extends State<LoginScreen> {
  final _formkey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Form(
              key: _formkey,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 40,
                    ),
                    Text(
                      "Login",
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Welcome Back!",
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [Text("Email Address")],
                    ),
                    CustomTextFeild(
                        controller: _emailController,
                        validate: (value) {
                          if (value == null || value.isEmpty) {
                            return "Enter your email";
                          }
                        },
                        hinttext: "Enter your email"),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [Text("Password")],
                    ),
                    CustomTextFeild(
                      controller: _passwordController,
                      validate: (value) {
                        if (value == null || value.isEmpty) {
                          return " Enter your password";
                        }
                      },
                      suffixIcon: Icons.remove_red_eye_outlined,
                      obsecureText: true,
                      hinttext: "Enter your password",
                    ),
                    Row(
                      children: [
                        Spacer(),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ForgotPassword(),
                                ));
                          },
                          child: Text(
                            "Forgot password?",
                            style: TextStyle(color: Colors.blue),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    CustomButton(
                      text: "LOGIN",
                      width: double.infinity,
                      height: 58,
                      textColor: Colors.white,
                      fontBold: FontWeight.bold,
                      fontSize: 20,
                      onPress: () async {
                        try {
                          if (!_formkey.currentState!.validate()) {
                            return;
                          }
                          await FirebaseAuth.instance.signInWithEmailAndPassword(
                              email: _emailController.text.trim(),
                              password: _passwordController.text.trim());
                          _emailController.clear();
                          _passwordController.clear();
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Login Successfully")));
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ButtomNavScreen(),
                              ));
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(e.toString())));
                        }
                      },
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.24,
                    ),
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Don’t have an account?"),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SignUp(),
                                  ));
                            },
                            child: Text(
                              "Sign Up",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue),
                            ),
                          ),
                        ]),
                  ]),
            )),
      ),
    );
  }
}
