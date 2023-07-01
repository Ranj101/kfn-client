import 'package:json_annotation/json_annotation.dart';

part 'paginated_response.g.dart';

@JsonSerializable()
class PaginatedResponse {
  @JsonKey(name: 'page')
  int page;

  @JsonKey(name: 'count')
  int count;

  @JsonKey(name: 'pageSize')
  int pageSize;

  @JsonKey(name: 'totalPages')
  int totalPages;

  @JsonKey(name: 'data')
  List<Map<String, dynamic>> data;

  PaginatedResponse({
    required this.page,
    required this.count,
    required this.pageSize,
    required this.totalPages,
    required this.data,
  });

  factory PaginatedResponse.fromJson(Map<String, dynamic> json) =>
      _$PaginatedResponseFromJson(json);
  Map<String, dynamic> toJson() => _$PaginatedResponseToJson(this);
}
