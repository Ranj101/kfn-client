// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductResponse _$ProductResponseFromJson(Map<String, dynamic> json) =>
    ProductResponse(
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      id: json['id'] as String,
      name: json['name'] as String,
      producerId: json['producerId'] as String,
      producerName: json['producerName'] as String,
      picture: json['picture'] as String,
      state: json['state'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      pricesByWeight: (json['pricesByWeight'] as List<dynamic>)
          .map((e) => PriceByWeightResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ProductResponseToJson(ProductResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'producerId': instance.producerId,
      'producerName': instance.producerName,
      'picture': instance.picture,
      'state': instance.state,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'pricesByWeight': instance.pricesByWeight,
    };
