import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:todo_app/Entity/user_entity.dart';
import 'package:todo_app/custom_textfeild/custom_butom.dart';
import 'package:todo_app/custom_textfeild/text_feild.dart';

class ProfileScreen extends StatefulWidget {
  final UserEntity? updateProfileScreen;

  const ProfileScreen({super.key, this.updateProfileScreen});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late final _nameController =
  TextEditingController(text: widget.updateProfileScreen!.name);
  String? getUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 70,
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15)),
                  color: Colors.blue),
              child: Center(
                child: Text(
                  "Edit Profle",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Stack(
              children: [
                imagePicker != null
                    ? CircleAvatar(
                  backgroundColor: Colors.grey,
                  radius: 55,
                  backgroundImage: FileImage(imagePicker!.absolute),
                )
                    : CircleAvatar(
                  backgroundColor: Colors.grey,
                  radius: 55,
                  child: Icon(Icons.camera_alt_outlined,
                      color: Colors.white, size: 55),
                ),
                Positioned(
                  bottom: 0,
                  right: 1,
                  child: InkWell(
                    onTap: getImage,
                    child: Container(
                      height: 35,
                      width: 35,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.blue),
                      child: Icon(
                        Icons.add,
                        color: Colors.black,
                      ),
                    ),
                  ),
                )
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
                  Text("Full name"),
                  CustomTextFeild(
                    controller: _nameController,
                    hinttext: "Enter Full Name",
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  CustomButton(
                    onPress: () async {
                      if (imagePicker != null) {
                        await FirebaseStorage.instance
                            .ref("profleImage")
                            .child(widget.updateProfileScreen!.uId!)
                            .putFile(imagePicker!);
                        getUrl =
                        await FirebaseStorage.instance.ref("profileImage")
                            .child(widget.updateProfileScreen!.uId!)
                            .getDownloadURL();
                      }
                      await UserEntity.doc(
                          userId: widget.updateProfileScreen!.uId!).update({
                        'profileImage': getUrl ??
                            widget.updateProfileScreen!.profileImage
                      });
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(" sucessfully updated")));
                    },
                    fontBold: FontWeight.bold,
                    fontSize: 15,
                    text: "UPDATE",
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

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
