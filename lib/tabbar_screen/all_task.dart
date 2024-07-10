import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/Entity/add_task_entity.dart';

class AllTask extends StatefulWidget {
  const AllTask({super.key});

  @override
  State<AllTask> createState() => _AllTaskState();
}

class _AllTaskState extends State<AllTask> {
  Stream<QuerySnapshot<AddTaskEntity>> fatchdata = AddTaskEntity.collection()
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
            /// create variable and store all data in varibale
            AddTaskEntity taskData = snapshot.data!.docs[index].data();
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
                    SizedBox(width: 15),
                    Container(
                      height: 55,
                      width: 55,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          /// add image into firebase
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
                          /// add name into firebase
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
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(

                              /// delete image and id form firebase
                              onTap: () async {
                                await FirebaseStorage.instance
                                    .ref("images")
                                    .child(taskData.TaskId!)
                                    .delete();
                                await AddTaskEntity.doc(
                                        taskId: taskData.TaskId!)
                                    .delete();
                              },
                              child: Icon(Icons.delete_forever_outlined,
                                  size: 40)),
                          SizedBox(),
                          Text(
                            /// complete or pending task
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
            );
          },
        );
      },
    );
  }
}
