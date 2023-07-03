// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_self_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserSelfResponse _$UserSelfResponseFromJson(Map<String, dynamic> json) =>
    UserSelfResponse(
      id: json['id'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      email: json['email'] as String,
      roles: (json['roles'] as List<dynamic>).map((e) => e as String).toList(),
      createdBy: json['createdBy'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      producerId: json['producerId'] as String?,
      profilePicture: json['profilePicture'] as String?,
      coverPicture: json['coverPicture'] as String?,
      updatedBy: json['updatedBy'] as String?,
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$UserSelfResponseToJson(UserSelfResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'email': instance.email,
      'coverPicture': instance.coverPicture,
      'profilePicture': instance.profilePicture,
      'roles': instance.roles,
      'createdBy': instance.createdBy,
      'updatedBy': instance.updatedBy,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'producerId': instance.producerId,
    };
