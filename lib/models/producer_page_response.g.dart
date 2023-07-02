// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'producer_page_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProducerPageResponse _$ProducerPageResponseFromJson(
        Map<String, dynamic> json) =>
    ProducerPageResponse(
      id: json['id'] as String,
      name: json['name'] as String,
      locations:
          (json['locations'] as List<dynamic>).map((e) => e as String).toList(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      openingTime: const TimeOfDayJsonConverter()
          .fromJson(json['openingTime'] as String),
      closingTime: const TimeOfDayJsonConverter()
          .fromJson(json['closingTime'] as String),
      reviews:
          (json['reviews'] as List<dynamic>).map((e) => e as String).toList(),
      gallery:
          (json['gallery'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$ProducerPageResponseToJson(
        ProducerPageResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'locations': instance.locations,
      'createdAt': instance.createdAt.toIso8601String(),
      'openingTime':
          const TimeOfDayJsonConverter().toJson(instance.openingTime),
      'closingTime':
          const TimeOfDayJsonConverter().toJson(instance.closingTime),
      'reviews': instance.reviews,
      'gallery': instance.gallery,
    };
