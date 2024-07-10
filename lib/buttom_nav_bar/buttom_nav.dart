import 'package:flutter/material.dart';
import 'package:simple_floating_bottom_nav_bar/floating_bottom_nav_bar.dart';
import 'package:simple_floating_bottom_nav_bar/floating_item.dart';
import 'package:todo_app/view/account_edit.dart';
import 'package:todo_app/view/add_task.dart';
import 'package:todo_app/view/home_screen.dart';

class ButtomNavScreen extends StatefulWidget {
  const ButtomNavScreen({super.key});

  @override
  State<ButtomNavScreen> createState() => _ButtomNavScreenState();
}

class _ButtomNavScreenState extends State<ButtomNavScreen> {
  List<FloatingBottomNavItem> bottomNavItems = const [
    FloatingBottomNavItem(
      inactiveIcon: Icon(Icons.home_outlined),
      activeIcon: Icon(Icons.home),
      label: "Home",
    ),
    FloatingBottomNavItem(
      inactiveIcon: Icon(Icons.add_circle_outline),
      activeIcon: Icon(Icons.add_circle),
      label: "Add",
    ),
    FloatingBottomNavItem(
      inactiveIcon: Icon(Icons.person_outline),
      activeIcon: Icon(Icons.person),
      label: "Account Setting",
    ),
  ];

  List<Widget> pages = [
    HomeScreen(),
    AddTaskScreen(),
    AccountEditScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return FloatingBottomNavBar(
      pages: pages,
      items: bottomNavItems,
      initialPageIndex: 0,
      backgroundColor: Colors.blue,
      bottomPadding: 10,
      elevation: 0,
      radius: 20,
      width: 320,
      height: 65,
    );
  }
}
