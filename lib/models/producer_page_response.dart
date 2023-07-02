import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:kurdistan_food_network/utils/time_of_day_json_converter.dart';

part 'producer_page_response.g.dart';

@JsonSerializable()
class ProducerPageResponse {
  @JsonKey(name: 'id')
  String id;

  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'locations')
  List<String> locations;

  @JsonKey(name: 'createdAt')
  DateTime createdAt;

  @JsonKey(name: 'openingTime')
  @TimeOfDayJsonConverter()
  TimeOfDay openingTime;

  @JsonKey(name: 'closingTime')
  @TimeOfDayJsonConverter()
  TimeOfDay closingTime;

  @JsonKey(name: 'reviews')
  List<String> reviews;

  @JsonKey(name: 'gallery')
  List<String> gallery;

  ProducerPageResponse({
    required this.id,
    required this.name,
    required this.locations,
    required this.createdAt,
    required this.openingTime,
    required this.closingTime,
    required this.reviews,
    required this.gallery,
  });

  factory ProducerPageResponse.fromJson(Map<String, dynamic> json) =>
      _$ProducerPageResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ProducerPageResponseToJson(this);
}
