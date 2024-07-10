import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/auth/login_screen.dart';
import 'package:todo_app/auth/sign_up.dart';
import 'package:todo_app/buttom_nav_bar/buttom_nav.dart';
import 'package:todo_app/firebase_options.dart';
import 'package:todo_app/tabbar_screen/all_task.dart';
import 'package:todo_app/tabbar_screen/today_task.dart';
import 'package:todo_app/view/account_edit.dart';
import 'package:todo_app/view/add_task.dart';
import 'package:todo_app/view/home_screen.dart';
import 'package:todo_app/view/profile_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      home: CheckUser(),
      // home: HomeScreen(),
      //home: ButtomNavScreen(),
      //home:SignUp()
      // home: AddTaskScreen(),
      //home: AllTask(),
      //  home: AddTaskScreen(),
      //home: AccountEditScreen(),
      //home: ProfileScreen(),
      //home: TodayTAsk(),
    );
  }

  Widget? CheckUser() {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return ButtomNavScreen();
    } else {
     return LoginScreen();
    }
  }
}
