import 'package:json_annotation/json_annotation.dart';
import 'package:kurdistan_food_network/models/product_list_response.dart';

part 'order_response.g.dart';

@JsonSerializable()
class OrderResponse {
  @JsonKey(name: 'id')
  String id;

  @JsonKey(name: 'userId')
  String userId;

  @JsonKey(name: 'producerId')
  String producerId;

  @JsonKey(name: 'totalPrice')
  double totalPrice;

  @JsonKey(name: 'location')
  String location;

  @JsonKey(name: 'pickupTime')
  String pickupTime;

  @JsonKey(name: 'state')
  String state;

  @JsonKey(name: 'createdAt')
  DateTime createdAt;

  @JsonKey(name: 'products')
  List<ProductListResponse> products;

  OrderResponse({
    required this.id,
    required this.userId,
    required this.producerId,
    required this.totalPrice,
    required this.location,
    required this.pickupTime,
    required this.state,
    required this.createdAt,
    required this.products,
  });

  factory OrderResponse.fromJson(Map<String, dynamic> json) =>
      _$OrderResponseFromJson(json);

  Map<String, dynamic> toJson() => _$OrderResponseToJson(this);
}
