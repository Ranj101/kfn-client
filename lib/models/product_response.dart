import 'package:json_annotation/json_annotation.dart';
import 'package:kurdistan_food_network/models/price_by_weight_response.dart';

part 'product_response.g.dart';

@JsonSerializable()
class ProductResponse {
  @JsonKey(name: 'id')
  String id;

  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'producerId')
  String producerId;

  @JsonKey(name: 'producerName')
  String producerName;

  @JsonKey(name: 'picture')
  String picture;

  @JsonKey(name: 'state')
  String state;

  @JsonKey(name: 'createdAt')
  DateTime createdAt;

  @JsonKey(name: 'updatedAt')
  DateTime? updatedAt;

  @JsonKey(name: 'pricesByWeight')
  List<PriceByWeightResponse> pricesByWeight;

  ProductResponse({
    this.updatedAt,
    required this.id,
    required this.name,
    required this.producerId,
    required this.producerName,
    required this.picture,
    required this.state,
    required this.createdAt,
    required this.pricesByWeight,
  });

  factory ProductResponse.fromJson(Map<String, dynamic> json) =>
      _$ProductResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ProductResponseToJson(this);
}
