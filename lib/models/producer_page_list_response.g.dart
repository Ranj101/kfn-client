// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'producer_page_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProducerPageListResponse _$ProducerPageListResponseFromJson(
        Map<String, dynamic> json) =>
    ProducerPageListResponse(
      id: json['id'] as String,
      name: json['name'] as String,
      locations:
          (json['locations'] as List<dynamic>).map((e) => e as String).toList(),
      openingTime: const TimeOfDayJsonConverter()
          .fromJson(json['openingTime'] as String),
      closingTime: const TimeOfDayJsonConverter()
          .fromJson(json['closingTime'] as String),
    );

Map<String, dynamic> _$ProducerPageListResponseToJson(
        ProducerPageListResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'locations': instance.locations,
      'openingTime':
          const TimeOfDayJsonConverter().toJson(instance.openingTime),
      'closingTime':
          const TimeOfDayJsonConverter().toJson(instance.closingTime),
    };
