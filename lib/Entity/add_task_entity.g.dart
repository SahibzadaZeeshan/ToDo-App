// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_task_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddTaskEntity _$AddTaskEntityFromJson(Map<String, dynamic> json) =>
    AddTaskEntity(
      Image: json['Image'] as String?,
      Name: json['Name'] as String?,
      TaskId: json['TaskId'] as String?,
      UserId: json['UserId'] as String?,
      isComplete: json['isComplete'] as bool? ?? false,
    );

Map<String, dynamic> _$AddTaskEntityToJson(AddTaskEntity instance) =>
    <String, dynamic>{
      'Image': instance.Image,
      'Name': instance.Name,
      'TaskId': instance.TaskId,
      'UserId': instance.UserId,
      'isComplete': instance.isComplete,
    };
