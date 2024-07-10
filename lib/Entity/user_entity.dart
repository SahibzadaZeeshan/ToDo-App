import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_entity.g.dart';

@JsonSerializable()
class UserEntity {
  String? name;
  String? email;
  String? uId;
  String? profileImage;

  UserEntity({this.name, this.email, this.uId});

  factory UserEntity.fromJson(Map<String, dynamic> json) =>
      _$UserEntityFromJson(json);

// To JSON
  Map<String, dynamic> toJson() => _$UserEntityToJson(this);

  static CollectionReference<UserEntity> collection() {
    return FirebaseFirestore.instance.collection("UserEntity").withConverter(
        fromFirestore: (snapshot, _) => UserEntity.fromJson(snapshot.data()!),
        toFirestore: (user, _) => user.toJson());
  }

  static DocumentReference<UserEntity> doc({required String userId}) {
    return FirebaseFirestore.instance.doc("UserEntity/$userId").withConverter(
        fromFirestore: (snapshot, _) => UserEntity.fromJson(snapshot.data()!),
        toFirestore: (user, _) => user.toJson());
  }
}

// From JSON
