import 'package:flutter_test/flutter_test.dart';
import 'package:pantry_io_mobile/core/utils/string_utils.dart';

void main() {
  test('string is capitalized with title case', () {
    final testString = 'this is a test string';

    final result = testString.toTitleCase();

    expect(result, 'This Is A Test String');
  });
}