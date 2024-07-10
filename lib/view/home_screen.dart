import 'package:flutter/material.dart';
import 'package:todo_app/tabbar_screen/all_task.dart';
import 'package:todo_app/tabbar_screen/complete_task.dart';
import 'package:todo_app/tabbar_screen/pending.dart';
import 'package:todo_app/tabbar_screen/today_task.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 4,
        child: SafeArea(
          child: Scaffold(
            body: Column(
              children: [
                Container(
                  height: 70,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(20),
                        bottomLeft: Radius.circular(20)),
                  ),
                  child: Center(
                    child: Text(
                      "Home",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 25),
                    ),
                  ),
                ),
                TabBar(
                    padding: EdgeInsetsDirectional.all(22),
                    indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.blue),
                    unselectedLabelStyle: TextStyle(color: Colors.blue),
                    isScrollable: true,
                    labelColor: Colors.black,
                    unselectedLabelColor: Colors.black,
                    tabs: [
                      Text(
                        "All Task",
                      ),
                      Text("Today Task"),
                      Text("Pending"),
                      Text("Complete Task"),
                    ]),
                Expanded(
                  child: TabBarView(children: [
                    AllTask(),
                    TodayTAsk(),
                    Pending(),
                    CompleteTask(),
                  ]),
                )
              ],
            ),
          ),
        ));
  }
}
