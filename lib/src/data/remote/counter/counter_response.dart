import 'package:json_annotation/json_annotation.dart';

class CounterResponse {
  @JsonKey(name: "current_value")
  final int? currentValue;

  const CounterResponse({this.currentValue});

  factory CounterResponse.fromJson(Map<String, dynamic> json) {
    return CounterResponse(
      currentValue: json["current_value"],
    );
  }
}
