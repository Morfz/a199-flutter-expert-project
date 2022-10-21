import 'package:flutter_test/flutter_test.dart';

import '../../dummy_data/dummy_objects.dart';

void main() {
  final Map<String, dynamic> movieTableJson = {
    'id': 1,
    'name': 'name',
    'posterPath': 'posterPath',
    'overview': 'overview',
  };

  test('should return to Json movie table correctly', () {
    final result = testTvTable.toJson();
    expect(result, movieTableJson);
  });
}