import 'package:flutter/material.dart';
class TodayTAsk extends StatefulWidget {
  const TodayTAsk({super.key});

  @override
  State<TodayTAsk> createState() => _TodayTAskState();
}

class _TodayTAskState extends State<TodayTAsk> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(18.0),
          child: PhysicalModel(
              borderRadius: BorderRadius.circular(15),
              elevation: 5,
              color: Colors.white,
              shadowColor: Colors.grey,
              child: Container(
                height: 100,
                width: double.infinity,
                child: Row(children: [
                  SizedBox(
                    width: 15,
                  ),
                  Container(
                    height: 55,
                    width: 55,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.grey),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Task Name",
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                              fontWeight: FontWeight.bold)),
                      Text(
                        "12/5/2024 23:04",
                        style: TextStyle(color: Colors.grey, fontSize: 13),
                      ),
                    ],
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.delete_forever_outlined,size: 40),
                        SizedBox(),
                        Text(
                          "Pending",
                          style: TextStyle(fontSize: 13,color: Colors.black),
                        )
                      ],
                    ),
                  )
                ]),
              )),
        );
      },
    );
  }
}
