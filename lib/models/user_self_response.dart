import 'package:json_annotation/json_annotation.dart';

part 'user_self_response.g.dart';

@JsonSerializable()
class UserSelfResponse {
  @JsonKey(name: 'id')
  String id;

  @JsonKey(name: 'firstName')
  String firstName;

  @JsonKey(name: 'lastName')
  String lastName;

  @JsonKey(name: 'email')
  String email;

  @JsonKey(name: 'coverPicture')
  String? coverPicture;

  @JsonKey(name: 'profilePicture')
  String? profilePicture;

  @JsonKey(name: 'roles')
  List<String> roles;

  @JsonKey(name: 'createdBy')
  String createdBy;

  @JsonKey(name: 'updatedBy')
  String? updatedBy;

  @JsonKey(name: 'createdAt')
  DateTime createdAt;

  @JsonKey(name: 'updatedAt')
  DateTime? updatedAt;

  @JsonKey(name: 'producerId')
  String? producerId;

  UserSelfResponse({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.roles,
    required this.createdBy,
    required this.createdAt,
    this.producerId,
    this.profilePicture,
    this.coverPicture,
    this.updatedBy,
    this.updatedAt,
  });

  factory UserSelfResponse.fromJson(Map<String, dynamic> json) =>
      _$UserSelfResponseFromJson(json);
  Map<String, dynamic> toJson() => _$UserSelfResponseToJson(this);
}
