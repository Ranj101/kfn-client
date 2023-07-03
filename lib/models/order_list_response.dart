import 'package:json_annotation/json_annotation.dart';

part 'order_list_response.g.dart';

@JsonSerializable()
class OrderListResponse {
  @JsonKey(name: 'id')
  String id;

  @JsonKey(name: 'totalPrice')
  double totalPrice;

  @JsonKey(name: 'producerName')
  String? producerName;

  @JsonKey(name: 'location')
  String location;

  @JsonKey(name: 'state')
  String state;

  OrderListResponse({
    required this.id,
    required this.totalPrice,
    this.producerName,
    required this.location,
    required this.state,
  });

  factory OrderListResponse.fromJson(Map<String, dynamic> json) =>
      _$OrderListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$OrderListResponseToJson(this);

  static List<OrderListResponse> fromJsonList(
      List<Map<String, dynamic>> jsonList) {
    List<OrderListResponse> list = [];

    for (var element in jsonList) {
      list.add(OrderListResponse.fromJson(element));
    }

    return list;
  }
}
