import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  @JsonKey(name: 'id')
  String id;

  @JsonKey(name: 'identityId')
  String identityId;

  @JsonKey(name: 'firstName')
  String firstName;

  @JsonKey(name: 'lastName')
  String lastName;

  @JsonKey(name: 'email')
  String email;

  @JsonKey(name: 'profilePicture')
  String? profilePicture;

  @JsonKey(name: 'coverPicture')
  String? coverPicture;

  @JsonKey(name: 'roles')
  List<String> roles;

  @JsonKey(name: 'state')
  String state;

  @JsonKey(name: 'createdBy')
  String createdBy;

  @JsonKey(name: 'updatedBy')
  String? updatedBy;

  @JsonKey(name: 'createdAt')
  DateTime createdAt;

  @JsonKey(name: 'updatedAt')
  DateTime? updatedAt;

  User({
    required this.id,
    required this.identityId,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.roles,
    required this.state,
    required this.createdBy,
    required this.createdAt,
    this.profilePicture,
    this.coverPicture,
    this.updatedBy,
    this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
