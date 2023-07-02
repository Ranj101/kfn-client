import 'package:json_annotation/json_annotation.dart';

part 'submit_bag_product.g.dart';

@JsonSerializable()
class SubmitBagProduct {
  @JsonKey(name: 'productId')
  String productId;

  @JsonKey(name: 'priceByWeightId')
  String priceByWeightId;

  SubmitBagProduct({
    required this.productId,
    required this.priceByWeightId,
  });

  factory SubmitBagProduct.fromJson(Map<String, dynamic> json) =>
      _$SubmitBagProductFromJson(json);
  Map<String, dynamic> toJson() => _$SubmitBagProductToJson(this);
}
