// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'submit_order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubmitOrder _$SubmitOrderFromJson(Map<String, dynamic> json) => SubmitOrder(
      producerId: json['producerId'] as String,
      location: json['location'] as String,
      pickupTime: DateTime.parse(json['pickupTime'] as String),
      products: (json['products'] as List<dynamic>)
          .map((e) => SubmitBagProduct.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SubmitOrderToJson(SubmitOrder instance) =>
    <String, dynamic>{
      'producerId': instance.producerId,
      'location': instance.location,
      'pickupTime': instance.pickupTime.toIso8601String(),
      'products': instance.products,
    };
