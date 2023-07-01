import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

class TimeOfDayJsonConverter extends JsonConverter<TimeOfDay, String> {
  const TimeOfDayJsonConverter();

  @override
  TimeOfDay fromJson(String json) {
    // "openingTime": "06:00:00",
    var split = json.split(':');

    if (split.length == 3) {
      return TimeOfDay(hour: int.parse(split[0]), minute: int.parse(split[1]));
    }

    return const TimeOfDay(hour: 0, minute: 0);
  }

  @override
  String toJson(TimeOfDay object) {
    return '${object.hour}:${object.minute}:0';
  }
}
