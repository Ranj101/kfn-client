// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderListResponse _$OrderListResponseFromJson(Map<String, dynamic> json) =>
    OrderListResponse(
      id: json['id'] as String,
      totalPrice: (json['totalPrice'] as num).toDouble(),
      producerName: json['producerName'] as String?,
      location: json['location'] as String,
      state: json['state'] as String,
    );

Map<String, dynamic> _$OrderListResponseToJson(OrderListResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'totalPrice': instance.totalPrice,
      'producerName': instance.producerName,
      'location': instance.location,
      'state': instance.state,
    };
