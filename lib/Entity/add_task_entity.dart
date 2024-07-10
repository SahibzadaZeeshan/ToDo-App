import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'add_task_entity.g.dart';

@JsonSerializable()
class AddTaskEntity {
  String? Image;
  String? Name;
  String? TaskId;
  String? UserId;
  bool isComplete;

  AddTaskEntity(
      {this.Image,
      this.Name,
      this.TaskId,
      this.UserId,
      this.isComplete = false});

  factory AddTaskEntity.fromJson(Map<String, dynamic> json) =>
      _$AddTaskEntityFromJson(json);

// To JSON
  Map<String, dynamic> toJson() => _$AddTaskEntityToJson(this);

  static CollectionReference<AddTaskEntity> collection() {
    return FirebaseFirestore.instance.collection("taskDetail").withConverter(
        fromFirestore: (snapshot, _) =>
            AddTaskEntity.fromJson(snapshot.data()!),
        toFirestore: (user, _) => user.toJson());
  }

  static DocumentReference<AddTaskEntity> doc({required String taskId}) {
    return FirebaseFirestore.instance.doc("taskDetail/$taskId").withConverter(
        fromFirestore: (snapshot, _) =>
            AddTaskEntity.fromJson(snapshot.data()!),
        toFirestore: (user, _) => user.toJson());
  }
}
