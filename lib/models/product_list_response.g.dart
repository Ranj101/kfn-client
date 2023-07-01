// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductListResponse _$ProductListResponseFromJson(Map<String, dynamic> json) =>
    ProductListResponse(
      id: json['id'] as String,
      name: json['name'] as String,
      producerName: json['producerName'] as String,
      picture: json['picture'] as String,
      state: json['state'] as String,
      pricesByWeight: (json['pricesByWeight'] as List<dynamic>)
          .map((e) => PriceByWeightResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ProductListResponseToJson(
        ProductListResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'producerName': instance.producerName,
      'picture': instance.picture,
      'state': instance.state,
      'pricesByWeight': instance.pricesByWeight,
    };
