import 'package:json_annotation/json_annotation.dart';
import 'package:kurdistan_food_network/models/price_by_weight_response.dart';

part 'product_list_response.g.dart';

@JsonSerializable()
class ProductListResponse {
  @JsonKey(name: 'id')
  String id;

  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'producerName')
  String producerName;

  @JsonKey(name: 'picture')
  String picture;

  @JsonKey(name: 'state')
  String state;

  @JsonKey(name: 'pricesByWeight')
  List<PriceByWeightResponse> pricesByWeight;

  ProductListResponse({
    required this.id,
    required this.name,
    required this.producerName,
    required this.picture,
    required this.state,
    required this.pricesByWeight,
  });

  factory ProductListResponse.fromJson(Map<String, dynamic> json) =>
      _$ProductListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ProductListResponseToJson(this);

  static List<ProductListResponse> fromJsonList(
      List<Map<String, dynamic>> jsonList) {
    List<ProductListResponse> list = [];

    for (var element in jsonList) {
      list.add(ProductListResponse.fromJson(element));
    }

    return list;
  }
}
