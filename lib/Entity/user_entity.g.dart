// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserEntity _$UserEntityFromJson(Map<String, dynamic> json) => UserEntity(
      name: json['name'] as String?,
      email: json['email'] as String?,
      uId: json['uId'] as String?,
    )..profileImage = json['profileImage'] as String?;

Map<String, dynamic> _$UserEntityToJson(UserEntity instance) =>
    <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
      'uId': instance.uId,
      'profileImage': instance.profileImage,
    };
