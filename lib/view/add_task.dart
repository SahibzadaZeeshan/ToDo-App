import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:todo_app/Entity/add_task_entity.dart';
import 'package:todo_app/custom_textfeild/custom_butom.dart';
import 'package:todo_app/custom_textfeild/text_feild.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  bool isBusy = false;
  String? getURL;
  final _formkey = GlobalKey<FormState>();
  TextEditingController _taskController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Form(
          key: _formkey,
          child: Column(
            children: [
              Container(
                height: 60,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(15),
                        bottomLeft: Radius.circular(15)),
                    color: Colors.blue),
                child: Center(
                    child: Text(
                  "Add Task",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                )),
              ),
              SizedBox(
                height: 30,
              ),
              Stack(
                children: [
                  /// Image picker
                  imagePicker != null
                      ? CircleAvatar(
                          radius: 55,
                          backgroundImage: FileImage(imagePicker!.absolute),
                        )
                      : CircleAvatar(
                          radius: 70,
                          child: Icon(
                            Icons.camera_alt_outlined,
                            size: 70,
                            color: Colors.white,
                          ),
                          backgroundColor: Colors.grey,
                        ),
                  Positioned(
                    bottom: 0,
                    right: 3,
                    child: InkWell(
                      onTap: getImage,
                      child: Container(
                        height: 35,
                        width: 35,
                        child: Icon(
                          Icons.add,
                          color: Colors.black,
                        ),
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(30)),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Task Name"),
                    CustomTextFeild(
                      controller: _taskController,
                      validate: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter Task Name";
                        }
                        return null;
                      },
                      hinttext: "Enter Task Name",
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    isBusy
                        ? Center(child: CircularProgressIndicator())
                        : CustomButton(
                            onPress: () async {
                              try {
                                if (imagePicker == null) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text("Upload your image")));
                                  return;
                                }
                                if (!_formkey.currentState!.validate()) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text("Enter Task Name")));
                                  return;
                                }
                                setState(() {
                                  isBusy = true;
                                });
                                String taskId =
                                    AddTaskEntity.collection().doc().id;

                                String currentUserId =
                                    FirebaseAuth.instance.currentUser!.uid;
                                if (imagePicker != null) {
                                  await FirebaseStorage.instance
                                      .ref("images")
                                      .child(taskId)
                                      .putFile(imagePicker!);
                                  getURL = await FirebaseStorage.instance
                                      .ref("images")
                                      .child(taskId)
                                      .getDownloadURL();
                                }

                                AddTaskEntity addTaskEntity = AddTaskEntity(
                                    Image: getURL,
                                    TaskId: taskId,
                                    Name: _taskController.text.trim(),
                                    UserId: currentUserId);
                                await AddTaskEntity.doc(taskId: taskId)
                                    .set(addTaskEntity);

                                _taskController.clear();
                                setState(() {
                                  imagePicker = null;
                                });
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content:
                                            Text("Data successfully added")));
                                setState(() {
                                  isBusy = false;
                                });
                              } catch (e) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(e.toString())));

                                setState(() {
                                  isBusy = false;
                                });
                              }
                            },
                            text: "Add",
                            fontBold: FontWeight.bold,
                            fontSize: 20,
                          ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
    /// variable for image picker
  File? imagePicker;
/// function for imagepicker
  getImage() async {
    final imagePicked =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (imagePicked != null) {
      setState(() {
        imagePicker = File(imagePicked.path);
      });
    }
  }
}
