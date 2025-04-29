import 'package:base_flutter/src/data/mapper/counter_mapper.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('mapToDomain', () {
    test('should return int', () {
      final json = {"current_value": 2};
      var actual = CounterMapper.mapToDomain(json);
      expect(actual, equals(2));
    });
  });
}
