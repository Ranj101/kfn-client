import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:kurdistan_food_network/utils/time_of_day_json_converter.dart';

part 'producer_page_list_response.g.dart';

@JsonSerializable()
class ProducerPageListResponse {
  @JsonKey(name: 'id')
  String id;

  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'locations')
  List<String> locations;

  @JsonKey(name: 'openingTime')
  @TimeOfDayJsonConverter()
  TimeOfDay openingTime;

  @JsonKey(name: 'closingTime')
  @TimeOfDayJsonConverter()
  TimeOfDay closingTime;

  ProducerPageListResponse({
    required this.id,
    required this.name,
    required this.locations,
    required this.openingTime,
    required this.closingTime,
  });

  factory ProducerPageListResponse.fromJson(Map<String, dynamic> json) =>
      _$ProducerPageListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ProducerPageListResponseToJson(this);

  static List<ProducerPageListResponse> fromJsonList(
      List<Map<String, dynamic>> jsonList) {
    List<ProducerPageListResponse> list = [];

    for (var element in jsonList) {
      list.add(ProducerPageListResponse.fromJson(element));
    }

    return list;
  }
}
