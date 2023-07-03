// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderResponse _$OrderResponseFromJson(Map<String, dynamic> json) =>
    OrderResponse(
      id: json['id'] as String,
      userId: json['userId'] as String,
      producerId: json['producerId'] as String,
      totalPrice: (json['totalPrice'] as num).toDouble(),
      location: json['location'] as String,
      pickupTime: json['pickupTime'] as String,
      state: json['state'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      products: (json['products'] as List<dynamic>)
          .map((e) => ProductListResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$OrderResponseToJson(OrderResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'producerId': instance.producerId,
      'totalPrice': instance.totalPrice,
      'location': instance.location,
      'pickupTime': instance.pickupTime,
      'state': instance.state,
      'createdAt': instance.createdAt.toIso8601String(),
      'products': instance.products,
    };
