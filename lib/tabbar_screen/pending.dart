import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/Entity/add_task_entity.dart';

class Pending extends StatefulWidget {
  const Pending({super.key});

  @override
  State<Pending> createState() => _PendingState();
}

class _PendingState extends State<Pending> {
  Stream<QuerySnapshot<AddTaskEntity>> fatchdata = AddTaskEntity.collection()
      .where('isComplete', isEqualTo: false)
      .where('UserId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: fatchdata,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(child: Text('No record found'));
        }

        return ListView.builder(
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            AddTaskEntity taskData = snapshot.data!.docs[index].data();
            return Padding(
              padding: const EdgeInsets.all(18.0),
              child: PhysicalModel(
                borderRadius: BorderRadius.circular(15),
                elevation: 5,
                color: Colors.white,
                shadowColor: Colors.grey,
                child: GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return Align(
                          alignment: Alignment.center,
                          child: PhysicalModel(
                            color: Colors.white,
                            elevation: 0,
                            shadowColor: Colors.grey,
                            borderRadius: BorderRadius.circular(15),
                            child: Container(
                              height: 120,
                              width: 250,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.white),
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Are You Complete this task ? ",
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(18.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          MaterialButton(
                                            color: Colors.red,
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text("No"),
                                          ),
                                          MaterialButton(
                                            color: Colors.green,
                                            onPressed: () async {
                                              await AddTaskEntity.doc(
                                                      taskId: taskData.TaskId!)
                                                  .update({'isComplete': true});
                                              Navigator.pop(context);
                                            },
                                            child: Text("Yes"),
                                          )
                                        ],
                                      ),
                                    )
                                  ]),
                            ),
                          ),
                        );
                      },
                    );
                  },
                  child: Container(
                    height: 100,
                    width: double.infinity,
                    child: Row(children: [
                      SizedBox(width: 15),
                      Container(
                        height: 55,
                        width: 55,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(taskData.Image!),
                            fit: BoxFit.fill,
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            taskData.Name.toString(),
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
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
                            Icon(Icons.delete_forever_outlined, size: 40),
                            SizedBox(),
                            Text(
                              taskData.isComplete == true
                                  ? "Completed"
                                  : "Pending",
                              style: TextStyle(fontSize: 13, color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                    ]),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
