// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'price_by_weight_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PriceByWeightResponse _$PriceByWeightResponseFromJson(
        Map<String, dynamic> json) =>
    PriceByWeightResponse(
      id: json['id'] as String,
      value: json['value'] as double,
      weight: json['weight'] as double,
    );

Map<String, dynamic> _$PriceByWeightResponseToJson(
        PriceByWeightResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'value': instance.value,
      'weight': instance.weight,
    };
