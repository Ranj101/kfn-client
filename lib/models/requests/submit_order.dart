import 'package:json_annotation/json_annotation.dart';
import 'package:kurdistan_food_network/models/requests/submit_bag_product.dart';

part 'submit_order.g.dart';

@JsonSerializable()
class SubmitOrder {
  @JsonKey(name: 'producerId')
  String producerId;

  @JsonKey(name: 'location')
  String location;

  @JsonKey(name: 'pickupTime')
  DateTime pickupTime;

  @JsonKey(name: 'products')
  List<SubmitBagProduct> products;

  SubmitOrder({
    required this.producerId,
    required this.location,
    required this.pickupTime,
    required this.products,
  });

  factory SubmitOrder.fromJson(Map<String, dynamic> json) =>
      _$SubmitOrderFromJson(json);
  Map<String, dynamic> toJson() => _$SubmitOrderToJson(this);
}
