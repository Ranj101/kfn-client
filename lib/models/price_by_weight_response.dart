import 'package:json_annotation/json_annotation.dart';

part 'price_by_weight_response.g.dart';

@JsonSerializable()
class PriceByWeightResponse {
  @JsonKey(name: 'id')
  String id;

  @JsonKey(name: 'value')
  double value;

  @JsonKey(name: 'weight')
  double weight;

  PriceByWeightResponse({
    required this.id,
    required this.value,
    required this.weight,
  });

  factory PriceByWeightResponse.fromJson(Map<String, dynamic> json) =>
      _$PriceByWeightResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PriceByWeightResponseToJson(this);
}
