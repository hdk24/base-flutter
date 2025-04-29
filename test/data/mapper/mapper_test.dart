import 'package:base_flutter/src/data/mapper/mapper.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('pair', () {
    test('should return pair object', () {
      const String email = 'test@mail.com';
      const int userId = 234;

      // actual
      var result = const Pair(first: email, second: userId);

      // assert
      expect(result.first, equals(email));
      expect(result.second, userId);
    });
  });
}
