import 'package:base_flutter/src/core/utils/date_time_util.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() {
  setUp(() {
    initializeDateFormatting();
  });

  group('convertToString', () {
    test('should return string date', () {
      final date = DateTime(2025, 2, 13);
      var expected = '13/02/2025';
      final result = DateTimeUtil.convertToString(
        date,
        DateTimeUtil.DD_MM_YYYY,
      );
      expect(result, equals(expected));
    });

    test('should return empty date', () {
      final date = DateTime(2025, 22, 45);
      final result = DateTimeUtil.convertToString(date, '');
      expect(result, isEmpty);
    });
  });
}
